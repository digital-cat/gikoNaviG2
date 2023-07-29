unit MoveHistoryItem;

interface
 
uses
    SysUtils, Classes, BoardGroup, BrowserRecord,
{$IF Defined(DELPRO) }
	SHDocVw,
	MSHTML,
{$ELSE}
	SHDocVw_TLB,
	MSHTML_TLB,
{$IFEND}
    OleCtrls, ActiveX;
type

    TMoveHistoryItem = class(TObject)
    private
        FThreadItem : TThreadItem;
        FScrollTop  : Integer;
    public
        property ThreadItem : TThreadItem read FThreadItem write FThreadItem;
        property ScrollTop : Integer read FScrollTop write FScrollTop;
    end;

    TMoveHistory = class(TList)
    private
        FHistoryMax : Integer;
        FIndex : Integer;
        {
        \brief �����N�ړ������ő�ێ�����ݒ肷��B
        \param  AVal �ێ���
        }
        procedure SetHistoryMax(AVal: Integer);
        {
        \brief �����N�ړ������ő�ێ������擾����B
        \return �ێ���( > 0 )
        }
        function GetHistoryMax: Integer;
    public
        constructor Create( max : Integer ); overload;
        function pushItem( item: TMoveHistoryItem): Integer; overload;
        function pushItem( item: TBrowserRecord): Integer; overload;
        function getPrevItem( item: TBrowserRecord): TMoveHistoryItem;
        function getNextItem: TMoveHistoryItem;
        procedure Clear; override;
        property HistoryMax : Integer read GetHistoryMax write SetHistoryMax;
        property HisotryIndex: Integer read FIndex;
    end;

var
    MoveHisotryManager : TMoveHistory;

implementation

uses
    GikoSystem;

//! �R���X�g���N�^
constructor TMoveHistory.Create( max : Integer );
begin
    inherited Create;

    FIndex := 0;
    // �Ȃ����f�o�b�O����GikoSys��nil�̎���������???
    if (GikoSys = nil) then begin
        SetHistoryMax( max );
    end else begin
        SetHistoryMax( GikoSys.Setting.MoveHistorySize );
    end;
end;
//! �ړ������̃A�C�e���ǉ�
function TMoveHistory.pushItem( item: TMoveHistoryItem): Integer;
var
    i : Integer;
    top: TMoveHistoryItem;
begin
    Result := -1;
    if (Self.Count > 0) then begin
        top := TMoveHistoryItem( Self.Items[Self.Count - 1] );
        if (top.FThreadItem = item.FThreadItem) and
            (top.FScrollTop = item.FScrollTop) then begin
            Exit;
        end;
    end;
    // �ێ����̍ő�l�𒴂���ꍇ�擪���폜
    if (FIndex + 1 > FHistoryMax) then begin
        if ( Self.Items[0] <> nil ) then begin
            TMoveHistoryItem( Self.Items[0] ).Free;
        end;
        Self.Delete(0);
        Dec(Findex);
    end;
    // FIndex�����̃A�C�e�����폜����
    for i := Self.Count - 1 downto Findex do begin
        if (Self.Items [i] <> nil) then begin
            TMoveHistoryItem( Self.Items[i] ).Free;
        end;
        Self.Delete(i);
    end;
    Inc(FIndex);
    Result := Self.Add( item );
end;
//! �ړ������̃A�C�e���ǉ�
function TMoveHistory.pushItem( item: TBrowserRecord): Integer;
var
    history : TMoveHistoryItem;
    doc : IHTMLDocument2;
begin
    Result := -1;
    if not Assigned(item) then
        Exit;
    if not Assigned(item.Thread) then
        Exit;
    if not Assigned(item.Browser) then
        Exit;

    doc := item.Browser.ControlInterface.Document as IHTMLDocument2;
    if not Assigned(doc) then
        Exit;

    history := TMoveHistoryItem.Create;
    history.FThreadItem := item.Thread;

    history.ScrollTop := (doc.body as IHTMLElement2).ScrollTop;

    Result := pushItem( history );
end;
//! ��O�̗����A�C�e���擾
function TMoveHistory.getPrevItem(item: TBrowserRecord): TMoveHistoryItem;
begin
    Result := nil;
    if (FIndex = Self.Count) and (item <> nil) then begin
        pushItem( item );
        Dec(FIndex);
    end;
    if ( FIndex > 0 ) then begin
        Dec( FIndex );
        Result := TMoveHistoryItem( Self.items[ FIndex  ] );
    end;
end;
//! ����̗����A�C�e���擾
function TMoveHistory.getNextItem: TMoveHistoryItem;
begin
    Result := nil;
    if ( FIndex < Self.Count - 1 ) then begin
        Inc( FIndex );
        Result := TMoveHistoryItem( Self.items[ FIndex ] );
    end;
end;
//! �����̑S����
procedure TMoveHistory.clear;
var
    i : Integer;
begin
    // �A�C�e�����폜����
    for i := Self.Count - 1 downto 0 do begin
        if (Self.Items [i] <> nil) then begin
            TMoveHistoryItem( Self.Items[i] ).Free;
        end;
        Self.Delete(i);
    end;
    Self.Capacity := 0;
    FIndex := 0;
    inherited;
end;

procedure TMoveHistory.SetHistoryMax(AVal: Integer);
begin
    // �����̃T�C�Y��0���傫���Ȃ��Ƃ����Ȃ�
    if ( AVal > 0 ) then begin
        if ((AVal + 1) <> FHistoryMax) then begin
            Self.clear;
            // �ړ������ۂɁA�߂郊���N��1�����̂�
            FHistoryMax := AVal + 1;
        end;
    end;
end;
function TMoveHistory.GetHistoryMax: Integer;
begin
    // �ړ������ۂɁA�߂郊���N��1�����̂�
    Result := FHistoryMax - 1;
end;
initialization
	MoveHisotryManager := TMoveHistory.Create( 20 );

finalization
	if MoveHisotryManager <> nil then begin
		MoveHisotryManager.clear;
        FreeAndNil(MoveHisotryManager);
	end;
end.
