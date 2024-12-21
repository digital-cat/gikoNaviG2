unit IndividualAbon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, CheckLst;

type
  TIndividualAbonForm = class(TForm)
    BitBtnCancel: TBitBtn;
    BitBtnAll: TBitBtn;
    ButtonReversal: TButton;
    CheckListBoxNo: TCheckListBox;
    PanelTop: TPanel;
    Label1: TLabel;
    PanelRight: TPanel;
    ButtonChkAll: TButton;
    ButtonUnchkAll: TButton;
    GroupBox1: TGroupBox;
    procedure ButtonReversalClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtnAllClick(Sender: TObject);
    procedure ButtonChkAllClick(Sender: TObject);
    procedure ButtonUnchkAllClick(Sender: TObject);
    procedure CheckListBoxNoClickCheck(Sender: TObject);
  private
	{ Private 宣言 }
	FThreadLogFileName: String;
	FNGFileName: String;
	FDeleteList: TStringList;
  public
	{ Public 宣言 }
	FRepaint : boolean;
	ResNumber : Integer;
	function SetThreadLogFileName(AFileName: String): boolean;
	function DeleteNG(AResNum: Integer): boolean;
	property DeleteList : TStringList read FDeleteList write FDeleteList;
  end;

var
  IndividualAbonForm: TIndividualAbonForm;

implementation

{$R *.dfm}

{ 選択レス番号のあぼーん解除 }
procedure TIndividualAbonForm.ButtonReversalClick(Sender: TObject);
var
	NGFile: TStringList;
	i, j: Integer;

	str: String;
  No: String;
begin
  FRepaint := False;

  if not FileExists(FNGFileName) then
    Exit;

  NGFile := TStringList.Create;
  try
    try
      NGFile.LoadFromFile(FNGFileName);

      for i := 0 to CheckListBoxNo.Items.Count - 1 do begin
        if CheckListBoxNo.Checked[i] then begin
          No := Trim(CheckListBoxNo.Items[i]);
          str := No + '-';
          for j := 0 to NGFile.Count - 1 do begin
            if AnsiPos(str, NGFile[j]) = 1 then begin
              FRepaint := True;
              DeleteList.Add(No);
              NGFile.Delete(j);
              Break;
            end;
          end;
          if NGFile.Count < 1 then
            Break;
        end;
      end;

      if NGFile.Count > 0 then
        NGFile.SaveToFile(FNGFileName)
      else
        DeleteFile(FNGFileName);
    except
    end;
  finally
    NGFile.Free;
  end;
end;

{ あぼーんレス番号読み込み }
function TIndividualAbonForm.SetThreadLogFileName(AFileName: String): boolean;
var
	NGFile: TStringList;
	i: Integer;
	str: String;
begin
	FThreadLogFileName := AFileName;
	FNGFileName := ChangeFileExt(AFileName, '.NG');
	Result := false;
	if FileExists(FNGFileName) then begin
		NGFile := TStringList.Create;
		try
			try
				NGFile.LoadFromFile(FNGFileName);
        CheckListBoxNo.Items.Clear;
        CheckListBoxNo.Sorted := true;
				for i := 0 to NGFile.Count - 1do begin
					str := Copy(NGFile.Strings[i], 1, AnsiPos('-', NGFile.Strings[i]) - 1);
					if str <> '' then
            CheckListBoxNo.Items.Add(Format('%4s', [str]));
				end;
				if CheckListBoxNo.Items.Count > 0 then
					Result := true;

			except
				Result := false;
			end;
		finally
			NGFile.Free;
		end;
	end;
end;

{ 指定レス番号のあぼーん解除 }
function TIndividualAbonForm.DeleteNG(AResNum: Integer): boolean;
var
	NGFile: TStringList;
	i, j: Integer;

	str: String;
begin
	Result := false;
	if (FileExists(FNGFileName)) and (AResNum > 0) then begin
		NGFile := TStringList.Create;
		try
			try
				NGFile.LoadFromFile(FNGFileName);
				str := IntToStr(AResNum) + '-';
				i := -1;
				for j := 0 to NGFile.Count - 1 do begin
					if AnsiPos(str, NGFile[j]) = 1 then begin
						i := j;
						break;
					end;
				end;
				if i >= 0 then begin
					Result := true;
					NGFile.Delete(i);
					if NGFile.Count = 0 then
						DeleteFile(FNGFileName)
					else
						NGFile.SaveToFile(FNGFileName);
				end;
			except
			end;
		finally
			NGFile.Free;
		end;
	end;
end;

{ フォーム作成イベント }
procedure TIndividualAbonForm.FormCreate(Sender: TObject);
begin
	FDeleteList := TStringList.Create;
end;

{ フォーム破棄イベント }
procedure TIndividualAbonForm.FormDestroy(Sender: TObject);
begin
	FDeleteList.Free;
end;

{ 全あぼーん解除 }
procedure TIndividualAbonForm.BitBtnAllClick(Sender: TObject);
var
	NGFile: TStringList;
	i{, j}: Integer;

	str: String;
begin
	if (FileExists(FNGFileName)) then begin
		NGFile := TStringList.Create;
		try
			try
				FRepaint := False;
				NGFile.LoadFromFile(FNGFileName);
				for i := 0 to CheckListBoxNo.Items.Count - 1 do begin
					str := Trim(CheckListBoxNo.Items[i]);
					if( Length(str) > 0 ) then begin
						FRepaint := True;
						DeleteList.Add(str);
					end;
				end;
        DeleteFile(FNGFileName);
			except
			end;
		finally
			NGFile.Free;
		end;
	end;
end;

{ 全てチェック }
procedure TIndividualAbonForm.ButtonChkAllClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to CheckListBoxNo.Items.Count - 1 do
    CheckListBoxNo.Checked[i] := True;

  ButtonReversal.Enabled := (CheckListBoxNo.Items.Count > 0);
end;

{ 全てチェック解除 }
procedure TIndividualAbonForm.ButtonUnchkAllClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to CheckListBoxNo.Items.Count - 1 do
    CheckListBoxNo.Checked[i] := False;

  ButtonReversal.Enabled := False;
end;

{ チェック変更イベント }
procedure TIndividualAbonForm.CheckListBoxNoClickCheck(Sender: TObject);
var
  i: Integer;
  enb: Boolean;
begin
  enb := False;

  for i := 0 to CheckListBoxNo.Items.Count - 1 do begin
    if CheckListBoxNo.Checked[i] then begin
      enb := True;
      Break;
    end;
  end;

  ButtonReversal.Enabled := enb;
end;

end.
