unit IndividualAbon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TIndividualAbonForm = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Button1: TButton;
    Panel2: TPanel;
    Label1: TLabel;
    ComboBox1: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
	{ Private éŒ¾ }
	FThreadLogFileName: String;
	FNGFileName: String;
	FDeleteList: TStringList;
  public
	{ Public éŒ¾ }
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

procedure TIndividualAbonForm.Button1Click(Sender: TObject);
var
	NGFile: TStringList;
	i, j: Integer;

	str: String;
begin
	if (FileExists(FNGFileName)) and (ComboBox1.ItemIndex >= 0) then begin
		NGFile := TStringList.Create;
		try
			try
				NGFile.LoadFromFile(FNGFileName);
				str := ComboBox1.Items[ComboBox1.ItemIndex] + '-';
				i := -1;
				for j := 0 to NGFile.Count - 1 do begin
					if AnsiPos(str, NGFile[j]) = 1 then begin
						i := j;
						break;
					end;
				end;

				if i >= 0 then begin
					FRepaint := true;
					DeleteList.Add(Copy(str, 1, Length(str) - 1));
					NGFile.Delete(i);
					if NGFile.Count = 0 then
						DeleteFile(FNGFileName)
					else
						NGFile.SaveToFile(FNGFileName);
				end else
					FRepaint := false;
			except
			end;
		finally
			NGFile.Free;
		end;
	end;
end;
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
				ComboBox1.Items.Clear;
                ComboBox1.Sorted := true;
				for i := 0 to NGFile.Count - 1do begin
					str := Copy(NGFile.Strings[i], 1, AnsiPos('-', NGFile.Strings[i]) - 1);
					if str <> '' then
						ComboBox1.Items.Add(str);
				end;
				if ComboBox1.Items.Count > 0 then
					Result := true;

			except
				Result := false;
			end;
		finally
			NGFile.Free;
		end;
	end;
end;
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

procedure TIndividualAbonForm.FormCreate(Sender: TObject);
begin
	FDeleteList := TStringList.Create;
end;

procedure TIndividualAbonForm.FormDestroy(Sender: TObject);
begin
	FDeleteList.Free;
end;

procedure TIndividualAbonForm.BitBtn2Click(Sender: TObject);
var
	NGFile: TStringList;
	i{, j}: Integer;

	str: String;
begin
	if (FileExists(FNGFileName)) then begin
		NGFile := TStringList.Create;
		try
			try
				FRepaint := false;
				NGFile.LoadFromFile(FNGFileName);
				for i := ComboBox1.Items.Count - 1 downto 0 do begin
					str := ComboBox1.Items[i];
					if( Length(str) > 0 ) then begin
						FRepaint := true;
						DeleteList.Add(str);
						NGFile.Delete(i);
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

end.
