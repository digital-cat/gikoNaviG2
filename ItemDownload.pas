unit ItemDownload;

interface

uses
	Windows, SysUtils, Classes, ComCtrls, Controls, Forms, IdHTTP,
	{HTTPApp,} YofUtils, IdGlobal, IdException, IdComponent, IniFiles, {DateUtils,}
	GikoSystem, BoardGroup, ExternalBoardManager, ExternalBoardPlugInMain,
  IdStack, IdExceptionCore, IndyModule,   // for Indy10
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,  // for https
	Sort, SyncObjs, bmRegExp, StrUtils;

type
	TDownloadItem = class;
	TGikoDownloadType = (gdtBoard, gdtThread);
	TGikoDownloadState = (gdsWait, gdsWork, gdsComplete, gdsDiffComplete, gdsNotModify, gdsAbort, gdsError);
	TGikoCgiStatus = (gcsOK, gcsINCR, gcsERR);
	TGikoDLProgress = (gdpStd, gdpAll, gdpDatOchi, gdpOfflaw);

	TGikoWorkEvent = procedure(Sender: TObject; AWorkMode: TWorkMode; const AWorkCount: Integer; ID: Integer) of object;
	TGikoWorkBeginEvent = procedure(Sender: TObject; AWorkMode: TWorkMode; const AWorkCountMax: Integer; ID: Integer; const AWorkTitle: string) of object;
	TGikoWorkEndEvent = procedure(Sender: TObject; AWorkMode: TWorkMode; ID: Integer) of object;
	TDownloadEndEvent = procedure(Sender: TObject; Item: TDownloadItem) of object;
	TDownloadMsgEvent = procedure(Sender: TObject; Item: TDownloadItem; Msg: string; Icon: TGikoMessageIcon) of object;

	TCgiStatus = record
		FStatus: TGikoCgiStatus;
		FSize: Integer;
		FErrText: string;
	end;

	TWorkData = record
	    //FWorkCS: TCriticalSection;
		//IdHttpのOnWork、OnWorkBegin,OnWorkEndは別のスレッドから
        //呼ばれる為、Synchronizeで同期する必要がある。
		//クリティカルセクションは無くてもたぶん平気だけど用心の為。 by eggcake
		FWorkCS: TCriticalSection;
		FSender: TObject;
		FAWorkMode: TWorkMode;
		FAWorkCount: Integer;
		FAWorkCountMax: Integer
	end;
	TDownloadThread = class(TThread)
	private
		FIndy: TIdHttp;
    FSSL: TIdSSLIOHandlerSocketOpenSSL;
		FItem: TDownloadItem;
		FNumber: Integer;
		FAbort: Boolean;
		FMsg: string;
		FIcon: TGikoMessageIcon;
		FSessionID: string;
		FOnWork: TGikoWorkEvent;
		FOnWorkBegin: TGikoWorkBeginEvent;
		FOnWorkEnd: TGikoWorkEndEvent;
		FOnDownloadEnd: TDownloadEndEvent;
		FOnDownloadMsg: TDownloadMsgEvent;
		FDownloadTitle: string;
        FWorkData: TWorkData;

		procedure FireDownloadEnd;
		procedure FireDownloadMsg;
		procedure GetSessionID;
		//procedure WorkBegin(Sender: TObject; AWorkMode: TWorkMode; const AWorkCountMax: Integer);
		procedure WorkBegin(Sender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);   // for Indy10
		procedure WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
		//procedure Work(Sender: TObject; AWorkMode: TWorkMode; const AWorkCount: Integer);
		procedure Work(Sender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);           // for Indy10
//		function ParseCgiStatus(Content: string): TCgiStatus;
//        function ParseRokkaStatus(Content: string): TCgiStatus;
//		function CgiDownload(ItemType: TGikoDownloadType; URL: string; Modified: TDateTime): Boolean;
		function DatDownload(ItemType: TGikoDownloadType; URL: string; Modified: TDateTime; RangeStart: Integer; AdjustLen: Integer): Boolean;
//		procedure DeleteStatusLine(Item: TDownloadItem);
		procedure FireWork;
		procedure FireWorkBegin;
		procedure FireWorkEnd;
//        procedure GetLastModified;
   	protected
		procedure Execute; override;
    //! 5chURLからoysterURL取得
    function GetOysterURL(const URL: String): String;
	public
		property Item: TDownloadItem read FItem write FItem;
		property Number: Integer read FNumber write FNumber;
		constructor Create(CreateSuspended: Boolean);
				destructor Destroy; override;
		procedure Abort;
		property OnWork: TGikoWorkEvent read FOnWork write FOnWork;
		property OnWorkBegin: TGikoWorkBeginEvent read FOnWorkBegin write FOnWorkBegin;
		property OnWorkEnd: TGikoWorkEndEvent read FOnWorkEnd write FOnWorkEnd;
		property OnDownloadEnd: TDownloadEndEvent read FOnDownloadEnd write FOnDownloadEnd;
		property OnDownloadMsg: TDownloadMsgEvent read FOnDownloadMsg write FOnDownloadMsg;
	end;

	TDownloadItem = class(TObject)
	private
		FDownType: TGikoDownloadType;
		FBoard: TBoard;
		FThreadItem: TThreadItem;

		FContentLength: Integer;
		FLastModified: TDateTime;
		FContent: string;
		FResponseCode: Smallint;
		FState: TGikoDownloadState;
		FErrText: string;
		FForceDownload: Boolean;
		FIsAbone : Boolean;
  	FRangeStart: Integer;
	public
		procedure SaveListFile;
		procedure SaveItemFile;

		property DownType: TGikoDownloadType read FDownType write FDownType;
		property Board: TBoard read FBoard write FBoard;
		property ThreadItem: TThreadItem read FThreadItem write FThreadItem;

		property ContentLength: Integer read FContentLength write FContentLength;
		property LastModified: TDateTime read FLastModified write FLastModified;
		property Content: string read FContent write FContent;
		property ResponseCode: Smallint read FResponseCode write FResponseCode;
		property State: TGikoDownloadState read FState write FState;
		property ErrText: string read FErrText write FErrText;
		property ForceDownload: Boolean read FForceDownload write FForceDownload;
		property IsAbone : Boolean read FIsAbone write FIsAbone;
    property RangeStart: Integer read FRangeStart write FRangeStart;
	end;

implementation

uses
	Y_TextConverter, MojuUtils, HTMLCreate, ReplaceDataModule, DmSession5ch;

constructor TDownloadThread.Create(CreateSuspended: Boolean);
begin
	inherited Create(CreateSuspended);
    FWorkData.FWorkCS := TCriticalSection.Create;

	FIndy := TIdHttp.Create(nil);
  FSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil); // for https
  FSSL.SSLOptions.SSLVersions := [sslvTLSv1_2];     // for https
  FSSL.SSLOptions.Method := sslvTLSv1_2;            // for https
  FIndy.IOHandler := FSSL;                          // for https

	FIndy.OnWorkBegin := WorkBegin;
	FIndy.OnWorkEnd := WorkEnd;
	FIndy.OnWork := Work;
end;

destructor TDownloadThread.Destroy;
begin
  TIndyMdl.ClearHTTP(FIndy);
	FIndy.Free;
  FSSL.Free;  // for https
    FWorkData.FWorkCS.Free;
	inherited;
end;

function RFC1123_Date(aDate : TDateTime) : String;
const
	 StrWeekDay : String = 'MonTueWedThuFriSatSun';
	 StrMonth	 : String = 'JanFebMarAprMayJunJulAugSepOctNovDec';
var
	 Year, Month, Day			 : Word;
	 Hour, Min,	 Sec, MSec : Word;
	 DayOfWeek							: Word;
begin
	 DecodeDate(aDate, Year, Month, Day);
	 DecodeTime(aDate, Hour, Min,	 Sec, MSec);
	 DayOfWeek := ((Trunc(aDate) - 2) mod 7);
	 Result := Copy(StrWeekDay, 1 + DayOfWeek * 3, 3) + ', ' +
						 Format('%2.2d %s %4.4d %2.2d:%2.2d:%2.2d',
										[Day, Copy(StrMonth, 1 + 3 * (Month - 1), 3),
										 Year, Hour, Min, Sec]);
end;

procedure TDownloadThread.Execute;
var
	ResStream: TMemoryStream;

	URL: string;
	//CgiStatus: TCgiStatus;
	Modified: TDateTime;
	//RangeStart: Integer;
	AdjustLen: Integer;
	//Idx: Integer;
	ATitle: string;
	DownloadResult: Boolean;
	boardPlugIn 	: TBoardPlugIn;
	lastContent		: string;
	logFile				: TFileStream;
	adjustMargin	: Integer;
//    Host: String;
//    Sep: Integer;
  ResDate: String;
const
	ADJUST_MARGIN	= 16;
begin
	while not Terminated do begin
    Item.RangeStart := 0;
		//===== プラグイン
		FAbort := False;
		boardPlugIn := nil;
		ExternalBoardManager.OnWork				:= Work;
		ExternalBoardManager.OnWorkBegin	:= WorkBegin;
		ExternalBoardManager.OnWorkEnd		:= WorkEnd;

		FDownloadTitle := '';
		case FItem.FDownType of
		gdtBoard:
			begin
				FDownloadTitle := FItem.FBoard.Title;
				if FItem.FBoard <> nil then begin
					if FItem.FBoard.IsBoardPlugInAvailable then begin
						boardPlugIn	:= FItem.FBoard.BoardPlugIn;
						Item.State	:= TGikoDownloadState( boardPlugIn.DownloadBoard( DWORD( FItem.FBoard ) ) );
					end;
				end;
			end;
		gdtThread:
			begin
				FDownloadTitle := FItem.FThreadItem.Title;
				if FItem.FThreadItem <> nil then begin
					if FItem.FThreadItem.ParentBoard.IsBoardPlugInAvailable then begin
						boardPlugIn := FItem.FThreadItem.ParentBoard.BoardPlugIn;
						Item.State	:= TGikoDownloadState( boardPlugIn.DownloadThread( DWORD( FItem.FThreadItem ) ) );
					end;
					//if FItem.FThreadItem.IsBoardPlugInAvailable then begin
					//	boardPlugIn	:= FItem.FThreadItem.BoardPlugIn;
					//	Item.State	:= TGikoDownloadState( boardPlugIn.DownloadThread( DWORD( FItem.FThreadItem ) ) );
					//end;
				end;
			end;
		end;
		if Length(FDownloadTitle) = 0 then
			FDownloadTitle := '（名称不明）';

		if boardPlugIn <> nil then begin
			if FAbort then begin
				Item.State := gdsAbort;
			end;
			if Assigned( OnDownloadEnd ) then
				Synchronize( FireDownloadEnd );
			if Terminated then
				Break;

			Suspend;
			Continue;
		end;

		FAbort := False;
		//===== プラグインを使用しない場合
    TIndyMdl.InitHTTP(FIndy);
		adjustMargin := 0;
		if Item.DownType = gdtThread then begin
			if FileExists( Item.ThreadItem.GetThreadFileName ) then begin
				// dat ファイルの最後を読み出す
				SetLength( lastContent, ADJUST_MARGIN + 1 );
				logFile := TFileStream.Create( Item.ThreadItem.GetThreadFileName, fmOpenRead or fmShareDenyWrite );
				try
					logFile.Seek( -(ADJUST_MARGIN + 1), soFromEnd );
					logFile.Read( lastContent[ 1 ], ADJUST_MARGIN + 1 );
					lastContent := StringReplace( lastContent, #13, '', [] );	// CR の削除
				finally
					logFile.Free;
				end;
			end else begin
        lastContent := '';
			end;
			adjustMargin := Length( lastContent );
		end;

		//FIndy.Request.ContentRangeStart := 0;
    FIndy.Request.Ranges.Text := IndyMdl.MakeRangeHeader(0, 0);  // for Indy10
		FIndy.Request.LastModified := ZERO_DATE;
		ResStream := TMemoryStream.Create;
		try
			try
				//********************
				//DAT or Subject取得
				//********************
				Item.ResponseCode := 0;
				Item.RangeStart := 0;
				AdjustLen := 0;
				Modified := 0;
				if Item.DownType = gdtBoard then begin
					{$IFDEF DEBUG}
					Writeln('Subject取得');
					Writeln('URL: ' + Item.Board.GetReadCgiURL);
					Writeln('Modified: ' + FloatToStr(Item.Board.LastModified));
					{$ENDIF}
					URL := Item.Board.GetReadCgiURL;
					if Item.ForceDownload then begin
						// 強制取得
						ATitle := Item.Board.Title;
						if ATitle = '' then
							ATitle := '（名称不明）';
						FMsg := '★強制取得を行います - [' + ATitle + ']';
						FIcon := gmiWhat;
						if Assigned(OnDownloadMsg) then
							Synchronize(FireDownloadMsg);
						Modified := ZERO_DATE
					end else begin
						Modified := Item.Board.LastModified;
					end;
				end else if Item.DownType = gdtThread then begin
					{$IFDEF DEBUG}
					Writeln('DAT取得');
					Writeln('URL: ' + Item.ThreadItem.GetDatURL);
					Writeln('Modified: ' + FloatToStr(Item.ThreadItem.LastModified));
					{$ENDIF}
					URL := Item.ThreadItem.GetDatURL;
					if Item.ForceDownload then begin
						// 強制取得
						ATitle := Item.ThreadItem.Title;
						if ATitle = '' then
							ATitle := '（名称不明）';
						FMsg := '★強制取得を行います - [' + ATitle + ']';
						FIcon := gmiWhat;
						if (not GikoSys.Setting.KeepNgFile) and FileExists(ChangeFileExt(Item.FThreadItem.GetThreadFileName,'.NG')) then
							DeleteFile(ChangeFileExt(Item.FThreadItem.GetThreadFileName,'.NG'));
						if Assigned(OnDownloadMsg) then
							Synchronize(FireDownloadMsg);
						Modified := ZERO_DATE;
						Item.RangeStart := 0;
						AdjustLen := 0;
					end else begin
						Modified := Item.ThreadItem.LastModified;
						if Item.ThreadItem.Size > 0 then begin
							{$IFDEF DEBUG}
							Writeln('RangeStart: ' + IntToStr(Item.ThreadItem.Size));
							{$ENDIF}
							// あぼーんチェックのため adjustMargin バイト前から取得
							Item.RangeStart := Item.ThreadItem.Size;
							AdjustLen := -adjustMargin;
						end;
					end;
				end;
				Item.IsAbone := False;
				DownloadResult := DatDownload(Item.DownType, URL, Modified, Item.RangeStart, AdjustLen);
				{$IFDEF DEBUG}
				Writeln('ResponseCode: ' + IntToStr(FIndy.ResponseCode));
				{$ENDIF}
				if Item.DownType = gdtThread then begin
					if Item.ResponseCode = 416 then begin
						Item.IsAbone := True;
						DownloadResult := True;
					end else if DownloadResult and (AdjustLen < 0) then begin
						if Copy( Item.Content, 1, adjustMargin ) <> lastContent then
							Item.IsAbone := True;
					end;
				end;

				if Trim(FIndy.Response.RawHeaders.Values['Date']) <> '' then begin
					if Item.DownType = gdtBoard then
						Item.Board.LastGetTime := GikoSys.DateStrToDateTime(FIndy.Response.RawHeaders.Values['Date'])
					else
						Item.ThreadItem.ParentBoard.LastGetTime := GikoSys.DateStrToDateTime(FIndy.Response.RawHeaders.Values['Date']);
				end;

				if DownloadResult then begin
					{$IFDEF DEBUG}
					Writeln('Date:' + FIndy.Response.RawHeaders.Values['Date']);
					{$ENDIF}
					if Item.IsAbone then begin
						{$IFDEF DEBUG}
						Writeln('あぼーん検出');
						{$ENDIF}
						ATitle := Item.ThreadItem.Title;
						if ATitle = '' then
							ATitle := '（名称不明）';
						//差分取得かつ１バイト目がLFでない場合は「あぼーん」されているかもしれんので再取得
						Item.RangeStart := 0;
						AdjustLen := 0;
						FMsg := '★「あぼーん」を検出したので再取得を行います - [' + ATitle + ']';
						FIcon := gmiWhat;
						if (not GikoSys.Setting.KeepNgFile) and FileExists(ChangeFileExt(Item.FThreadItem.GetThreadFileName,'.NG')) then
							DeleteFile(ChangeFileExt(Item.FThreadItem.GetThreadFileName,'.NG'));
						if Assigned(OnDownloadMsg) then
							Synchronize(FireDownloadMsg);
						if not DatDownload(Item.DownType, URL, ZERO_DATE, Item.RangeStart, AdjustLen) then
							Item.State := gdsError;
						{$IFDEF DEBUG}
						Writeln('あぼーん再取得後');
						Writeln('ResponseCode: ' + IntToStr(Item.ResponseCode));
						{$ENDIF}
					end else if (Item.DownType = gdtThread) and (AdjustLen < 0) then begin
						// 差分取得が出来た場合はあぼーんチェック用に取得した余分なサイズを削除
						Item.Content := Copy(Item.Content, adjustMargin + 1, MaxInt);
					end;
				end else begin
					Item.State := gdsError;
					if (Item.DownType = gdtBoard) and (Item.ResponseCode = 302) then begin
						FMsg := '★★板が移転したかもしれないので板更新を行ってください★★';
						FIcon := gmiNG;
						if Assigned(OnDownloadMsg) then
							Synchronize(FireDownloadMsg);
					end;
				end;

				//********************
				//dat.gz取得(1)
				//********************
				if (Item.DownType = gdtThread) and (Item.ResponseCode = 302) then begin
					{$IFDEF DEBUG}
					Writeln('dat.gz取得');
					{$ENDIF}
					ATitle := Item.ThreadItem.Title;
					if ATitle = '' then
						ATitle := '（名称不明）';
					FMsg := '★datが存在しないため過去ログ(dat.gz)を探します - [' + ATitle + ']';
					FIcon := gmiWhat;
					if Assigned(OnDownloadMsg) then
						Synchronize(FireDownloadMsg);
					URL := Item.ThreadItem.GetDatgzURL;
					Modified := Item.ThreadItem.LastModified;
					Item.RangeStart := 0;
					AdjustLen := 0;
					if not DatDownload(Item.DownType, URL, Modified, Item.RangeStart, AdjustLen) then
						Item.State := gdsError;
					{$IFDEF DEBUG}
					Writeln('ResponseCode: ' + IntToStr(Item.ResponseCode));
					{$ENDIF}
				end;

				//********************
				//dat.gz　→　datの取得　2005年6月追加　byもじゅ
				//********************
				if (Item.DownType = gdtThread) and (Item.ResponseCode = 302) then begin
					{$IFDEF DEBUG}
					Writeln('dat取得');
					{$ENDIF}
					FMsg := '過去ログ(dat.gz)が存在しないため過去ログ(dat)を探します - [' + ATitle + ']';
					FIcon := gmiWhat;
					if Assigned(OnDownloadMsg) then
						Synchronize(FireDownloadMsg);
					URL := ChangeFileExt(URL, '');
					Modified := Item.ThreadItem.LastModified;
					Item.RangeStart := 0;
					AdjustLen := 0;
					if not DatDownload(Item.DownType, URL, Modified, Item.RangeStart, AdjustLen) then
						Item.State := gdsError;
					{$IFDEF DEBUG}
					Writeln('ResponseCode: ' + IntToStr(Item.ResponseCode));
					{$ENDIF}
				end;

				//********************
				//dat.gz取得(2)
				//********************
{
				if (Item.DownType = gdtThread) and (Item.ResponseCode = 302) then begin
					ATitle := Item.ThreadItem.Title;
					if ATitle = '' then
						ATitle := '（名称不明）';
					FMsg := '★過去ログ(1)が存在しないため過去ログ(2)から探します - [' + ATitle + ']';
					FIcon := gmiWhat;
					if Assigned(OnDownloadMsg) then
						Synchronize(FireDownloadMsg);
					URL := Item.ThreadItem.GetOldDatgzURL;
					Modified := Item.ThreadItem.LastModified;
					RangeStart := 0;
					AdjustLen := 0;
					if not DatDownload(Item.DownType, URL, Modified, RangeStart, AdjustLen) then
						Item.State := gdsError;
				end;
}

//				if (Item.DownType = gdtThread) and (Item.ResponseCode = 302) then begin
//					{$IFDEF DEBUG}
//					Writeln('offlaw2.soで取得');
//					{$ENDIF}
//					ATitle := Item.ThreadItem.Title;
//					if ATitle = '' then
//						ATitle := '（名称不明）';
//					FMsg := '★dat.gzが存在しないためofflaw2.soを利用します - [' + ATitle + ']';
//					FIcon := gmiWhat;
//					if Assigned(OnDownloadMsg) then
//						Synchronize(FireDownloadMsg);
//					URL := Item.ThreadItem.GetOfflaw2SoURL;
//					Modified := Item.ThreadItem.LastModified;
//					Item.RangeStart := 0;
//					AdjustLen := 0;
//					if not DatDownload(Item.DownType, URL, Modified, Item.RangeStart, AdjustLen) then begin
//						{$IFDEF DEBUG}
//						Writeln('ResponseCode: ' + IntToStr(Item.ResponseCode));
//						{$ENDIF}
//						Item.State := gdsError;
///
//						if (Item.DownType = gdtThread) and (Item.ResponseCode = 302) then begin
//							FMsg := '板が移転したかもしれないので板更新を行ってください。';
//							FIcon := gmiNG;
//							if Assigned(OnDownloadMsg) then
//								Synchronize(FireDownloadMsg);
//						end;
///
//					end else begin
//						{$IFDEF DEBUG}
//						Writeln('ResponseCode: ' + IntToStr(Item.ResponseCode));
//						{$ENDIF}
//						if Item.ResponseCode = 200 then begin
//							{$IFDEF DEBUG}
//							Writeln('CGIStatus: OK');
//							{$ENDIF}
//                            if Copy(Item.Content, 1, 5) = 'ERROR' then begin
//                                {$IFDEF DEBUG}
//                                Writeln('Offlow2Error');
//                                {$ENDIF}
//                                Item.ResponseCode := 404;
//                                Item.State := gdsError;
//                                Item.ErrText := 'スレは存在しないようです。' + Item.Content;
//                            end else begin
//                                GetLastModified;
//                            end;
//						end else begin
//							{$IFDEF DEBUG}
//							Writeln('CGIStatus: 404(ERROR)');
//							{$ENDIF}
//							Item.ResponseCode := 404;
//							Item.State := gdsError;
//							Item.ErrText := CgiStatus.FErrText;
//						end;
//					end;
//				end;

//				if (Item.DownType = gdtThread) and ((Item.ResponseCode = 302) or (Item.ResponseCode = 404)) then begin
//    				FSessionID := '';
//	    			Synchronize(GetSessionID);
//                    if (FSessionID <> '') then begin
//                        {$IFDEF DEBUG}
//                        Writeln('Rokkaで取得');
//                        {$ENDIF}
//                        ATitle := Item.ThreadItem.Title;
//                        if ATitle = '' then
//                            ATitle := '（名称不明）';
//                        FMsg := '★offlow2.soに存在しないためRokkaを利用します - [' + ATitle + ']';
//                        FIcon := gmiWhat;
//                        if Assigned(OnDownloadMsg) then
//                            Synchronize(FireDownloadMsg);
//                        URL := Item.ThreadItem.GetRokkaURL(FSessionID);
//                        Modified := Item.ThreadItem.LastModified;
//                        Item.RangeStart := 0;
//                        AdjustLen := 0;
///
//                        if not DatDownload(Item.DownType, URL, Modified, Item.RangeStart, AdjustLen) then begin
//                            {$IFDEF DEBUG}
//                            Writeln('ResponseCode: ' + IntToStr(Item.ResponseCode));
//                            {$ENDIF}
//                            Item.State := gdsError;
//                        end else begin
//                            CgiStatus := ParseRokkaStatus(Item.Content);
//                            {$IFDEF DEBUG}
//                            Writeln('ResponseCode: ' + IntToStr(Item.ResponseCode));
//                            {$ENDIF}
//                            case CgiStatus.FStatus of
//                                gcsOK: begin
//                                    {$IFDEF DEBUG}
//                                    Writeln('CGIStatus: OK');
//                                    {$ENDIF}
//                                    Item.ResponseCode := 200;
//                                    DeleteStatusLine(Item);
//                                end;
//                                gcsERR: begin
//                                    {$IFDEF DEBUG}
//                                    Writeln('CGIStatus: 404(ERROR)');
//                                    {$ENDIF}
//                                    Item.ResponseCode := 404;
//                                    Item.State := gdsError;
//                                    Item.ErrText := CgiStatus.FErrText;
//                                end;
//                            end;
//                        end;
//                    end;
//				end;

        // DAT落ち／過去ログ取得
				if (Item.DownType = gdtThread) and
           ((Item.ResponseCode = 302) or (Item.ResponseCode = 404)) and
           GikoSys.Is2chURL(URL) and (Item.IsAbone = False) then begin
          {$IFDEF DEBUG}
          Writeln('oysterでDAT落ち／過去ログ取得');
          {$ENDIF}
          ATitle := Item.ThreadItem.Title;
          if ATitle = '' then
              ATitle := '（名称不明）';
          FMsg := '★oysterを利用します - [' + ATitle + ']';
          FIcon := gmiWhat;
          if Assigned(OnDownloadMsg) then
              Synchronize(FireDownloadMsg);
          URL := GetOysterURL(URL);
          Modified := Item.ThreadItem.LastModified;

          DownloadResult := DatDownload(Item.DownType, URL, Modified, Item.RangeStart, AdjustLen);

          {$IFDEF DEBUG}
          Writeln('ResponseCode: ' + IntToStr(Item.ResponseCode));
          {$ENDIF}
          if Item.ResponseCode = 416 then begin
            Item.IsAbone := True;
            DownloadResult := True;
          end else if DownloadResult and (AdjustLen < 0) then begin
            if Copy( Item.Content, 1, adjustMargin ) <> lastContent then
              Item.IsAbone := True;
          end;

          ResDate := FIndy.Response.RawHeaders.Values['Date'];
          if Trim(ResDate) <> '' then begin
              Item.ThreadItem.ParentBoard.LastGetTime := GikoSys.DateStrToDateTime(ResDate);
          end;

          if DownloadResult then begin
            {$IFDEF DEBUG}
            Writeln('Date:' + ResDate);
            {$ENDIF}
            if Item.IsAbone then begin
              {$IFDEF DEBUG}
              Writeln('あぼーん検出');
              {$ENDIF}
              ATitle := Item.ThreadItem.Title;
              if ATitle = '' then
                ATitle := '（名称不明）';
              //差分取得かつ１バイト目がLFでない場合は「あぼーん」されているかもしれんので再取得
              Item.RangeStart := 0;
              AdjustLen := 0;
              FMsg := '★「あぼーん」を検出したので再取得を行います - [' + ATitle + ']';
              FIcon := gmiWhat;
              if (not GikoSys.Setting.KeepNgFile) and FileExists(ChangeFileExt(Item.FThreadItem.GetThreadFileName,'.NG')) then
                DeleteFile(ChangeFileExt(Item.FThreadItem.GetThreadFileName,'.NG'));
              if Assigned(OnDownloadMsg) then
                Synchronize(FireDownloadMsg);
              if not DatDownload(Item.DownType, URL, ZERO_DATE, Item.RangeStart, AdjustLen) then
                Item.State := gdsError;
              {$IFDEF DEBUG}
              Writeln('あぼーん再取得後');
              Writeln('ResponseCode: ' + IntToStr(Item.ResponseCode));
              {$ENDIF}
            end else if AdjustLen < 0 then begin
              // 差分取得が出来た場合はあぼーんチェック用に取得した余分なサイズを削除
              Item.Content := Copy(Item.Content, adjustMargin + 1, MaxInt);
            end;
          end else begin
            Item.State := gdsError;
          end;
				end;
        ///

				//********************
				// 2ch外部板
				//********************
//				if not GikoSys.Is2chHost(GikoSys.UrlToServer(URL)) then begin
//                Host := URL;
//                Sep := Pos('://', Host);
//                if (Sep > 0) then
//                    Delete(Host, 1, Sep + 2);
//                Sep := Pos('/', Host);
//                if (Sep > 0) then
//                    SetLength(Host, Sep - 1);
//				if not GikoSys.Is2chHost(Host) then begin
				if not GikoSys.Is2chURL(URL) then begin
					if (Item.DownType = gdtThread) and (Item.ResponseCode = 404) then begin
						{$IFDEF DEBUG}
						Writeln('外部板過去ログ取得');
						{$ENDIF}
                        ATitle := Item.ThreadItem.Title;
                        if ATitle = '' then
                            ATitle := '（名称不明）';
                        FMsg := '★２ちゃんねる外部板の過去ログ取得を行います - [' + ATitle + ']';
                        FIcon := gmiWhat;
                        if Assigned(OnDownloadMsg) then
                            Synchronize(FireDownloadMsg);
						URL := Item.ThreadItem.GetExternalBoardKakoDatURL;
						Modified := Item.ThreadItem.LastModified;
						Item.RangeStart := 0;
						AdjustLen := 0;
						if not DatDownload(Item.DownType, URL, Modified, Item.RangeStart, AdjustLen) then
							Item.State := gdsError;
						{$IFDEF DEBUG}
						Writeln('ResponseCode: ' + IntToStr(Item.ResponseCode));
						{$ENDIF}
					end;
				end;
(*
				//********************
				//offlaw.cgiで取得
				//********************
				FSessionID := '';
				Synchronize(GetSessionID);
				if (Item.DownType = gdtThread) and (Item.ResponseCode = 302) and (FSessionID <> '') then begin
					{$IFDEF DEBUG}
					Writeln('offlaw.cgiで取得');
					{$ENDIF}
					ATitle := Item.ThreadItem.Title;
					if ATitle = '' then
						ATitle := '（名称不明）';
					FMsg := '★dat.gzが存在しないためofflaw.cgiを利用します - [' + ATitle + ']';
					FIcon := gmiWhat;
					if Assigned(OnDownloadMsg) then
						Synchronize(FireDownloadMsg);
					URL := Item.ThreadItem.GetOfflawCgiURL(FSessionID);
					Modified := Item.ThreadItem.LastModified;
					RangeStart := 0;
					AdjustLen := 0;
					if not DatDownload(Item.DownType, URL, Modified, RangeStart, AdjustLen) then begin
						{$IFDEF DEBUG}
						Writeln('ResponseCode: ' + IntToStr(Item.ResponseCode));
						{$ENDIF}
						Item.State := gdsError;

						if (Item.DownType = gdtThread) and (Item.ResponseCode = 302) then begin
							FMsg := '板が移転したかもしれないので板更新を行ってください。';
							FIcon := gmiNG;
							if Assigned(OnDownloadMsg) then
								Synchronize(FireDownloadMsg);
						end;

					end else begin
						CgiStatus := ParseCgiStatus(Item.Content);
						{$IFDEF DEBUG}
						Writeln('ResponseCode: ' + IntToStr(Item.ResponseCode));
						{$ENDIF}
						case CgiStatus.FStatus of
							gcsOK: begin
								{$IFDEF DEBUG}
								Writeln('CGIStatus: OK');
								{$ENDIF}
								Item.ResponseCode := 200;
								DeleteStatusLine(Item);
							end;
							gcsINCR: begin
								//今はありえない
								{$IFDEF DEBUG}
								Writeln('CGIStatus: 206');
								{$ENDIF}
								Item.ResponseCode := 206;
								DeleteStatusLine(Item);
							end;
							gcsERR: begin
								{$IFDEF DEBUG}
								Writeln('CGIStatus: 404(ERROR)');
								{$ENDIF}
								Item.ResponseCode := 404;
								Item.State := gdsError;
								Item.ErrText := CgiStatus.FErrText;
							end;
						end;
						if (Item.ResponseCode = 404) and (AnsiPos('過去ログ倉庫で発見', Item.ErrText) <> 0) then begin
							{$IFDEF DEBUG}
							Writeln('過去ログ取得');
							{$ENDIF}
							ATitle := Item.ThreadItem.Title;
							if ATitle = '' then
								ATitle := '（名称不明）';
							FMsg := '★過去ログ倉庫で発見 - [' + ATitle + ']';
							FIcon := gmiWhat;
							if Assigned(OnDownloadMsg) then
								Synchronize(FireDownloadMsg);
							Idx := Pos(' ', Item.ErrText);
							if Idx <> 0 then begin
								URL := Copy(Item.ErrText, Idx + 1, Length(Item.ErrText));
								if Pos( '://', URL ) = 0 then begin
									if Pos('../', URL) = 1 then
										URL := Copy(URL, 4, MaxInt );
									if Pos( '/', URL ) = 1 then
										URL := Copy( URL, 2, MaxInt );
									URL := GikoSys.UrlToServer(Item.ThreadItem.ParentBoard.URL) + URL;
								end;
								Modified := Item.ThreadItem.LastModified;
								RangeStart := 0;
								AdjustLen := 0;
								if not DatDownload(Item.DownType, URL, Modified, RangeStart, AdjustLen) then
									Item.State := gdsError;
								{$IFDEF DEBUG}
								Writeln('ResponseCode: ' + IntToStr(Item.ResponseCode));
								{$ENDIF}
							end;
						end;
					end;
				end else begin
					if (Item.DownType = gdtThread) and (Item.ResponseCode = 302) and (FSessionID = '') then begin
						{$IFDEF DEBUG}
						Writeln('ログインされてないので過去ログ取得不可');
						{$ENDIF}
						ATitle := Item.ThreadItem.Title;
						if ATitle = '' then
							ATitle := '（名称不明）';
						FMsg := '★ログインされていないため探すことが出来ません - [' + ATitle + ']';
						FIcon := gmiSAD;
						if Assigned(OnDownloadMsg) then
							Synchronize(FireDownloadMsg);
					end;
				end;
*)
				case Item.ResponseCode of
					200: Item.State := gdsComplete;
					206: Item.State := gdsDiffComplete;
					304: Item.State := gdsNotModify;
					else
						Item.State := gdsError;
				end;
			except
				Item.State := gdsError;
			end;
			if FAbort then
				Item.State := gdsAbort;
		finally
			if Assigned(OnDownloadEnd) then
				Synchronize(FireDownloadEnd);
			ResStream.Free;
		end;

    TIndyMdl.ClearHTTP(FIndy);

		if Terminated then Break;
		Suspend;
	end;
end;

{ 5chURLからoysterURL取得

https://kizuna.5ch.net/test/read.cgi/morningcoffee/1689062903/

・稼働中のスレッド
/板名/dat/スレッドキー.dat
例： https://agree.5ch.net/operate/dat/1608930977.dat

・DAT落ちした現役サーバに収容されているスレッド
/板名/oyster/スレッドキー上位4桁の数字/スレッドキー.dat
例： https://agree.5ch.net/operate/oyster/1684/1684064837.dat

・過去ログサーバに収容されているスレッド
/板名/oyster/スレッドキー上位4桁の数字/スレッドキー.dat
例： https://natto.5ch.net/food/oyster/1021/1021787092.dat
例： https://mamono.5ch.net/newsplus/oyster/1237/1237017133.dat
}
function TDownloadThread.GetOysterURL(const URL: String): String;
var
  idx: Integer;
  url1: String;
  dat: String;
  oysURL: String;
begin
  Result := URL;

  if GikoSys.Is2chURL(URL) = False then
    Exit;
  idx := AnsiPos('/dat/', URL);
  if idx < 1 then
    Exit;

  url1 := Copy(URL, 1, idx - 1);
  idx := idx + 4;
  dat := Copy(URL, idx + 1, Length(URL) - idx);

  oysURL := Format('%s/oyster/%s/%s', [url1, Copy(dat, 1, 4), dat]);

  FSessionID := '';
  Synchronize(GetSessionID);
  if (FSessionID <> '') then
      oysURL := oysURL + '?sid=' + FSessionID;  // これはRokkaと同じやり方。もしかしてヘッダに設定が正解？

  Result := oysURL;
end;


//function TDownloadThread.CgiDownload(ItemType: TGikoDownloadType; URL: string; Modified: TDateTime): Boolean;
//var
//	ResponseCode: Integer;
//	ResStream: TMemoryStream;
//begin
//	ResponseCode := -1;
//	//FIndy.Request.ContentRangeStart := 0;
//	//FIndy.Request.ContentRangeEnd := 0;
//  FIndy.Request.Ranges.Text := IndyMdl.MakeRangeHeader(0, 0);  // for Indy10
///
//	FIndy.Request.CustomHeaders.Clear;
//	if (Modified <> 0) and (Modified <> ZERO_DATE) then begin
//		FIndy.Request.LastModified := modified - OffsetFromUTC;
//	end;
//	FIndy.Request.AcceptEncoding := '';
//	FIndy.Request.Accept := 'text/html';
//	ResStream := TMemoryStream.Create;
//	try
//		try
//			ResStream.Clear;
//			{$IFDEF DEBUG}
//			Writeln('URL: ' + URL);
//			{$ENDIF}
//			FIndy.Get(URL, ResStream);
//			Item.Content := GikoSys.GzipDecompress(ResStream, FIndy.Response.ContentEncoding);
//			Item.LastModified := FIndy.Response.LastModified;
//			//差分取得で１バイト前からとってきたときはマイナスする
//			Item.ContentLength := Length(Item.Content);
//			//無いと思うけど。。。
//			if Item.Content = '' then
//				Result := False
//			else
//				Result := True;
//			{$IFDEF DEBUG}
//			Writeln('取得で例外なし');
//			{$ENDIF}
//			ResponseCode := FIndy.ResponseCode;
//		except
//			on E: EIdSocketError do begin
//				Item.Content := '';
//				Item.LastModified := ZERO_DATE;
//				Item.ContentLength := 0;
//				Item.ErrText := E.Message;
//				Result := False;
//				ResponseCode := -1;
//				Screen.Cursor := crDefault;
//			end;
//			on E: EIdConnectException do begin
//				Item.Content := '';
//				Item.LastModified := ZERO_DATE;
//				Item.ContentLength := 0;
//				Item.ErrText := E.Message;
//				Result := False;
//				ResponseCode := -1;
//				Screen.Cursor := crDefault;
//			end;
//			on E: Exception do begin
//				{$IFDEF DEBUG}
//				Writeln('取得で例外あり');
//				Writeln('E.Message: ' + E.Message);
//				{$ENDIF}
//				Item.Content := '';
//				Item.LastModified := ZERO_DATE;
//				Item.ContentLength := 0;
//				Item.ErrText := E.Message;
//				ResponseCode := FIndy.ResponseCode;
//				Result := False;
//				Screen.Cursor := crDefault;
//			end;
//		end;
//	finally
//		if (Item.ContentLength = 0) and (ResponseCode = 206) then
//			Item.ResponseCode := 304
//		else
//			Item.ResponseCode := ResponseCode;
//		ResStream.Free;
//	end;
//end;

function TDownloadThread.DatDownload(ItemType: TGikoDownloadType; URL: string; Modified: TDateTime; RangeStart: Integer; AdjustLen: Integer): Boolean;
var
	ResponseCode: Integer;
	ResStream: TMemoryStream;
  url2: String;
begin
  GikoSys.Regulate2chURL(URL);  // for 5ch
	url2 := GikoSys.GetActualURL(URL);
	ResponseCode := -1;

	if (ItemType = gdtThread) and (RangeStart > 0) then begin
		//FIndy.Request.ContentRangeStart := RangeStart + AdjustLen;
		//FIndy.Request.ContentRangeEnd := 0;
    FIndy.Request.Ranges.Text := IndyMdl.MakeRangeHeader(RangeStart + AdjustLen, 0);  // for Indy10
	end else begin
		//FIndy.Request.ContentRangeStart := 0;
		//FIndy.Request.ContentRangeEnd := 0;
    FIndy.Request.Ranges.Text := IndyMdl.MakeRangeHeader(0, 0);  // for Indy10
	end;

	FIndy.Request.CustomHeaders.Clear;
	FIndy.Request.CacheControl := 'no-cache';
	FIndy.Request.CustomHeaders.Add('Pragma: no-cache');
	if (Modified <> 0) and (Modified <> ZERO_DATE) then begin
		FIndy.Request.LastModified := modified - OffsetFromUTC;
	end;
	if RangeStart = 0 then
		FIndy.Request.AcceptEncoding := 'gzip'
	else
		FIndy.Request.AcceptEncoding := '';
	ResStream := TMemoryStream.Create;
	try
		try
			ResStream.Clear;
			{$IFDEF DEBUG}
			Writeln('URL: ' + url2);
			{$ENDIF}
			FIndy.Get(url2, ResStream);
			IndyMdl.SaveCookies(FIndy);
      
			Item.Content := GikoSys.GzipDecompress(ResStream, FIndy.Response.ContentEncoding);
			Item.ContentLength := Length(Item.Content) + AdjustLen;
			// 置換する
			if GikoSys.Setting.ReplaceDat then begin
				Item.Content := ReplaceDM.Replace(Item.Content);
			end;
			Item.LastModified := FIndy.Response.LastModified;
			if Item.Content = '' then
				Result := False
			else
				Result := True;
			{$IFDEF DEBUG}
			Writeln('取得で例外なし');
			{$ENDIF}
			ResponseCode := FIndy.ResponseCode;
		except
			on E: EIdSocketError do begin
				Item.Content := '';
				Item.LastModified := ZERO_DATE;
				Item.ContentLength := 0;
				Item.ErrText := E.Message;
				Result := False;
				ResponseCode := -1;
				Screen.Cursor := crDefault;
			end;
			on E: EIdConnectException do begin
				Item.Content := '';
				Item.LastModified := ZERO_DATE;
				Item.ContentLength := 0;
				Item.ErrText := E.Message;
				Result := False;
				ResponseCode := -1;
				Screen.Cursor := crDefault;
			end;
			on E: Exception do begin
				{$IFDEF DEBUG}
				Writeln('取得で例外あり');
				Writeln('E.Message: ' + E.Message);
				{$ENDIF}
				Item.Content := '';
				Item.LastModified := ZERO_DATE;
				Item.ContentLength := 0;
				Item.ErrText := E.Message;
				ResponseCode := FIndy.ResponseCode;
				Result := False;
				Screen.Cursor := crDefault;
			end;
		end;
	finally
		if (Item.ContentLength = 0) and (ResponseCode = 206) then
			Item.ResponseCode := 304
		else
			Item.ResponseCode := ResponseCode;
		ResStream.Free;
	end;
end;

procedure TDownloadThread.FireDownloadEnd;
begin
	OnDownloadEnd(self, Item);
end;

procedure TDownloadThread.FireDownloadMsg;
begin
	OnDownloadMsg(Self, Item, FMsg, FIcon);
end;

procedure TDownloadThread.GetSessionID;
begin
	FSessionID := Session5ch_SessionID;
end;

procedure TDownloadThread.Abort;
begin
	FAbort := True;
	//FIndy.DisconnectSocket;
	FIndy.Disconnect;     // for Indy10
	if socket <> nil then begin
		//socket.DisconnectSocket;
		socket.Disconnect;  // for Indy10
	end;
end;

procedure TDownloadThread.WorkBegin(Sender: TObject;
//AWorkMode: TWorkMode; const AWorkCountMax: Integer);
AWorkMode: TWorkMode; AWorkCountMax: Int64);  // for Indy10
begin
	if Assigned(OnWorkBegin) then begin
		FWorkData.FWorkCS.Acquire;
		try
			FWorkData.FSender := Sender;
			FWorkData.FAWorkMode := AWorkMode;
			FWorkData.FAWorkCountMax := AWorkCountMax;
			Synchronize(FireWorkBegin);
		finally
			FWorkData.FWorkCS.Release;
		end;
	end;
end;

procedure TDownloadThread.WorkEnd(Sender: TObject;
AWorkMode: TWorkMode);
begin
	if Assigned(OnWorkEnd) then begin;
		FWorkData.FWorkCS.Acquire;
		try
			FWorkData.FSender := Sender;
			FWorkData.FAWorkMode := AWorkMode;
			Synchronize(FireWorkEnd);
		finally
			FWorkData.FWorkCS.Release;
		end;
	end;
end;

procedure TDownloadThread.Work(Sender: TObject; AWorkMode:
//TWorkMode; const AWorkCount: Integer);
TWorkMode; AWorkCount: Int64);    // for Indy10
begin
	if Assigned(OnWork) then begin
		FWorkData.FWorkCS.Acquire;
		try
			FWorkData.FSender := Sender;
			FWorkData.FAWorkMode := AWorkMode;
			FWorkData.FAWorkCount := AWorkCount;
			Synchronize(FireWork);
		finally
			FWorkData.FWorkCS.Release;
		end;
	end;
end;

//ここから新規メソッド
procedure TDownloadThread.FireWorkBegin;
begin
	OnWorkBegin(FWorkData.FSender, FWorkData.FAWorkMode,
        FWorkData.FAWorkCountMax,
		FNumber, FDownloadTitle);
end;

procedure TDownloadThread.FireWorkEnd;
begin
	OnWorkEnd(FWorkData.FSender, FWorkData.FAWorkMode,
		FNumber);
end;

procedure TDownloadThread.FireWork;
begin
	OnWork(FWorkData.FSender, FWorkData.FAWorkMode,
        FWorkData.FAWorkCount,
		FNumber);
end;

//function TDownloadThread.ParseCgiStatus(Content: string): TCgiStatus;
//var
//	StatusLine: string;
//	Line: string;
//	Idx: Integer;
//	Status: string;
//	Size: string;
//	Msg: string;
//begin
//// [+OK] の場合は差分
//// [-INCR] (Incorrect)の場合はすべてのデータ
//// [-ERR (テキスト)]の場合はなんかエラー
//// 例：+OK 23094/512K
////		 -INCR 23094/512K
////		 -ERR そんな板ないです
//	Idx := AnsiPos(#10, Content);
//	StatusLine := Copy(Content, 0, Idx);
///
//	Idx := AnsiPos(' ', Content);
//	Status := Copy(StatusLine, 0, Idx - 1);
//	Line := Copy(StatusLine, Idx + 1, Length(StatusLine));
///
////	Idx := AnsiPos('/', Line);
//	if Trim(Status) = '-ERR' then
//		Msg := Trim(Line)
//	else
//		Size := Copy(Line, 0, Idx - 1);
///
//	if Trim(Status) = '+OK' then
//		Result.FStatus := gcsOK
//	else if Trim(Status) = '-INCR' then
//		Result.FStatus := gcsINCR
//	else if Trim(Status) = '-ERR' then begin
//		Result.FStatus := gcsERR;
//		Result.FErrText := Msg;
//		Result.FSize := 0;
//		Exit;
//	end else begin
//		{$IFDEF DEBUG}
//		Writeln(Status);
//		{$ENDIF}
//		Result.FStatus := gcsERR;
//		Result.FErrText := 'エラーなんだけど、よく分からないエラー';
//		Result.FSize := 0;
//		Exit;
//	end;
///
//	if GikoSys.IsNumeric(Size) then
//		Result.FSize := StrToInt(Size)
//	else begin
//		Result.FSize := 0;
//		Result.FStatus := gcsERR;
//		Result.FErrText := 'ステータス解析失敗[' + StatusLine + ']';
//	end;
//end;

//function TDownloadThread.ParseRokkaStatus(Content: string): TCgiStatus;
//var
//	StatusLine: string;
//	Idx: Integer;
//	Status: string;
//begin
////	　レスポンス : 1行目にrokkaの処理結果が記述されます
////	　　"Success XXX"　- 成功　XXXにdatの状態（取得元）が記述されます
////	　　　　　　　　　　　Live　　　　ライブスレッド
////	　　　　　　　　　　　Pool　　　　dat落ちスレッド
////	　　　　　　　　　　　Archive 　　過去ログ
////	　　　　　　　　　　 以降の行にDAT形式(name<>email<>datetime<>body<>[title])でログが記述されています
////	　　"Error XXX"　　- 何らかのエラーです　XXX がエラーコードです。
////	　　　　　　　　　　　13 　　　not found　　　　　　要求されたdatが見つかりませんでした
////	　　　　　　　　　　　8008135　inputError 　　　　　リクエストURLのSERVERかBOARDが正しくないです
////	　　　　　　　　　　　666　　　urlError 　　　　　　OPTIONSまたはQueryStringが正しくないです
////	　　　　　　　　　　　69 　　　authenticationError　KAGIが不正（有効期限切れその他）
////	　　　　　　　　　　　420　　　timeLimitError 　　　アクセス間隔が短すぎます
////	　　　　　　　　　　　42 　　　methodError　　　　　そのHTTPメソッドは許可されていません
//	Idx := AnsiPos(#10, Content);
//    if (Idx > 0) then
//	    StatusLine := Copy(Content, 0, Idx)
//    else
//        StatusLine := Content;
///
//    if (AnsiPos('Success', StatusLine) = 1) then begin
//		Result.FStatus := gcsOK;
//        Delete(StatusLine, 1, 7);
//        Status := Trim(StatusLine);
//        if (Status = 'Live') then                   // 多分これは来ない
//    		Result.FErrText := '取得成功（ライブスレッド）'
//        else if (Status = 'Pool') then
//    		Result.FErrText := '取得成功（dat落ちスレッド）'
//        else if (Status = 'Archive') then
//    		Result.FErrText := '取得成功（過去ログ）'
//        else    // ???
//    		Result.FErrText := '取得成功';
//    end
//    else if (AnsiPos('Error', StatusLine) = 1) then begin
//		Result.FStatus := gcsERR;
//        Delete(StatusLine, 1, 5);
//        Status := Trim(StatusLine);
//        if (Status = '13') then
//    		Result.FErrText := '要求されたdatが見つかりませんでした'
//        else if (Status = '8008135') then
//    		Result.FErrText := 'リクエストURLのSERVERかBOARDが正しくないです'
//        else if (Status = '666') then
//    		Result.FErrText := 'OPTIONSまたはQueryStringが正しくないです'
//        else if (Status = '69') then
//    		Result.FErrText := 'KAGIが不正（有効期限切れその他）'
//        else if (Status = '20') then
//    		Result.FErrText := 'アクセス間隔が短すぎます'
//        else if (Status = '42') then
//    		Result.FErrText := 'そのHTTPメソッドは許可されていません'
//        else    // ???
//    		Result.FErrText := '取得エラー[' + Status + ']';
//    end
//    else begin
//		Result.FStatus := gcsERR;
//		Result.FErrText := 'ステータス解析失敗[' + StatusLine + ']';
//    end;
//	Result.FSize := 0;
//end;

//１行目を消して、コンテンツサイズを設定する
//procedure TDownloadThread.DeleteStatusLine(Item: TDownloadItem);
//var
//	SList: TStringList;
//begin
//	SList := TStringList.Create;
//	try
//		SList.Text := Item.Content;
//		//1行目を削除
//		if SList.Count > 1 then
//			SList.Delete(0);
//        Item.Content := SList.Text;
//		//改行コードをCRLF -> LFと考えて、行数分だけマイナス
//        Item.ContentLength := Length(SList.Text) - SList.Count;
//	finally
//		SList.Free;
//	end;
//end;

procedure TDownloadItem.SaveListFile;
var
	i: Integer;
	index: Integer;
	NewItem: TThreadItem;
	NumCount: Integer;
	Body: TStringList;
	Rec: TSubjectRec;
	{$IFDEF DEBUG}
	st, rt : Cardinal;
	{$ENDIF}
	function MakeThreadCallBack(
		inInstance	: DWORD;	// TBoardItem のインスタンス
		inURL				: PChar;	// スレッドの URL
		inTitle			: PChar;	// スレタイ
		inCount			: DWORD		// レスの数
	) : Boolean; stdcall;		// 列挙を続けるなら True
	var
		_ThreadItem	: TThreadItem;	// '_' はクラスのプロパティとかぶってるので
		boardItem		: TBoard;
	begin
		Result		:= True;
		boardItem	:= TBoard( inInstance );

		boardItem.IntData := boardItem.IntData + 1;
		if boardItem.IntData < (boardItem.Count shr	 2) then
			index := boardItem.GetIndexFromURL( string( inURL ) )
		else
			index := boardItem.GetIndexFromURL( string( inURL ), True );
		if index = -1 then begin
			//新しいスレッド
			_ThreadItem := TThreadItem.Create( boardItem.BoardPlugIn, boardItem, string( inURL ) );

			_ThreadItem.Title					:= string( inTitle );
			_ThreadItem.AllResCount		:= inCount;
			_ThreadItem.ParentBoard		:= Board;
			_ThreadItem.No						:= boardItem.IntData;
			_ThreadItem.RoundDate 		:= ZERO_DATE;
			_ThreadItem.LastModified	:= ZERO_DATE;
			_ThreadItem.AgeSage	 			:= gasNew;
			boardItem.Add(_ThreadItem);
		end else begin
			//順位が上がっていればAgeにする
			if boardItem.Items[index].No > boardItem.IntData then
				boardItem.Items[index].AgeSage := gasAge
			//順位が上がってないけど、レスがついてたら、Sageに
			else if boardItem.Items[index].AllResCount <> Integer(inCount) then
				boardItem.Items[index].AgeSage := gasSage
			//順位上がってないし、レスの増減も無ければ、None
			else
				boardItem.Items[index].AgeSage := gasNone;

			boardItem.Items[index].No						:= boardItem.IntData;
			boardItem.Items[index].AllResCount	:= Integer(inCount);
		end;

	end;
begin
{$IFDEF DEBUG}
	st := GetTickCount;
	Writeln('SAVELIST');
{$ENDIF}
	//Board.ListData := TList.Create;
	Body := TStringList.Create;
	try
		//ダウンロード日時設定（ローカル日時）
		Board.RoundDate := Now;
		//サーバ上ファイルの更新時刻設定
		Board.LastModified := LastModified;


		//dat落ちスレのソート順を決定するためにソートする
		if GikoSys.Setting.DatOchiSortIndex >= 0 then begin
			Sort.SetSortNoFlag(true);
			Sort.SetSortOrder(GikoSys.Setting.DatOchiSortOrder);
			Sort.SetSortIndex(GikoSys.Setting.DatOchiSortIndex);
			//Sort.SortNonAcquiredCountFlag := GikoSys.Setting.NonAcquiredCount;
			Board.CustomSort(ThreadItemSortProc);
		end;

{$IFDEF DEBUG}
	rt := GetTickCount - st;
	Writeln('END Sortd' + IntToStr(rt) + ' ms');
{$ENDIF}

		for i := Board.Count - 1 downto 0 do
			Board.Items[i].AgeSage := gasNull;

		if Board.IsBoardPlugInAvailable then begin
			// 新しいリストを作成する
			// 新しいリストに古いリストのログがあるならそれを新しいリストに追加
			// 古いログがなければ、新たにスレオブジェクトを作成
			Board.IntData := 0;
{$IFDEF DEBUG}
	rt := GetTickCount - st;
	Writeln('Start Enum' + IntToStr(rt) + ' ms');
{$ENDIF}

			//これが遅い　要改善
			Board.BeginUpdate;
			Board.BoardPlugIn.EnumThread( DWORD( Board ), @MakeThreadCallBack );
			Board.EndUpdate;

{$IFDEF DEBUG}
	rt := GetTickCount - st;
	Writeln('End Enum' + IntToStr(rt) + ' ms');
{$ENDIF}

			//古いリストにしかないやつらを削除
			for i := Board.Count - 1 downto 0 do begin
				if( Board.Items[i].AgeSage = gasNull )and not (Board.Items[i].IsLogFile) then
					Board.Delete(i);
			end;

			// 新しいリストに無かったアイテムを新しいリストに追加
			for i := 0 to Board.Count - 1 do begin
				if(Board.Items[i].AgeSage = gasNull) and (Board.Items[i].IsLogFile) then begin
					Board.IntData := Board.IntData + 1;
					Board.Items[i].No						:= Board.IntData;
					Board.Items[i].AllResCount	:= Board.Items[i].Count;
					Board.Items[i].NewResCount	:= 0;
					Board.Items[i].AgeSage			:= gasArch;
				end;
			end;

		end else begin
			//新しいリストを作成する
			//新しいリストに古いリストのログがあるならそれを新しいリストに追加
			//古いログがなければ、新たにスレオブジェクトを作成
			Body.Text := Content;
			NumCount := 0;
			for i := 0 to Body.Count - 1 do begin
				Rec := GikoSys.DivideSubject(Body[i]);
				Rec.FFileName := Trim(Rec.FFileName);
				if (Rec.FTitle = '') and (Rec.FCount = 0) then Continue;
				Inc(NumCount);
				index := Board.GetIndexFromFileName(Rec.FFileName);
				if index = -1 then begin
					//新しいスレッド
					NewItem := TThreadItem.Create(
								nil,
                                Board,
                                GikoSys.Get2chBoard2ThreadURL( Board, ChangeFileExt( Rec.FFileName, '' ) ) );
					NewItem.Title := Rec.FTitle;
					NewItem.AllResCount := Rec.FCount;
					NewItem.ParentBoard := Board;
					NewItem.No := NumCount;
					NewItem.RoundDate := ZERO_DATE;
					NewItem.LastModified := ZERO_DATE;
					NewItem.AgeSage := gasNew;
					Board.Add(NewItem);
				end else begin
					if Board.Items[index].No > NumCount then
						Board.Items[index].AgeSage := gasAge
					else if Board.Items[index].AllResCount < Rec.FCount then
						Board.Items[index].AgeSage := gasSage
					else
						Board.Items[index].AgeSage := gasNone;

					Board.Items[index].No := NumCount;
					Board.Items[index].AllResCount := Rec.FCount;
				end;
			end;
			//古いリストの削除
			for i := Board.Count - 1 downto 0 do begin
				if( Board.Items[i].AgeSage = gasNull )and not (Board.Items[i].IsLogFile) then
					Board.Delete(i);
			end;

			//新しいリストに無かったアイテムの更新
			for i := 0 to Board.Count - 1 do begin
				if( Board.Items[i].AgeSage = gasNull )and (Board.Items[i].IsLogFile) then begin
					inc(NumCount);
					Board.Items[i].No := NumCount;
					Board.Items[i].AllResCount := Board.Items[i].Count;
					Board.Items[i].NewResCount := 0;
					Board.Items[i].AgeSage := gasArch;
				end;
			end;
			//リスト(subject.txt)を保存
			GikoSys.ForceDirectoriesEx(ExtractFilePath(Board.GetSubjectFileName));
            Body.Text := MojuUtils.Sanitize(Body.Text);
			Body.SaveToFile(Board.GetSubjectFileName);
		end;
	finally
		Body.Free;
	end;


end;

{procedure TDownloadItem.SaveListFile;
var
	i: Integer;
	index: Integer;
	NewItem: TThreadItem;
	NewList: TList;
//	SaveCount: Integer;
	NumCount: Integer;
	Body: TStringList;
	Rec: TSubjectRec;
begin
	NewList := TList.Create;
	Body := TStringList.Create;
	try
		//巡回日時設定
		Board.RoundDate := Now;
		//サーバ上ファイルの更新時刻設定
		Board.LastModified := LastModified;

		//リスト保存件数取得
		//SaveCount := MaxInt;

		//古いリストからログ無しアイテムを削除
		for i := Board.Count - 1 downto 0 do
			if not Board.Items[i].IsLogFile then
				Board.Delete(i);

		//新しいリストを作成する
		//新しいリストに古いリストのログがあるならそれを新しいリストに追加
		//古いログがなければ、新たにスレオブジェクトを作成
		Body.Text := Content;
//		Loop := Min(Body.Count, SaveCount);
		NumCount := 0;
//		for i := 0 to Loop - 1 do begin
		for i := 0 to Body.Count - 1 do begin
			if i = 0 then Continue;	//１行目はステータス行のため処理なし

			Rec := GikoSys.DivideSubject(Body[i]);
			if (Rec.FTitle = '') and (Rec.FCount = 0) then Continue;
			Inc(NumCount);
			index := Board.GetIndex(Rec.FFileName);
			if index = -1 then begin
				NewItem := TThreadItem.Create;
				NewItem.FileName := Rec.FFileName;
				NewItem.Title := Rec.FTitle;
				NewItem.Count := Rec.FCount;
				NewItem.ParentBoard := Board;
				NewItem.No := NumCount;
				NewItem.RoundDate := ZERO_DATE;
				NewItem.LastModified := ZERO_DATE;
				NewList.Add(NewItem);
			end else begin
				//Board.Items[index].Count := Count;
				Board.Items[index].No := NumCount;
				NewList.Add(Board.Items[index]);
				Board.DeleteList(index);
			end;
		end;

		//新しいリストに無かった古いログ有りアイテムを新しいリストに追加
		for i := 0 to Board.Count - 1 do begin
			inc(NumCount);
			Board.Items[i].No := NumCount;
			NewList.Add(Board.Items[i]);
		end;

		//古いリストを消す（リストのみ。スレオブジェクト自体は消さない）
		for i := Board.Count - 1 downto 0 do
			Board.DeleteList(i);

		//新しいリストをボードオブジェクトに追加
		for i := 0 to NewList.Count - 1 do
			Board.Add(TThreadItem(NewList[i]));

		//リスト(subject.txt)を保存
//		GikoSys.ForceDirectoriesEx(GikoSys.GetLogDir + Board.BBSID);
//		Body.SaveToFile(GikoSys.GetSubjectFileName(Board.BBSID));
		GikoSys.ForceDirectoriesEx(ExtractFilePath(Board.GetSubjectFileName));
		Body.SaveToFile(Board.GetSubjectFileName);
	finally
		Body.Free;
		NewList.Free;
	end;
end;
}
procedure TDownloadItem.SaveItemFile;
var
	Body, oldBody: TStringList;
	Cnt: Integer;
	OldCnt: Integer;
	FileName: string;
	ini: TMemIniFile;
	Res: TResRec;
	NewRes: Integer;
	finish : Boolean;
	loopCnt : Integer;
	LastIdx	: Integer;
begin
	FileName := ThreadItem.GetThreadFileName;

	//if not ThreadItem.IsBoardPlugInAvailable then begin
    if not ThreadItem.ParentBoard.IsBoardPlugInAvailable then begin
		if Trim(Content) = '' then
			Exit;

		GikoSys.ForceDirectoriesEx(ExtractFilePath(FileName));

		//	Cnt := 0;
		Body := TStringList.Create;
		NewRes := 0;
		OldCnt := 0;
		try
		//		if FileExists(FileName) and (ResponseCode = 206) then begin
			//if FileExists(FileName) and (State = gdsDiffComplete) then begin
			if FileExists(FileName) and (State = gdsDiffComplete) and (self.RangeStart > 0) then begin  // Indy10でレスポンスコード変わった？
				loopCnt := 10;
				repeat
					finish := true;
					try
						Body.LoadFromFile(FileName);
						OldCnt := Body.Count;
						Body.Text := Body.Text + Content;
						Body.SaveToFile(FileName);
						NewRes := Body.Count - OldCnt;
					except
						on E:EFOpenError do begin
							sleep(10);
							Dec(loopCnt);
							if loopCnt > 0 then
								finish := false;
						end;
					end;
				until finish;
				//Cnt := Body.Count;
			end else begin
				if IsAbone then begin
					// あぼーんを検出したのでここまで読んだと新着レス番のつけなおし
					oldBody := TStringList.Create;
					try
						loopCnt := 10;
						repeat
							finish := true;
							try
								oldBody.LoadFromFile(FileName);
							except
								on E:EFOpenError do begin
									sleep(10);
									Dec(loopCnt);
									if loopCnt > 0 then
										finish := false
									else
										finish := true;
								end;
							end;
						until finish;

						Body.Text := Content;
						if (ThreadItem.Kokomade > 0) and (ThreadItem.Kokomade <= oldBody.Count) then begin
							ThreadItem.Kokomade := Body.IndexOf(oldBody.Strings[ ThreadItem.Kokomade - 1 ]);
							if ThreadItem.Kokomade <> -1 then ThreadItem.Kokomade := ThreadItem.Kokomade + 1;
						end;

						LastIdx := oldBody.Count;
						repeat
							Dec(LastIdx);
							OldCnt := Body.IndexOf(oldBody.Strings[ LastIdx ]) + 1;
						until ( OldCnt <> 0 ) or (LastIdx = 0);

						if OldCnt >= Body.Count then OldCnt := Body.Count - 1;
						NewRes := Body.Count - OldCnt;

						// ここまで読んだが新着レス番を超さないように(異常終了時のリカバリ)
						if ThreadItem.Kokomade > OldCnt then begin
							if OldCnt > 0 then
								ThreadItem.Kokomade := OldCnt
							else
								ThreadItem.Kokomade := 1;
						end;

					finally
						oldBody.Free;
					end;

				end else begin
					Body.Text := Content;
					//ThreadItem.Count := 0;
					OldCnt := 0;
					NewRes := Body.Count;
					//Cnt := Body.Count;
				end;
	//			if Body.Count > 0 then
	//				Body.Delete(0);
				Body.SaveToFile(FileName);

				if ThreadItem.Title = '' then begin
					THTMLCreate.DivideStrLine(Body[0], @Res);
					ThreadItem.Title := Res.FTitle;
				end;
				ThreadItem.Size := 0;
			end;
			Cnt := Body.Count;
		finally
			Body.Free;
		end;

		ThreadItem.Size := ThreadItem.Size + ContentLength;
		ThreadItem.LastModified := LastModified;
		ThreadItem.Count := Cnt;
		//ThreadItem.AllResCount := Cnt;
		ThreadItem.NewResCount := NewRes;
		ThreadItem.NewReceive := OldCnt + 1;
	end;
	ThreadItem.AllResCount := ThreadItem.Count;
	ThreadItem.IsLogFile := True;
	ThreadItem.RoundDate := Now;
	if not ThreadItem.UnRead then begin
		ThreadItem.UnRead := True;
	end;
//	if ThreadItem.RoundNo = 6 then
//		ThreadItem.RoundNo := 0;

	//異常終了時はインデックスが更新されないため、テンポラリを作成する。
	//正常終了時には削除
	//異常終了時は、次回起動時にテンポラリを見て更新
	ini := TMemIniFile.Create(ChangeFileExt(FileName, '.tmp'));
	try
		ini.WriteDateTime('Setting', 'RoundDate', ThreadItem.RoundDate);
		ini.WriteDateTime('Setting', 'LastModified', ThreadItem.LastModified);
		ini.WriteInteger('Setting', 'Size', ThreadItem.Size);
		ini.WriteInteger('Setting', 'Count', ThreadItem.Count);
		ini.WriteInteger('Setting', 'AllResCount', ThreadItem.AllResCount);
		ini.WriteInteger('Setting', 'NewResCount', ThreadItem.NewResCount);
		ini.WriteInteger('Setting', 'NewReceive', ThreadItem.NewReceive);
//		ini.WriteInteger('Setting', 'RoundNo', ThreadItem.RoundNo);
//		ini.WriteBool('Setting', 'Round', ThreadItem.Round);
		ini.WriteBool('Setting', 'UnRead', ThreadItem.UnRead);
		ini.UpdateFile;
	finally
		ini.Free;
	end;
end;

//procedure TDownloadThread.GetLastModified;
//var
//	ResultDate: TDateTime;
//	ResList: TStringList;
//	LastRes: String;
//	KwPos: Integer;
//    ResRow: Integer;
////    DTIdx: Integer;
//    Ok: Boolean;
//    AWKStr: TAWKStr;
//	RStart: Integer;
//	RLength: Integer;
//begin
//	AWKStr := TAWKStr.Create(nil);
//    Ok := False;
//	ResultDate := Item.LastModified;
//	ResList := TStringList.Create;
//	try
//		ResList.Text := Item.Content;
//        for ResRow := ResList.Count - 1 downto 0 do begin
//            if (ResRow > 999) then
//                continue;
//			LastRes := ResList.Strings[ResRow];
//			KwPos := Pos('<>', LastRes);
//			if (KwPos < 1) then
//                continue;
//			Delete(LastRes, 1, KwPos + 1);
//			KwPos := Pos('<>', LastRes);
//			if (KwPos < 1) then
//                continue;
//			Delete(LastRes, 1, KwPos + 1);
//			// '2013/04/22(月) 02:32:36'
//			SetLength(LastRes, 23);
//			Delete(LastRes, 11, 4);		// 曜日削除
///
//            // 日付確認
////            AWKStr.RegExp := '(\d{4})/(0[1-9]|1[0-2])/(0[1-9]|[12][0-9]|3[01])';
//            AWKStr.RegExp := '(19|20)([0-9][0-9])/(0[1-9]|1[0-2])/(0[1-9]|[12][0-9]|3[01])';
//        	if (AWKStr.Match(AWKStr.ProcessEscSeq(LastRes), RStart, RLength) = 1) then begin
///
//                AWKStr.RegExp := '([01][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])';
//                if (AWKStr.Match(AWKStr.ProcessEscSeq(LastRes), RStart, RLength) < 1) then begin
//        			SetLength(LastRes, 10);
//                    LastRes := LastRes + ' 00:00:00';
//                end;
///
//                try
//                    ResultDate := StrToDateTime(LastRes);
//                    Ok := True;
//                except
//                end;
//            end;
//            if (Ok = True) then
//                break;
//		end;
//	finally
//		ResList.Free;
//	end;
//    Item.LastModified :=ResultDate;
//	FreeAndNil(AWKStr);
//end;

end.
