unit NewBoard;

interface

uses
	Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
	Dialogs, IdAntiFreezeBase, IdAntiFreeze, IdBaseComponent, IdComponent,
	IdTCPConnection, IdTCPClient, IdHTTP, IDException, StdCtrls, IniFiles,
  IdExceptionCore, IndyModule,    // for Indy10
	GikoSystem, BoardGroup, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack,
  IdSSL, IdSSLOpenSSL;

type
	TNewBoardItem = record
		FResponseCode: Integer;
		FContent: string;
	end;

	TNewBoardDialog = class(TForm)
		Label1: TLabel;
		MessageMemo: TMemo;
		UpdateButton: TButton;
	CloseButton: TButton;
		Indy: TIdHTTP;
		StopButton: TButton;
	BoardURLComboBox: TComboBox;
	Label13: TLabel;
	EditIgnoreListsButton: TButton;
	Label2: TLabel;
    SakuCheckBox: TCheckBox;
    IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
		procedure UpdateButtonClick(Sender: TObject);
		procedure StopButtonClick(Sender: TObject);
		procedure CloseButtonClick(Sender: TObject);
		procedure FormCreate(Sender: TObject);
	procedure EditIgnoreListsButtonClick(Sender: TObject);
	procedure FormClose(Sender: TObject; var Action: TCloseAction);
	private
		{ Private �錾 }
		IgnoreLists : TStringList;
		FAbort: Boolean;
		function BoardDownload(const URL: String): TNewBoardItem;
		function BoardLoardFromFile(const FilePath: String): String;
		function UpdateURL(s: string): boolean;
		procedure SetIgnoreCategory(b: boolean);
		procedure EditIgnoreList(Sender: TObject);
		procedure UpdateIgnoreList(Sender: TObject);
        function CheckDeleteItem(ini: TMemIniFile): Boolean;
	public
		{ Public �錾 }
	end;

var
	NewBoardDialog: TNewBoardDialog;


implementation

uses Giko, IdHeaderList, MojuUtils, GikoDataModule;

{$R *.dfm}

procedure TNewBoardDialog.UpdateButtonClick(Sender: TObject);
var
	Item: TNewBoardItem;
	URL : String;
	protocol, host, path, document, port, bookmark: String;
    TabURLs: TStringList;
begin
	try
		MessageMemo.Clear;
		GikoSys.Setting.BoardURLSelected := BoardURLComboBox.ItemIndex + 1;
		FAbort := False;
		UpdateButton.Enabled := False;
		StopButton.Enabled := True;
		CloseButton.Enabled := False;
		EditIgnoreListsButton.Enabled := False;
		URL := BoardURLComboBox.Text;
    GikoSys.Regulate2chURL(URL);    // for 5ch
		GikoSys.ParseURI(URL, protocol, host, path, document, port, bookmark);
		if (protocol = '') then begin
			Item.FContent := BoardLoardFromFile(URL);
		end else if (AnsiPos('http', protocol) > 0) then begin
			Item := BoardDownload(URL);
		end;
		StopButton.Enabled := False;
		if FAbort then
			Exit;
		if Item.FContent <> '' then begin
            TabURLs := TStringList.Create;
            try
                GikoDM.GetTabURLs(TabURLs);
	    		if (UpdateURL(Item.FContent)) then begin
		    		GikoForm.ReloadBBS;
			    end;
                GikoDM.OpenURLs(TabURLs);
            finally
    			TabURLs.Free;
            end;
		end else
			MessageMemo.Lines.Add('�_�E�����[�h�����s���܂���[' + IntToStr(Item.FResponseCode) + ']');
	finally
		UpdateButton.Enabled := True;
		StopButton.Enabled := False;
		CloseButton.Enabled := True;
		EditIgnoreListsButton.Enabled := True;
	end;
end;

procedure TNewBoardDialog.StopButtonClick(Sender: TObject);
begin
	FAbort := True;
	Indy.Disconnect;    // for Indy10
end;

procedure TNewBoardDialog.CloseButtonClick(Sender: TObject);
begin
	Close;
end;

function TNewBoardDialog.BoardDownload(const URL: String): TNewBoardItem;
var
	Stream: TMemoryStream;
	s: string;
	i: Integer;
begin
  TIndyMdl.InitHTTP(Indy);

	Indy.Request.Referer := '';
	Indy.Request.AcceptEncoding := 'gzip';

	Indy.Request.CacheControl := 'no-cache';
	Indy.Request.CustomHeaders.Add('Pragma: no-cache');

//	s := '';
	Stream := TMemoryStream.Create;
	try
		try
			MessageMemo.Lines.Add('�ȉ��̏ꏊ����擾���܂�');
			//MessageMemo.Lines.Add(GikoSys.Setting.BoardURL2ch);
			MessageMemo.Lines.Add(URL);
			MessageMemo.Lines.Add('�_�E�����[�h���J�n���܂�');
			//IdAntiFreeze.Active := True;
      IndyMdl.StartAntiFreeze(20);    // for Indy10
			try
				Indy.Get(URL, Stream);
			finally
				//IdAntiFreeze.Active := False;
        IndyMdl.EndAntiFreeze;        // for Indy10
			end;
			MessageMemo.Lines.Add('�_�E�����[�h���������܂���');
			MessageMemo.Lines.Add('�f�[�^��W�J���܂��F' + IntToStr(Stream.Size) + 'Byte�^' + Indy.Response.ContentEncoding);
			Result.FContent := GikoSys.GzipDecompress(Stream, Indy.Response.ContentEncoding);
			MessageMemo.Lines.Add('�f�[�^�W�J���������܂���');
		except
			on E: EIdConnectException do begin
				MessageMemo.Lines.Add('');
				MessageMemo.Lines.Add('�ڑ������s���܂��� �����v���L�V�AFW�̏�Ԃ𒲂ׂĂ�������');
				MessageMemo.Lines.Add('FW�����Ă���l�͐ݒ���m�F���Ă�������');
				MessageMemo.Lines.Add('NEC��PC�̏ꍇ��PC GATE�����������Ă���\���������ł�');
				MessageMemo.Lines.Add('Message: ' + E.Message);
			end;
			on E: Exception do begin
				if FAbort then
					MessageMemo.Lines.Add('�_�E�����[�h�𒆒f���܂���')
				else begin
					MessageMemo.Lines.Add('�ꗗ�̎擾�Ɏ��s���܂���');
					MessageMemo.Lines.Add('ResponseCode: ' + IntToStr(Indy.ResponseCode));
					MessageMemo.Lines.Add('Message: ' + E.Message);
					MessageMemo.Lines.Add('------------------------');
					for i := 0 to Indy.Response.RawHeaders.Count - 1 do begin
						s := Indy.Response.RawHeaders.Names[i];
						s := s + ': ' + Indy.Response.RawHeaders.Values[s];
						MessageMemo.Lines.Add(s);
					end;
					MessageMemo.Lines.Add('------------------------');
				end;
			end;
		end;
		Result.FResponseCode := Indy.ResponseCode;
	finally
		Stream.Free;
	end;
end;

function TNewBoardDialog.UpdateURL(s: string): boolean;
var
	i: Integer;
	idx: Integer;
	idx1: Integer;
	idx2: Integer;
	tmp: string;
	URL: string;
	Title: string;
	cate: string;
	Board: TBoard;
	Change: Boolean;
	Ignore: Boolean;
	ini: TMemIniFile;
	oldURLs : TStringList;
	newURLs : TStringList;
    SakuIdx: Integer;
begin
	Change := False;
	MessageMemo.Lines.Add('�V�A��URL�ύX�`�F�b�N���J�n���܂�');
	MessageMemo.Lines.Add('');
	s := CustomStringReplace(s, '<B>', '<b>', true);
	s := CustomStringReplace(s, '<BR>', '<br>', true);
	s := CustomStringReplace(s, '</B>', '</b>', true);
	s := CustomStringReplace(s, '<A HREF', '<a href', true);
	s := CustomStringReplace(s, '</A', '</a', true);
	cate := '';

	oldURLs := TStringList.Create;
	newURLs := TStringList.Create;

	try

		GikoSys.ForceDirectoriesEx(GikoSys.GetConfigDir);
		ini := TMemIniFile.Create(GikoSys.GetBoardFileName);
		try
			///
			//�폜�I�v�V�������I������Ă���ꍇ�̓N���A

			ini.Clear;

			while True do begin
				idx1 := AnsiPos('<b>', s);
				idx2 := AnsiPos('<a', s);
//				if (idx1 = 0) and (idx2 = 0) then Break;
				if (idx2 = 0) then Break;   // ����URL�͂Ȃ�

				if idx1 < idx2 then begin
					//<br>
					idx := AnsiPos('</b>', s);
					if idx = 0 then begin
						s := Copy(s, idx1 + 4, Length(s));
						continue;
					end;
					tmp := Copy(s, idx1, (idx - idx1) + 4);
					tmp := CustomStringReplace(tmp, '<b>', '');
					tmp := CustomStringReplace(tmp, '</b>', '');
					Ignore := false;
					for i := 0 to IgnoreLists.Count - 1 do begin
						if tmp = Trim(IgnoreLists[i]) then begin
							cate := '';
							s := Copy(s, idx + 5, Length(s));
							Ignore := True;
							break;
						end;
					end;
					if Ignore then
						Continue;
					{
					if (tmp = '��������') or
						 (tmp = '���ʊ��') or
						 (tmp = '�܂��a�a�r') or
						 (tmp = '�`���b�g') or
						 (tmp = '���G����') or
						 (tmp = '�^�c�ē�') or
						 (tmp = '�c�[����') or
						 (tmp = '���̃T�C�g') then begin
						cate := '';
						s := Copy(s, idx + 5, Length(s));
						Continue;
					end;
					}
					s := Copy(s, idx + 5, Length(s));
					cate := tmp;
				end else begin
					//<a href=
					if cate = '' then begin
						s := Copy(s, idx2 + 2, Length(s));
					end else begin
						idx := AnsiPos('</a>', s);
						tmp := Copy(s, idx2, (idx - idx2) + 4);
						tmp := CustomStringReplace(tmp, '<a href=', '');
						tmp := CustomStringReplace(tmp, '</a>', '');
                        tmp := CustomStringReplace(tmp, 'TARGET=_blank', '');
						i := AnsiPos('>', tmp);
						if i <> 0 then begin
							URL := Trim(Copy(tmp, 1, i - 1));
							Title := Copy(tmp, i + 1, Length(tmp));

              // URL�_�u���N�H�[�e�[�V�����O��
              i := Length(URL);
              if URL[1] = '"' then begin
                i := i - 1;
                URL := Copy(URL, 2, i);
              end;
              if URL[i] = '"' then
                SetLength(URL, i - 1);
              ///---
              // 2�����URL -> 5�����URL
              i := AnsiPos('.2ch.net/', URL);
              if i > 0 then
                URL[i+1] := '5';
              ///---

              if (SakuCheckBox.Checked = True) and (Title = '�폜�v��') then begin
                  SakuIdx := Pos('.5ch.net/saku/', URL);
                  if (SakuIdx > 0) then
                      URL := Copy(URL, 1, SakuIdx - 1) + '.5ch.net/saku2ch/';
              end;
              // BBSs����΍�
              if Length(BBSs) = 0 then begin
                  Board := nil;
              end else begin
                  Board := BBSs[ 0 ].FindBoardFromTitleAndCategory(cate, Title);
                  if Board = nil then
                      Board := BBSs[ 0 ].FindBoardFromURLAndCategory(cate, URL);
              end;
              if Board = nil then begin
                MessageMemo.Lines.Add('�V�ǉ��u' + Title + '(' + URL + ')�v');
                  ini.WriteString(cate, Title, URL);
                  Change := True;
              end else begin
                if Board.URL <> URL then begin
                    MessageMemo.Lines.Add('URL�ύX�u' + Board.Title + '(' + URL +')�v');
                      ini.WriteString(cate, Title, URL);
                      oldURLs.Add(Board.URL);
                      newURLs.Add(URL);
                      Change := True;
                  end else begin
                    ini.WriteString(cate, Title, URL);
                  end;
              end;
						end else begin
							s := Copy(s, idx2 + 2, Length(s));
							Continue;
						end;
						s := Copy(s, idx + 5, Length(s));
					end;
				end;
			end;
            // �J�e�S��/����������������Change�t���O�������Ȃ��Ƃ��̑΍�
            if not Change then begin
                Change := CheckDeleteItem(ini);
            end;
		finally
			if Change then
				ini.UpdateFile;
			ini.Free;
		end;
		MessageMemo.Lines.Add('');
	    if Change then begin
            GikoForm.FavoritesURLReplace(oldURLs, newURLs);
            GikoForm.RoundListURLReplace(oldURLs, newURLs);
            GikoForm.TabFileURLReplace(oldURLs, newURLs);
			MessageMemo.Lines.Add('�V�A��URL�ύX�`�F�b�N���������܂���');
			MessageMemo.Lines.Add('�u����v�{�^���������Ă�������');
		end else
			MessageMemo.Lines.Add('�V�A��URL�ύX�� ����܂���ł���');
    finally
    	oldURLs.Free;
    	newURLs.Free;
	end;
	Result := Change;
end;
//! �폜�J�e�S��/�`�F�b�N
function TNewBoardDialog.CheckDeleteItem(ini: TMemIniFile): Boolean;
var
	URL: string;
	Title: string;
	orgini: TMemIniFile;
    orgStrings, newStrings: TStringList;
    i: Integer;
begin
  Result := False;
    orgini := TMemIniFile.Create(GikoSys.GetBoardFileName);
    orgStrings := TStringList.Create;
    newStrings := TStringList.Create;
    try
        ini.ReadSections(newStrings);
        orgini.ReadSections(orgStrings);
        if (newStrings.Count <> orgStrings.Count) then begin
            //�J�e�S���ǉ��́A���ǉ��ɂȂ�̂Ń`�F�b�N���Ȃ��Ă�����
            //�J�e�S���̍폜�`�F�b�N
            for i := 0 to orgStrings.Count - 1 do begin
                if (newStrings.IndexOf(orgStrings[i]) = -1) then begin
                    MessageMemo.Lines.Add('�J�e�S���폜�u' + orgStrings[i] + '�v');
                end;
            end;
            Result := True;
        end else begin
            // �̐��`�F�b�N
            ini.GetStrings(newStrings);
            orgini.GetStrings(orgStrings);
            if (newStrings.Count <> orgStrings.Count) then begin
                // �̍폜�`�F�b�N
                for i := 0 to orgStrings.Count - 1 do begin
                    if (newStrings.IndexOf(orgStrings[i]) = -1) then begin
                        Title := Copy(orgStrings[i], 1 , AnsiPos('=',orgStrings[i]) - 1);
                        URL := Copy(orgStrings[i],
                            AnsiPos('=',orgStrings[i]) + 1, Length(orgStrings[i]));
                        MessageMemo.Lines.Add('�폜�u' + Title + '(' + URL +')�v');
                    end;
                end;
                Result := True;
            end;
        end;
    finally
        orgStrings.Free;
        newStrings.Free;
        orgini.Free;
    end;
end;
procedure TNewBoardDialog.FormCreate(Sender: TObject);
var
    CenterForm: TCustomForm;
begin
    CenterForm := TCustomForm(Owner);
    if Assigned(CenterForm) then begin
        Left := ((CenterForm.Width - Width) div 2) + CenterForm.Left;
        Top := ((CenterForm.Height - Height) div 2) + CenterForm.Top;
    end else begin
        Left := (Screen.Width - Width) div 2;
        Top := (Screen.Height - Height) div 2;
    end;

	StopButton.Enabled := False;
	BoardURLComboBox.Clear;
	BoardURLComboBox.Items.AddStrings(GikoSys.Setting.BoardURLs);
	try
		BoardURLComboBox.ItemIndex := GikoSys.Setting.BoardURLSelected - 1;
	except
		BoardURLComboBox.ItemIndex := 0;
	end;
	SetIgnoreCategory(false);

    SakuCheckBox.Checked := GikoSys.Setting.SakuBoard;
end;
//�X�V�̏��O�J�e�S�����X�g�̓o�^
{['��������', '���ʊ��', '�܂��a�a�r', '�`���b�g', '���G����', '�^�c�ē�', '�c�[����', '���̃T�C�g']}
procedure TNewBoardDialog.SetIgnoreCategory(b: boolean);
begin
	IgnoreLists := TStringList.Create;
	if not( FileExists(GikoSys.Setting.GetIgnoreFileName) ) or ( b )then begin
		IgnoreLists.Add('��������');
		IgnoreLists.Add('���ʊ��');
		IgnoreLists.Add('�܂��a�a�r');
		IgnoreLists.Add('�`���b�g');
		IgnoreLists.Add('���G����');
		IgnoreLists.Add('�^�c�ē�');
		IgnoreLists.Add('�c�[����');
		IgnoreLists.Add('���̃T�C�g');
	end else begin
		try
			IgnoreLists.LoadFromFile(GikoSys.Setting.GetIgnoreFileName);
		except
			IgnoreLists.Free;
			SetIgnoreCategory(true);
		end;
	end;
end;

procedure TNewBoardDialog.EditIgnoreListsButtonClick(Sender: TObject);
begin
	EditIgnoreList(Sender);
	EditIgnoreListsButton.OnClick := UpdateIgnoreList;
end;
procedure TNewBoardDialog.EditIgnoreList(Sender: TObject);
var
	i: Integer;
begin
	EditIgnoreListsButton.Caption := '���O�J�e�S���[�X�V';
	Label2.Caption := '�e�P�s�ɃJ�e�S�������L�����Ă��������B�i���s��Ctrl+Enter�j';
	UpdateButton.Enabled := false;
	//MessageMemo.ReadOnly := false;
	MessageMemo.Clear;
	for i := 0 to IgnoreLists.Count - 1 do
		MessageMemo.Lines.Add(IgnoreLists[i]);
end;
procedure TNewBoardDialog.UpdateIgnoreList(Sender: TObject);
var
	i: Integer;
begin
	Label2.Caption := '';
    UpdateButton.Enabled := true;
	EditIgnoreListsButton.Caption := '���O�J�e�S���[�ҏW';
	IgnoreLists.Clear;
	for i := 0 to MessageMemo.Lines.Count - 1 do
		IgnoreLists.Add(MessageMemo.Lines[i]);
	IgnoreLists.SaveToFile(GikoSys.Setting.GetIgnoreFileName);
	IgnoreLists.Free;
	SetIgnoreCategory(false);
	//MessageMemo.ReadOnly := true;
	MessageMemo.Clear;
	EditIgnoreListsButton.OnClick := EditIgnoreListsButtonClick;
end;

procedure TNewBoardDialog.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    GikoSys.Setting.SakuBoard := SakuCheckBox.Checked;
	IgnoreLists.Free;
end;
//! ���[�J���t�@�C�������[�h����
function TNewBoardDialog.BoardLoardFromFile(const FilePath: String): String;
var
	html : TStringList;
begin
	Result := '';
	// �t�@�C�������݂��Ă��邩�`�F�b�N
	if (FileExists(FilePath)) then begin
		html := TStringList.Create();
		try
			html.LoadFromFile(FilePath);
			Result := html.Text;
		finally
			html.Free;
		end;
	end;
end;

end.
