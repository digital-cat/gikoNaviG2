unit GikoXMLDoc;

{!
\file		GikoXMLDoc.pas
\brief	XMLIntf, XMLDoc あたりのクローン<br>
				Delphi 6 Personal 用

$Id: GikoXMLDoc.pas,v 1.10 2004/10/09 15:07:20 yoffy Exp $
}
interface

//==================================================
uses
//==================================================

	Classes, SysUtils, Windows,
	YofUtils;

//==================================================
type
//==================================================

	// わけわからず作ってるからバグだらけかも
	XMLDictionary = Record
		Name : string;
		Value : string;
	end;

	IXMLNode = class
	private
		FNodeName : string;
		FCapacity : Integer;
		FCount : Integer;
		FAttributeCount : Integer;
		FChildNodes : IXMLNode;
		FNodes : array of IXMLNode;
		FAttributes : array of XMLDictionary;
		function GetAttribute( const Name : string ) : string;
		function GetNode( Index : Integer ) : IXMLNode;
	public
		constructor	Create;
		destructor	Destroy; override;

		property NodeName : string read FNodeName write FNodeName;
		property Attributes[ const Name : string ] : string read GetAttribute;
		property Node[ Index : Integer ] : IXMLNode read GetNode; default;
		property ChildNodes : IXMLNode read FChildNodes write FChildNodes;
		property Count : Integer read FCount write FCount;
		procedure Add( node : IXMLNode );
		procedure AddAttribute( const Name : string; const Value : string );
	end;

	IXMLDocument = class( IXMLNode )
	private
		function GetDocumentElement() : IXMLNode;
	public
		property DocumentElement : IXMLNode read GetDocumentElement;
	end;

function XMLCloseCheck(
	var p				: PChar;
	const tail	: PChar;
	var node : IXMLNode;
	out tag : string;
	out closed : boolean // 呼び出したルーチンが node を閉じるべきなら true
) : boolean; // ch をこのルーチンが処理したなら true

function XMLReadNode(
	var p				: PChar;
	const tail	: PChar;
	var node : IXMLNode
) : string; // node 以外のノードが閉じられた場合のノード名

procedure LoadXMLDocument(
	const fileName : string;
    var doc : IXMLDocument
);

//==================================================
const
//==================================================
	kXMLWhite : TSysCharSet = [#0..#$20];
	kXMLNodeNameStop : TSysCharSet = [#0..#$20, '/', '>'];
	kXMLAttributeNameStop : TSysCharSet = [#0..#$20, '=', '/', '>'];
	kXMLDQuote : TSysCharSet = ['"'];
	kXMLTagStart : TSysCharSet = ['<'];
	kXMLTagEnd : TSysCharSet = ['>'];
	kXMLKanji : TSysCharSet = [#$81..#$9f, #$E0..#$fc];

//==================================================
implementation
//==================================================

// Constructor
constructor	IXMLNode.Create;
begin

	inherited;

	FCapacity := 0;
	FCount := 0;

end;

// Destructor
destructor	IXMLNode.Destroy;
var
	i : Integer;
begin

	for i := FCount - 1 downto 0 do
		FNodes[ i ].Free;
	FChildNodes.Free;

	inherited;

end;

function IXMLNode.GetAttribute( const Name : string ) : string;
var
	i : Integer;
begin

	i := 0;
	while i < FAttributeCount do
	begin
		if Name = FAttributes[ i ].Name then
		begin
			Result := FAttributes[ i ].Value;
			exit;
		end;

		Inc( i );
	end;

end;

function IXMLNode.GetNode( Index : Integer ) : IXMLNode;
begin

	Result := FNodes[ Index ];

end;

procedure IXMLNode.Add( node : IXMLNode );
begin

	Inc( FCount );
	if FCount > FCapacity then begin
		FCapacity := FCapacity + (FCapacity shr 2) + 1;
		SetLength( FNodes, FCapacity );
	end;

	FNodes[ FCount - 1 ] := node;

end;

procedure IXMLNode.AddAttribute(
	const Name : string;
	const Value : string
);
var
	index : Integer;
begin

	index := FAttributeCount;
	Inc( FAttributeCount );
	SetLength( FAttributes, FAttributeCount );

	FAttributes[ index ].Name := Name;
	FAttributes[ index ].Value := Value;

end;

function IXMLDocument.GetDocumentElement() : IXMLNode;
begin

	Result := FChildNodes[ 0 ];

end;

{!
\brief	tok を探す
\param	p			探索開始位置
\param	tail	終了位置 + 1
\param	tok		探すキャラクタ
\return	tok が最初に見つかった位置
}
function AnsiStrTok(
	p			: PChar;
	const tail	: PChar;
	const tok : TSysCharSet
) : PChar;
begin

	while p < tail do
	begin
		if p^ in tok then
		begin
			Break;
		end else if p^ in kXMLKanji then
			p := p + 2
		else
			Inc( p );
	end;

	Result := p;

end;

{!
\brief	tok では無いキャラクタを探す
\param	p			探索開始位置
\param	tail	終了位置 + 1
\param	tok		探すキャラクタ
\return	tok ではないキャラクタが最初に見つかった位置
}
function AnsiStrNonTok(
	p			: PChar;
	const tail	: PChar;
	const tok : TSysCharSet
) : PChar;
begin

	while p < tail do
	begin
		if p^ in tok then
		begin
			if p^ in kXMLKanji then
				p := p + 2
			else
				Inc( p );
		end else begin
			Break;
		end;
	end;

	Result := p;

end;

function XMLCloseCheck(
	var p : PChar;
	const tail	: PChar;
	var node : IXMLNode;
	out tag : string;
	out closed : boolean
) : boolean; // ch をこのルーチンが処理したなら true
var
	found		: PChar;
begin

	closed := false;
	Result := false;
	tag := '';

	case p^ of
	'>':
		begin
			// 開始タグの最後まで読んだ
			Inc( p );	// '>' 飛ばし
			Result := true;
		end;

	'?':
		begin
			// <?xml?> みたいなやつ。よって無視
			p := AnsiStrTok( p, tail, kXMLTagEnd );
			p := AnsiStrTok( p, tail, kXMLTagStart );
			Inc( p );	// '<' 飛ばし
			p := AnsiStrNonTok( p, tail, kXMLWhite );
			//closed := true;
			Result := true;
		end;

	'/':
		begin
			// タグ名を読み込んで返す
			Inc( p );	// '/' 飛ばし
			found := AnsiStrTok( p, tail, kXMLTagEnd );
//			tag := Copy( p, 0, found - p );	// 何故か激遅
			SetLength( tag, found - p );
			CopyMemory( PChar( tag ), p, found - p );

			p := found + 1; // '>' 飛ばし
			closed := true;
			Result := true;
		end;
	end;

end;

function XMLReadNode(
	var p : PChar;
	const tail	: PChar;
	var node : IXMLNode
) : string; // node 以外のノードが閉じられた場合のノード名
var
	child : IXMLNode;

	found : PChar;
	tag : string;

	isClosed : boolean;

	nodeName : string;
	attributeName : string;
	attributeValue : string;
label
	NextNode;
begin
	try
		// node の読み込み(1 ループにつき 1 ノード)
		node.ChildNodes := IXMLNode.Create;

		while p < tail do
		begin
			// NodeName 読み込み
			p := AnsiStrNonTok( p, tail, kXMLWhite );

			while p < tail do
			begin
				if XMLCloseCheck( p, tail, node, tag, isClosed ) then
				begin
					if isClosed then
					begin
						Result := tag;
						exit;
					end;

					goto NextNode;
				end else if p^ = '<' then
				begin
					// 新規ノード
					Inc( p );
					child := IXMLNode.Create;
					tag := XMLReadNode( p, tail, child );
					node.ChildNodes.Add( child );

					// タグが閉じられた
					if Length( tag ) > 0 then
					begin
						// 自分のものかチェックして、違えば親に返す
						if tag <> node.NodeName then
							Result := tag;
						exit;
					end;

					goto NextNode;
				end else if p^ in kXMLWhite then
				begin
					// NodeName 完了
					break;
				end else begin
					found := AnsiStrTok( p, tail, kXMLNodeNameStop );
					SetLength( nodeName, found - p );
					CopyMemory( PChar( nodeName ), p, found - p );
					node.NodeName := nodeName;

					p := found;
				end;
			end;

			// Attribute の読み込み
			while p < tail do
			begin
				// Attribute の名前を読み込み
				attributeName := '';
				attributeValue := '';

				p := AnsiStrNonTok( p, tail, kXMLWhite );

				while p < tail do
				begin
					if XMLCloseCheck( p, tail, node, tag, isClosed ) then
					begin
						if isClosed then
						begin
							// タグが閉じられたのでリターン
							// ※NodeName を通過してるので途中で閉じてることになる。
							// よって独立ノード。
							exit;
						end;

						// 次のノードへ
						goto NextNode;
					end else if p^ = '=' then
					begin
						// ここからは値が始まるので名前は終了
						Inc( p );
						break;
					end else if p^ in kXMLWhite then
					begin
						// Value が存在しない(規格外)ので次のノードへ
						goto NextNode;
					end else begin
						found := AnsiStrTok( p, tail, kXMLAttributeNameStop );
						SetLength( attributeName, found - p );
						CopyMemory( PChar( attributeName ), p, found - p );

						p := found;
					end;
				end;

				// Attribute の値を読み込み
				p := AnsiStrNonTok( p, tail, kXMLWhite );

				while p < tail do
				begin
					if XMLCloseCheck( p, tail, node, tag, isClosed ) then
					begin
						if isClosed then
						begin
							if Length( attributeName ) > 0 then
								// 規格外だけどね
								node.AddAttribute( attributeName, attributeValue );

							// タグが閉じられたのでリターン
							// ※NodeName を通過してるので途中で閉じてることになる。
							// よって独立ノード。
							exit;
						end;

						// 次のノードへ
						goto NextNode;
					end else if p^ = '"' then
					begin
						// 値が "" で括られてるので(ていうか括られてなきゃいけないんだけど)
						// 値を一括読み込み
						Inc( p );
						found := AnsiStrTok( p, tail, kXMLDQuote );
//						attributeValue := Copy( p, 0, found - p );	// 何故か激遅
						SetLength( attributeValue, found - p );
						CopyMemory( PChar( attributeValue ), p, found - p );

						node.AddAttribute( attributeName, HtmlDecode( attributeValue ) );

						// 値を読み終わったので終了
						p := found + 1; // '"' 飛ばし
						break;
					end else if p^ in kXMLWhite then
					begin
						// 規格外だけどね
						node.AddAttribute( attributeName, HtmlDecode( attributeValue ) );

						goto NextNode;
					end else begin
						// 規格外だけど一応取っておく
						attributeValue := attributeValue + p^;

						if p^ in kXMLKanji then
						begin
							attributeValue := attributeValue + (p + 1)^;
							p := p + 2;
						end else begin
							Inc( p );
						end;
					end;
				end;
			end; // Attribute の読み込み

			NextNode:;
		end; // // node の読み込み(1 ループにつき 1 ノード)
	finally
	end;
end;

procedure LoadXMLDocument(
	const fileName : string;
	var doc : IXMLDocument
);
type
	xmlMode = ( xmlHoge );
var
	xmlFile : TMappedFile;
	p				: PChar;
begin
		//Result := IXMLDocument.Create;
	//doc := IXMLDocument.Create;

	xmlFile := TMappedFile.Create( fileName );

	try
		p := xmlFile.Memory;
		XMLReadNode( p, p + xmlFile.Size, IXMLNode( doc ) );
		//XMLReadNode( xmlFile, IXMLNode( Result ) );
	finally
		xmlFile.Free;
	end;

	//Result := doc;

end;

end.
