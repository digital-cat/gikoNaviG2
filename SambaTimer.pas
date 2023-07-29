unit SambaTimer;

interface

uses
	Windows, SysUtils, Classes, ExtCtrls,
    BoardGroup, GikoSystem;

type
    {
    \brief  Samba24対策タイマークラス
    }
    TSambaTimer = class(TTimer)
    private
        FKey : string;
        FWriteDeta : TDateTime;
        FSambaInterval : Integer;
        procedure ReadSambaTime;
        procedure ReadSettingTime(Board: TBoard);
    public
        function SetBoard(Board : TBoard): integer;
        function CheckSambaTime(ATime: TDateTime): Boolean;
        procedure WriteSambaTime(ATime: TDateTime);
        procedure UpdateSambaSetting(Interval : Integer);
        function Update : TDateTime;
        property WriteDeta : TDateTime read FWriteDeta;
        property SambaInterval : Integer read FSambaInterval;
    end;

implementation

uses
    IniFiles, DateUtils;
{
\brief  サンバタイマー板情報設定
\param  Board   レスエディタの板
\return Sambaの設定値
}
function TSambaTimer.SetBoard(Board : TBoard): Integer;
begin
    Result := -1;
    Enabled := False;
    if (GikoSys.Setting.UseSamba) and (Board <> nil) then begin
        // 板が2chに属している場合，タイマーを有効にする
        if (Board.Is2ch) then begin
            ReadSettingTime(Board);
            ReadSambaTime;
            Interval := 500;
            Result := FSambaInterval;
        end;
    end;
end;
{
\brief Sambaの規定値を読み込む
}
procedure TSambaTimer.ReadSettingTime(Board: TBoard);
var
	ini :TMemIniFile;
	Protocol, Host, Path, Document, Port, Bookmark : string;
begin
	Enabled := false; //経過秒数表示TimerをOffにする
	ini := TMemIniFile.Create(GikoSys.GetSambaFileName);
	try
        if (Board <> nil) then begin
            // まずBBSIDで個別に設定されていないか確認する
            FKey := '@' + Board.BBSID;
            FSambaInterval := ini.ReadInteger('Setting', FKey, -1);
            if (FSambaInterval = -1) then begin
                // 設定されていないのでホスト名の設定を取ってくる
                GikoSys.ParseURI( Board.URL, Protocol, Host, Path, Document, Port, Bookmark );
                FKey := Copy(Host, 1, AnsiPos('.', Host) - 1);
                FSambaInterval := ini.ReadInteger('Setting', FKey, -1);
		        //設定されていないときは、ファイルに書きたす。
		        if FSambaInterval = -1 then begin
                    FSambaInterval := 0;
    			    ini.WriteInteger('Setting', FKey, 0);
	    		    ini.UpdateFile;
		        end;
            end;
        end else begin
            FSambaInterval := ini.ReadInteger('Setting', FKey, -1);
        end;
	finally
		ini.Free;
	end;
	Enabled := true; //経過秒数表示TimerをOnにする
end;

{
\brief Samba.iniの書き込み時間を読み込む
}
procedure TSambaTimer.ReadSambaTime;
var
	ini :TMemIniFile;
begin
	Enabled := false; //経過秒数表示TimerをOffにする
	ini := TMemIniFile.Create(GikoSys.GetSambaFileName);
	try
		 //文字列で読み取って、変換関数でTDateTimeへ
		 FWriteDeta := ConvertDateTimeString(
                ini.ReadString('Send', FKey, ''));
	finally
		ini.Free;
	end;
	Enabled := true; //経過秒数表示TimerをOnにする
end;
{
\brief  Samba.iniに最終書き込み時間を書き込む
}
procedure TSambaTimer.WriteSambaTime(ATime: TDateTime);
var
	ini :TMemIniFile;
begin
	ini := TMemIniFile.Create(GikoSys.GetSambaFileName);
	try
		ini.WriteDateTime('Send', FKey, ATime);
		ini.UpdateFile;
	finally
		ini.Free;
	end;
end;

{
\brief  最終書き込み時間と現在時を比較する
\return 真：規定値以上　偽：規定値未満
}
function TSambaTimer.CheckSambaTime(ATime: TDateTime): Boolean;
var
	pastsec: double;
begin
	pastsec := SecondSpan(ATime, FWriteDeta);
	Result := (pastsec > FSambaInterval);
end;
{
\breif  タイマー情報更新
}
function TSambaTimer.Update : TDateTime;
begin
    ReadSettingTime( nil );
    ReadSambaTime;
    Result := Now();
end;
{
\biref  Samba設定値更新
\param  Interval    設定値
}
procedure TSambaTimer.UpdateSambaSetting(Interval : Integer);
var
	ini :TMemIniFile;
begin
	Enabled := false; //経過秒数表示TimerをOffにする
	ini := TMemIniFile.Create(GikoSys.GetSambaFileName);
	try
        FSambaInterval := Interval;
        ini.WriteInteger('Setting', FKey, FSambaInterval);
        ini.UpdateFile;
	finally
		ini.Free;
	end;
	Enabled := true; //経過秒数表示TimerをOnにする
end;

end.
