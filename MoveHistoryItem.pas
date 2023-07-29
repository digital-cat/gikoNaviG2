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
        \brief リンク移動履歴最大保持数を設定する。
        \param  AVal 保持数
        }
        procedure SetHistoryMax(AVal: Integer);
        {
        \brief リンク移動履歴最大保持数を取得する。
        \return 保持数( > 0 )
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

//! コンストラクタ
constructor TMoveHistory.Create( max : Integer );
begin
    inherited Create;

    FIndex := 0;
    // なぜがデバッグ中にGikoSysがnilの時があった???
    if (GikoSys = nil) then begin
        SetHistoryMax( max );
    end else begin
        SetHistoryMax( GikoSys.Setting.MoveHistorySize );
    end;
end;
//! 移動履歴のアイテム追加
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
    // 保持数の最大値を超える場合先頭を削除
    if (FIndex + 1 > FHistoryMax) then begin
        if ( Self.Items[0] <> nil ) then begin
            TMoveHistoryItem( Self.Items[0] ).Free;
        end;
        Self.Delete(0);
        Dec(Findex);
    end;
    // FIndexより後ろのアイテムを削除する
    for i := Self.Count - 1 downto Findex do begin
        if (Self.Items [i] <> nil) then begin
            TMoveHistoryItem( Self.Items[i] ).Free;
        end;
        Self.Delete(i);
    end;
    Inc(FIndex);
    Result := Self.Add( item );
end;
//! 移動履歴のアイテム追加
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
//! 一つ前の履歴アイテム取得
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
//! 一つ後ろの履歴アイテム取得
function TMoveHistory.getNextItem: TMoveHistoryItem;
begin
    Result := nil;
    if ( FIndex < Self.Count - 1 ) then begin
        Inc( FIndex );
        Result := TMoveHistoryItem( Self.items[ FIndex ] );
    end;
end;
//! 履歴の全消去
procedure TMoveHistory.clear;
var
    i : Integer;
begin
    // アイテムを削除する
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
    // 履歴のサイズは0より大きくないといけない
    if ( AVal > 0 ) then begin
        if ((AVal + 1) <> FHistoryMax) then begin
            Self.clear;
            // 移動した際に、戻るリンクを1つ足すので
            FHistoryMax := AVal + 1;
        end;
    end;
end;
function TMoveHistory.GetHistoryMax: Integer;
begin
    // 移動した際に、戻るリンクを1つ足すので
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
