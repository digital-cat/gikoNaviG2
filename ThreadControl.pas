unit ThreadControl;

interface

uses
	SysUtils, Classes, Controls, Forms, IdHTTP, IdComponent,
	{HTTPApp,} YofUtils, GikoSystem, BoardGroup, ItemDownload;

type
	TThreadControl = class(TThread)
	private
		FItemList: TThreadList;					// ダウンロードするアイテムを格納するリスト
		FAbort: Boolean;								// 中断フラグ
		FThreadList: TList;							// 実際にダウンロードするスレッドオブジェクトのリスト
		FMaxThreadCount: Integer;				// 最大スレッド数
		FOnWork: TGikoWorkEvent;
		FOnWorkBegin: TGikoWorkBeginEvent;
		FOnWorkEnd: TGikoWorkEndEvent;
		FOnDownloadEnd: TDownloadEndEvent;
		FOnDownloadMsg: TDownloadMsgEvent;
		procedure WorkBegin(Sender: TObject; AWorkMode: TWorkMode; const AWorkCountMax: Integer; Number: Integer; const AWorkTitle: string);
		procedure WorkEnd(Sender: TObject; AWorkMode: TWorkMode; Number: Integer);
		procedure Work(Sender: TObject; AWorkMode: TWorkMode; const AWorkCount: Integer; Number: Integer);
		procedure DownloadEnd(Sender: TObject; Item: TDownloadItem);
		procedure DownloadMsg(Sender: TObject; Item: TDownloadItem; Msg: string; Icon: TGikoMessageIcon);
		procedure SetMaxThreadCount(Count: Integer);
	protected
		procedure Execute; override;
	public
		constructor Create(CreateSuspended: Boolean);
		destructor Destroy; override;
		procedure AddItem(Item: TDownloadItem);
		function GetSuspendThread: TDownloadThread;
		function GetActiveThreadCount: Integer;
		procedure DownloadAbort;
		property MaxThreadCount: Integer read FMaxThreadCount write SetMaxThreadCount;
		property OnWork: TGikoWorkEvent read FOnWork write FOnWork;
		property OnWorkBegin: TGikoWorkBeginEvent read FOnWorkBegin write FOnWorkBegin;
		property OnWorkEnd: TGikoWorkEndEvent read FOnWorkEnd write FOnWorkEnd;
		property OnDownloadEnd: TDownloadEndEvent read FOnDownloadEnd write FOnDownloadEnd;
		property OnDownloadMsg: TDownloadMsgEvent read FOnDownloadMsg write FOnDownloadMsg;
	end;

implementation

constructor TThreadControl.Create(CreateSuspended: Boolean);
begin
	inherited Create(CreateSuspended);
	FItemList := TThreadList.Create;
	FThreadList := TList.Create;

	FAbort := False;
end;

destructor TThreadControl.Destroy;
var
	i: Integer;
begin
    FThreadList.Pack;
	for i := FThreadList.Count - 1 downto 0 do begin
    	TDownloadThread(FThreadList[i]).Free;
	end;
    FThreadList.Capacity := FThreadList.Count;
	FThreadList.Free;
    FItemList.Clear;
	FItemList.Free;
	inherited;
end;

procedure TThreadControl.AddItem(Item: TDownloadItem);
begin
	FItemList.Add(Item);
end;

procedure TThreadControl.Execute;
var
	List: TList;
	i: Integer;
	FDownThread: TDownloadThread;
begin
	while not Terminated do begin
		Sleep(10);
		List := FItemList.LockList;
		try
			if List.Count > 0 then begin
				FDownThread := GetSuspendThread;
				if FDownThread <> nil then begin
					FDownThread.Item := TDownloadItem(List.Items[0]);
					List.Delete(0);
					FDownThread.Resume;
				end;
			end;
		finally
			FItemList.UnlockList;
		end;
		if FAbort then begin
			for i := 0 to FThreadList.Count - 1 do begin
				if not TDownloadThread(FThreadList[i]).Suspended then
					TDownloadThread(FThreadList[i]).Abort;
			end;
			List := FItemList.LockList;
			try
				List.Clear;
			finally
				FItemList.UnlockList;
			end;
			FAbort := False;
		end;
        Application.ProcessMessages;
	end;
    // 残っているスレッドを全て終了させる。
	for i := 0 to FThreadList.Count - 1 do begin
        TDownloadThread(FThreadList[i]).Abort;
		TDownloadThread(FThreadList[i]).Terminate;
		if TDownloadThread(FThreadList[i]).Suspended then begin
			TDownloadThread(FThreadList[i]).Resume;
            TDownloadThread(FThreadList[i]).WaitFor;
        end;
	end;

end;

function TThreadControl.GetSuspendThread: TDownloadThread;
var
	i: Integer;
	DownloadThread: TDownloadThread;
begin
	Result := nil;
	if GetActiveThreadCount >= FMaxThreadCount then Exit;
	for i := 0 to FThreadList.Count - 1 do begin
		if TDownloadThread(FThreadList[i]).Suspended then begin
			Result := TDownloadThread(FThreadList[i]);
			Break;
		end;
	end;
	if (Result = nil) and (FMaxThreadCount > FThreadList.Count) then begin
		DownloadThread := TDownloadThread.Create(True);
		DownloadThread.FreeOnTerminate := False;
		DownloadThread.Number := FThreadList.Count;
		DownloadThread.OnWorkBegin := WorkBegin;
		DownloadThread.OnWorkEnd := WorkEnd;
		DownloadThread.OnWork := Work;
		DownloadThread.OnDownloadEnd := DownloadEnd;
		DownloadThread.OnDownloadMsg := DownloadMsg;
		FThreadList.Add(DownloadThread);
		Result := DownloadThread;
	end;
end;

function TThreadControl.GetActiveThreadCount: Integer;
var
	i: Integer;
begin
	Result := 0;
	for i := 0 to FThreadList.Count - 1 do begin
		if not TDownloadThread(FThreadList[i]).Suspended then
			Inc(Result);
	end;
end;

procedure TThreadControl.DownloadAbort;
begin
	FAbort := True;
end;

procedure TThreadControl.SetMaxThreadCount(Count: Integer);
begin
	if FMaxThreadCount = Count then Exit;
	if Count <= 0 then Count := 1;
	if Count > 10 then Count := 10;
	FMaxThreadCount := Count;
end;

procedure TThreadControl.WorkBegin(Sender: TObject; AWorkMode: TWorkMode; const AWorkCountMax: Integer; Number: Integer; const AWorkTitle: string);
begin
	if Assigned(OnWorkBegin) then
		OnWorkBegin(Sender, AWorkMode, AWorkCountMax, Number, AWorkTitle);
end;

procedure TThreadControl.WorkEnd(Sender: TObject; AWorkMode: TWorkMode; Number: Integer);
begin
	if Assigned(OnWorkEnd) then
		OnWorkEnd(Sender, AWorkMode, Number);
end;

procedure TThreadControl.Work(Sender: TObject; AWorkMode: TWorkMode; const AWorkCount: Integer; Number: Integer);
begin
	if Assigned(OnWork) then
		OnWork(Sender, AWorkMode, AWorkCount, Number);
end;

procedure TThreadControl.DownloadEnd(Sender: TObject; Item: TDownloadItem);
begin
	if Assigned(OnDownloadEnd) then
		OnDownloadEnd(Sender, Item);
end;

procedure TThreadControl.DownloadMsg(Sender: TObject; Item: TDownloadItem; Msg: string; Icon: TGikoMessageIcon);
begin
	if Assigned(OnDownloadMsg) then
		OnDownloadMsg(Sender, Item, Msg, Icon);
end;

end.
