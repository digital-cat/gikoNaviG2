unit SambaTimer;

interface

uses
	Windows, SysUtils, Classes, ExtCtrls,
    BoardGroup, GikoSystem;

type
    {
    \brief  Samba24�΍�^�C�}�[�N���X
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
\brief  �T���o�^�C�}�[���ݒ�
\param  Board   ���X�G�f�B�^�̔�
\return Samba�̐ݒ�l
}
function TSambaTimer.SetBoard(Board : TBoard): Integer;
begin
    Result := -1;
    Enabled := False;
    if (GikoSys.Setting.UseSamba) and (Board <> nil) then begin
        // ��2ch�ɑ����Ă���ꍇ�C�^�C�}�[��L���ɂ���
        if (Board.Is2ch) then begin
            ReadSettingTime(Board);
            ReadSambaTime;
            Interval := 500;
            Result := FSambaInterval;
        end;
    end;
end;
{
\brief Samba�̋K��l��ǂݍ���
}
procedure TSambaTimer.ReadSettingTime(Board: TBoard);
var
	ini :TMemIniFile;
	Protocol, Host, Path, Document, Port, Bookmark : string;
begin
	Enabled := false; //�o�ߕb���\��Timer��Off�ɂ���
	ini := TMemIniFile.Create(GikoSys.GetSambaFileName);
	try
        if (Board <> nil) then begin
            // �܂�BBSID�Ōʂɐݒ肳��Ă��Ȃ����m�F����
            FKey := '@' + Board.BBSID;
            FSambaInterval := ini.ReadInteger('Setting', FKey, -1);
            if (FSambaInterval = -1) then begin
                // �ݒ肳��Ă��Ȃ��̂Ńz�X�g���̐ݒ������Ă���
                GikoSys.ParseURI( Board.URL, Protocol, Host, Path, Document, Port, Bookmark );
                FKey := Copy(Host, 1, AnsiPos('.', Host) - 1);
                FSambaInterval := ini.ReadInteger('Setting', FKey, -1);
		        //�ݒ肳��Ă��Ȃ��Ƃ��́A�t�@�C���ɏ��������B
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
	Enabled := true; //�o�ߕb���\��Timer��On�ɂ���
end;

{
\brief Samba.ini�̏������ݎ��Ԃ�ǂݍ���
}
procedure TSambaTimer.ReadSambaTime;
var
	ini :TMemIniFile;
begin
	Enabled := false; //�o�ߕb���\��Timer��Off�ɂ���
	ini := TMemIniFile.Create(GikoSys.GetSambaFileName);
	try
		 //������œǂݎ���āA�ϊ��֐���TDateTime��
		 FWriteDeta := ConvertDateTimeString(
                ini.ReadString('Send', FKey, ''));
	finally
		ini.Free;
	end;
	Enabled := true; //�o�ߕb���\��Timer��On�ɂ���
end;
{
\brief  Samba.ini�ɍŏI�������ݎ��Ԃ���������
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
\brief  �ŏI�������ݎ��Ԃƌ��ݎ����r����
\return �^�F�K��l�ȏ�@�U�F�K��l����
}
function TSambaTimer.CheckSambaTime(ATime: TDateTime): Boolean;
var
	pastsec: double;
begin
	pastsec := SecondSpan(ATime, FWriteDeta);
	Result := (pastsec > FSambaInterval);
end;
{
\breif  �^�C�}�[���X�V
}
function TSambaTimer.Update : TDateTime;
begin
    ReadSettingTime( nil );
    ReadSambaTime;
    Result := Now();
end;
{
\biref  Samba�ݒ�l�X�V
\param  Interval    �ݒ�l
}
procedure TSambaTimer.UpdateSambaSetting(Interval : Integer);
var
	ini :TMemIniFile;
begin
	Enabled := false; //�o�ߕb���\��Timer��Off�ɂ���
	ini := TMemIniFile.Create(GikoSys.GetSambaFileName);
	try
        FSambaInterval := Interval;
        ini.WriteInteger('Setting', FKey, FSambaInterval);
        ini.UpdateFile;
	finally
		ini.Free;
	end;
	Enabled := true; //�o�ߕb���\��Timer��On�ɂ���
end;

end.
