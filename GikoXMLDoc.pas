unit GikoXMLDoc;

{!
\file		GikoXMLDoc.pas
\brief	XMLIntf, XMLDoc ������̃N���[��<br>
				Delphi 6 Personal �p

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

	// �킯�킩�炸����Ă邩��o�O���炯����
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
	out closed : boolean // �Ăяo�������[�`���� node �����ׂ��Ȃ� true
) : boolean; // ch �����̃��[�`�������������Ȃ� true

function XMLReadNode(
	var p				: PChar;
	const tail	: PChar;
	var node : IXMLNode
) : string; // node �ȊO�̃m�[�h������ꂽ�ꍇ�̃m�[�h��

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
\brief	tok ��T��
\param	p			�T���J�n�ʒu
\param	tail	�I���ʒu + 1
\param	tok		�T���L�����N�^
\return	tok ���ŏ��Ɍ��������ʒu
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
\brief	tok �ł͖����L�����N�^��T��
\param	p			�T���J�n�ʒu
\param	tail	�I���ʒu + 1
\param	tok		�T���L�����N�^
\return	tok �ł͂Ȃ��L�����N�^���ŏ��Ɍ��������ʒu
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
) : boolean; // ch �����̃��[�`�������������Ȃ� true
var
	found		: PChar;
begin

	closed := false;
	Result := false;
	tag := '';

	case p^ of
	'>':
		begin
			// �J�n�^�O�̍Ō�܂œǂ�
			Inc( p );	// '>' ��΂�
			Result := true;
		end;

	'?':
		begin
			// <?xml?> �݂����Ȃ�B����Ė���
			p := AnsiStrTok( p, tail, kXMLTagEnd );
			p := AnsiStrTok( p, tail, kXMLTagStart );
			Inc( p );	// '<' ��΂�
			p := AnsiStrNonTok( p, tail, kXMLWhite );
			//closed := true;
			Result := true;
		end;

	'/':
		begin
			// �^�O����ǂݍ���ŕԂ�
			Inc( p );	// '/' ��΂�
			found := AnsiStrTok( p, tail, kXMLTagEnd );
//			tag := Copy( p, 0, found - p );	// ���̂����x
			SetLength( tag, found - p );
			CopyMemory( PChar( tag ), p, found - p );

			p := found + 1; // '>' ��΂�
			closed := true;
			Result := true;
		end;
	end;

end;

function XMLReadNode(
	var p : PChar;
	const tail	: PChar;
	var node : IXMLNode
) : string; // node �ȊO�̃m�[�h������ꂽ�ꍇ�̃m�[�h��
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
		// node �̓ǂݍ���(1 ���[�v�ɂ� 1 �m�[�h)
		node.ChildNodes := IXMLNode.Create;

		while p < tail do
		begin
			// NodeName �ǂݍ���
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
					// �V�K�m�[�h
					Inc( p );
					child := IXMLNode.Create;
					tag := XMLReadNode( p, tail, child );
					node.ChildNodes.Add( child );

					// �^�O������ꂽ
					if Length( tag ) > 0 then
					begin
						// �����̂��̂��`�F�b�N���āA�Ⴆ�ΐe�ɕԂ�
						if tag <> node.NodeName then
							Result := tag;
						exit;
					end;

					goto NextNode;
				end else if p^ in kXMLWhite then
				begin
					// NodeName ����
					break;
				end else begin
					found := AnsiStrTok( p, tail, kXMLNodeNameStop );
					SetLength( nodeName, found - p );
					CopyMemory( PChar( nodeName ), p, found - p );
					node.NodeName := nodeName;

					p := found;
				end;
			end;

			// Attribute �̓ǂݍ���
			while p < tail do
			begin
				// Attribute �̖��O��ǂݍ���
				attributeName := '';
				attributeValue := '';

				p := AnsiStrNonTok( p, tail, kXMLWhite );

				while p < tail do
				begin
					if XMLCloseCheck( p, tail, node, tag, isClosed ) then
					begin
						if isClosed then
						begin
							// �^�O������ꂽ�̂Ń��^�[��
							// ��NodeName ��ʉ߂��Ă�̂œr���ŕ��Ă邱�ƂɂȂ�B
							// ����ēƗ��m�[�h�B
							exit;
						end;

						// ���̃m�[�h��
						goto NextNode;
					end else if p^ = '=' then
					begin
						// ��������͒l���n�܂�̂Ŗ��O�͏I��
						Inc( p );
						break;
					end else if p^ in kXMLWhite then
					begin
						// Value �����݂��Ȃ�(�K�i�O)�̂Ŏ��̃m�[�h��
						goto NextNode;
					end else begin
						found := AnsiStrTok( p, tail, kXMLAttributeNameStop );
						SetLength( attributeName, found - p );
						CopyMemory( PChar( attributeName ), p, found - p );

						p := found;
					end;
				end;

				// Attribute �̒l��ǂݍ���
				p := AnsiStrNonTok( p, tail, kXMLWhite );

				while p < tail do
				begin
					if XMLCloseCheck( p, tail, node, tag, isClosed ) then
					begin
						if isClosed then
						begin
							if Length( attributeName ) > 0 then
								// �K�i�O�����ǂ�
								node.AddAttribute( attributeName, attributeValue );

							// �^�O������ꂽ�̂Ń��^�[��
							// ��NodeName ��ʉ߂��Ă�̂œr���ŕ��Ă邱�ƂɂȂ�B
							// ����ēƗ��m�[�h�B
							exit;
						end;

						// ���̃m�[�h��
						goto NextNode;
					end else if p^ = '"' then
					begin
						// �l�� "" �Ŋ����Ă�̂�(�Ă����������ĂȂ��Ⴂ���Ȃ��񂾂���)
						// �l���ꊇ�ǂݍ���
						Inc( p );
						found := AnsiStrTok( p, tail, kXMLDQuote );
//						attributeValue := Copy( p, 0, found - p );	// ���̂����x
						SetLength( attributeValue, found - p );
						CopyMemory( PChar( attributeValue ), p, found - p );

						node.AddAttribute( attributeName, HtmlDecode( attributeValue ) );

						// �l��ǂݏI������̂ŏI��
						p := found + 1; // '"' ��΂�
						break;
					end else if p^ in kXMLWhite then
					begin
						// �K�i�O�����ǂ�
						node.AddAttribute( attributeName, HtmlDecode( attributeValue ) );

						goto NextNode;
					end else begin
						// �K�i�O�����ǈꉞ����Ă���
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
			end; // Attribute �̓ǂݍ���

			NextNode:;
		end; // // node �̓ǂݍ���(1 ���[�v�ɂ� 1 �m�[�h)
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
