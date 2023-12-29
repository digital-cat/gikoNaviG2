{$D-,Y-}
{----------------------------------------------------------
	MonaTest

	History
	2001.03.07 Check String�ō쐬
	2001.03.08 Check Integer�ō쐬
	2001.03.08 Check Int64�ō쐬
	2001.03.08 Check Single�쐬
	2001.03.08 Check Double�ō쐬
	2001.03.08 Check Extended�ō쐬
	2001.03.10 TestResult�쐬
	2001.03.10 Check Boolean�ō쐬
	2001.03.10 msg�𖳎����Ă����̂��C��
	2001.03.10 Error�葱���쐬
	2001.03.11 Check Condition: Boolean�ō쐬
----------------------------------------------------------}
unit MonaTest;

interface
uses
	SysUtils, Classes;

type
	ETestFailure = class(Exception);
	ETestError = class(Exception);

procedure ClearTestResult;

var
	TestResult: record
		Success: Integer;
		Failure: Integer;
		Error: Integer;
	end;

procedure Success;
procedure Fail(msg: String); overload;
procedure Fail(format: String; args: array of const); overload;
procedure Error(msg: String); overload;
procedure Error(format: String; args: array of const); overload;
procedure Error(E: Exception); overload;

procedure Check(Condition: Boolean; msg: String = ''); overload;
procedure Check(Actual, Required: String; msg: String = ''); overload;
procedure Check(Actual, Required: Integer; msg: String = ''); overload;
procedure Check(Actual, Required: Int64; msg: String = ''); overload;
procedure Check(Actual, Required: Single; msg: String = ''); overload;
procedure Check(Actual, Required: Double; msg: String = ''); overload;
procedure Check(Actual, Required: Extended; msg: String = ''); overload;
procedure Check(Actual, Required: Boolean; msg: String = ''); overload;

implementation

procedure ClearTestResult;
begin
	with TestResult do
	begin
		Success := 0;
		Failure := 0;
		Error := 0;
	end;
end;

procedure Success;
begin
	Inc(TestResult.Success);
end;

procedure Fail(msg: String);
begin
	Inc(TestResult.Failure);
	raise ETestFailure.CreateFmt('test failure: %s', [msg]);
end;

procedure Fail(format: String; args: array of const);
begin
	Fail(SysUtils.Format(format, args));
end;

procedure Error(msg: String);
begin
	Inc(TestResult.Error);
	raise ETestFailure.CreateFmt('test error: %s', [msg]);
end;

procedure Error(format: String; args: array of const);
begin
	Error(SysUtils.Format(format, args));
end;

procedure Error(E: Exception);
begin
	Error('test error: %s: %s', [E.Message, E.ClassName]);
end;

procedure Check(Condition: Boolean; msg: String);
begin
	if not Condition then
		Fail('Condition = False, %s', [msg])
	else
		Success;
end;

procedure Check(Actual, Required: String; msg: String);
begin
	if Actual <> Required then
		Fail('''%s''=''%s'', String, %s', [Actual, Required, msg])
	else
		Success;
end;

procedure Check(Actual, Required: Integer; msg: String);
begin
	if Actual <> Required then
		Fail('''%d''=''%d'', Integer, %s', [Actual, Required, msg]);
end;

procedure Check(Actual, Required: Int64; msg: String);
begin
	if Actual <> Required then
		Fail('''%d''=''%d'', Int64, %s', [Actual, Required, msg]);
end;

procedure Check(Actual, Required: Single; msg: String);
begin
	if Actual <> Required then
		Fail('''%f''=''%f'', Single, %s', [Actual, Required, msg]);
end;

procedure Check(Actual, Required: Double; msg: String);
begin
	if Actual <> Required then
		Fail('''%f''=''%f'', Double, %s', [Actual, Required, msg]);
end;

procedure Check(Actual, Required: Extended; msg: String);
begin
	if Actual <> Required then
		Fail('''%f''=''%f'', Extended, %s', [Actual, Required, msg]);
end;

procedure Check(Actual, Required: Boolean; msg: String);
begin
	if Actual <> Required then
		Fail('''%f''=''%f'', Boolean, %s', [Actual, Required, msg]);
end;

end.
