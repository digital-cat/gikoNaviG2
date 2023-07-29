unit Sort;

interface
uses
	Windows, Messages, SysUtils, Classes, Controls, Forms,
	BoardGroup,DateUtils,
	Setting, Math;

	function CategorySortProc(Item1, Item2: Pointer): integer;
	function BoardSortProc(List: TStringList; Item1, Item2: Integer): integer;
	function ThreadItemSortProc(List: TStringList; Item1, Item2: Integer): integer;
	function CompareBool(Item1, Item2: Boolean): integer;
	function CompareInt(Item1, Item2: Integer): Integer;
	function CompareDate(Item1, Item2: TDateTime): Integer;
	procedure SetSortDate(Date: TDateTime);
	function GetSortDate(): TDateTime;
	procedure SetSortOrder(Order: Boolean);
	function GetSortOrder: Boolean;
	procedure SetSortIndex(Index: Integer);
	function GetSortIndex: Integer;
	procedure SetSortNoFlag(Flag: Boolean);
	function GetSortNoFlag: Boolean;

implementation

var
	FSortDate: TDateTime;
	FSortOrder: Boolean;
	FSortIndex: Integer;
	FSortNoFlag: Boolean;

function CaclVigor(Thread: TThreadItem): Double;
var
	span : Double;
begin
	if (Thread.AgeSage <> gasArch) then begin
		span := DaySpan(Sort.GetSortDate, Thread.CreateDate);
	end else begin
		span := DaySpan(Thread.LastModified, Thread.CreateDate);
	end;
	if (span > 0) then begin
		Result := Thread.AllResCount / span;
	end else begin
		Result := 0;
	end;
end;
procedure SetSortOrder(Order: Boolean);
begin
	FSortOrder := Order;
end;
function GetSortOrder: Boolean;
begin
	Result := FSortOrder;
end;
procedure SetSortIndex(Index: Integer);
begin
	FSortIndex := Index;
end;
function GetSortIndex: Integer;
begin
	Result := FSortIndex;
end;
procedure SetSortNoFlag(Flag: Boolean);
begin
	FSortNoFlag := Flag;
end;
function GetSortNoFlag: Boolean;
begin
	Result := FSortNoFlag;
end;

function CategorySortProc(Item1, Item2: Pointer): integer;
var
	CategoryItem1: TCategory;
	CategoryItem2: TCategory;
begin
	CategoryItem1 := TCategory(Item1);
	CategoryItem2 := TCategory(Item2);

	case TGikoBBSColumnID( FSortIndex ) of
	gbbscTitle:
		if FSortNoFlag then
			Result := CompareInt(CategoryItem1.No, CategoryItem2.No)
		else
			Result := AnsiCompareText(CategoryItem1.Title, CategoryItem2.Title);
	else
		Result := CompareInt(CategoryItem1.No, CategoryItem2.No)
	end;

	if not FSortOrder then
		Result := Result * -1;
end;

function BoardSortProc(List: TStringList; Item1, Item2: Integer): integer;
var
	BoardItem1: TBoard;
	BoardItem2: TBoard;
begin
	BoardItem1 := TBoard(List.Objects[Item1]);
	BoardItem2 := TBoard(List.Objects[Item2]);
	case TGikoCategoryColumnID( FSortIndex ) of
	gccTitle:
		if FSortNoFlag then
			Result := CompareInt(BoardItem1.No, BoardItem2.No)
		else
			Result := AnsiCompareText(BoardItem1.Title, BoardItem2.Title);

	gccRoundName:
		Result := CompareInt(BoardItem1.Count, BoardItem2.Count);

	gccLastModified:
		Result := CompareDate(BoardItem1.RoundDate, BoardItem2.RoundDate);
	else
		Result := CompareInt(BoardItem1.No, BoardItem2.No)
	end;

	if not FSortOrder then
		Result := Result * -1;
end;

function ThreadItemSortProc(List: TStringList; Item1, Item2: Integer): integer;
var
	ThreadItem1: TThreadItem;
	ThreadItem2: TThreadItem;
begin
	ThreadItem1 := TThreadItem(List.Objects[ Item1 ]);
	ThreadItem2 := TThreadItem(List.Objects[ Item2 ]);
	case TGikoBoardColumnID( FSortIndex ) of
		gbcTitle:
			begin
				if FSortNoFlag then
					Result := CompareInt(ThreadItem1.No, ThreadItem2.No)
				else
					Result := AnsiCompareText(ThreadItem1.Title, ThreadItem2.Title)
			end;

		gbcAllCount:			Result := CompareInt(ThreadItem1.AllResCount, ThreadItem2.AllResCount);
		gbcLocalCount:		Result := CompareInt(ThreadItem1.Count, ThreadItem2.Count);
		gbcNonAcqCount:
			begin
				if ThreadItem1.IsLogFile and ThreadItem2.IsLogFile then
					Result := CompareInt(ThreadItem1.AllResCount - ThreadItem1.Count, ThreadItem2.AllResCount - ThreadItem2.Count)
				else if ThreadItem1.IsLogFile then
					Result := 1
				else if ThreadItem2.IsLogFile then
					Result := -1
				else
					Result := 0;
			end;

		gbcNewCount: 			Result := CompareInt(ThreadItem1.NewResCount, ThreadItem2.NewResCount);
		gbcUnReadCount: 	Result := 0;
		gbcRoundName: 		Result := AnsiCompareText(ThreadItem1.RoundName, ThreadItem2.RoundName);
		gbcRoundDate:	Result := CompareDateTime(ThreadItem1.RoundDate, ThreadItem2.RoundDate); {gbcLastModified:}
		gbcCreated:				Result := CompareDateTime(ThreadItem1.CreateDate, ThreadItem2.CreateDate);
		gbcLastModified:	Result := CompareDateTime(ThreadItem1.LastModified, ThreadItem2.LastModified); {gbcLastModified:}
		gbcVigor:	Result := CompareValue(CaclVigor(ThreadItem1), CaclVigor(ThreadItem2));
	else
		Result := 0;
	end;

{	if SortIndex = 0 then
		if SortNoFlag then
			Result := CompareInt(ThreadItem1.No, ThreadItem2.No)
		else
			Result := CompareText(ThreadItem1.Title, ThreadItem2.Title)
	else if SortIndex = 1 then
		Result := CompareInt(ThreadItem1.Count, ThreadItem2.Count)
	else if SortIndex = 2 then
//		Result := CompareInt(ThreadItem1.RoundNo, ThreadItem2.RoundNo)
		Result := CompareText(ThreadItem1.RoundName, ThreadItem2.RoundName)
	else
		Result := CompareDate(ThreadItem1.LastModified, ThreadItem2.LastModified);
}
	if not FSortOrder then
		Result := Result * -1;

	// ソート評価が同じ場合は、第1カラムの昇順にソート
	if Result = 0 then begin
		if FSortNoFlag then
			Result := CompareInt(ThreadItem1.No, ThreadItem2.No)
		else
			Result := AnsiCompareText(ThreadItem1.Title, ThreadItem2.Title)
	end;
end;

function CompareBool(Item1, Item2: Boolean): Integer;
begin
	if (Item1 = True) and (Item2 = False) then
		Result := 1
	else if (Item2 = False) and (Item2 = True) then
		Result := -1
	else
		Result := 0;
end;

function CompareInt(Item1, Item2: Integer): Integer;
begin
	if Item1 > Item2 then
		Result := 1
	else if Item1 < Item2 then
		Result := -1
	else
		Result := 0;
end;

function CompareDate(Item1, Item2: TDateTime): Integer;
begin
	if Item1 > Item2 then
		Result := 1
	else if Item1 < Item2 then
		Result := -1
	else
		Result := 0;
end;
procedure SetSortDate(Date: TDateTime);
begin
	FSortDate := Date;
end;
function GetSortDate(): TDateTime;
begin
	Result := FSortDate;
end;
end.
