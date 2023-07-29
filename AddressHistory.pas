unit AddressHistory;

interface

uses
	SysUtils, Classes, {SAX, SAXHelpers, SAXComps, SAXKW,}
	GikoSystem, {XMLIntf, XMLDoc}{, HttpApp} GikoXMLDoc, YofUtils;

type
	TAddressHistoryDM = class(TDataModule)
	private
		{ Private éŒ¾ }
		FReadCount: Integer;

//		procedure SAXStartDocument(Sender: TObject);
//		procedure SAXEndDocument(Sender: TObject);
//		procedure SAXStartElement(Sender: TObject; const NamespaceURI, LocalName, QName: SAXString; const Atts: IAttributes);
//		procedure SAXEndElement(Sender: TObject; const NamespaceURI, LocalName, QName: SAXString);
//		procedure SAXCharacters(Sender: TObject; const PCh: SAXString);
	public
		{ Public éŒ¾ }
		procedure ReadHistory(sl: TStrings; ReadCount: Integer);
		procedure WriteHistory(sl: TStrings; WriteCount: Integer);
	end;

var
	AddressHistoryDM: TAddressHistoryDM;

implementation

const
	ADDRESS_HISTORY_FILE_NAME = 'AddressHistory.xml';

{$R *.dfm}

procedure TAddressHistoryDM.ReadHistory(sl: TStrings; ReadCount: Integer);
var
	FileName: string;
	XMLDoc: IXMLDocument;
	XMLNode: IXMLNode;
	HistoryNode: IXMLNode;
	i: Integer;
	s: string;
begin

	sl.Clear;
	FReadCount := ReadCount;

	FileName := GikoSys.GetConfigDir + ADDRESS_HISTORY_FILE_NAME;

	if FileExists(FileName) then begin
		try
            XMLDoc := IXMLDocument.Create;
			//XMLDoc := LoadXMLDocument(FileName);
            LoadXMLDocument(FileName, XMLDoc);
      try
        XMLNode := XMLDoc.DocumentElement;

        if XMLNode.NodeName = 'address' then begin
          for i := 0 to XMLNode.ChildNodes.Count - 1 do begin
            HistoryNode := XMLNode.ChildNodes[i];
            if HistoryNode.NodeName = 'history' then begin
              if FReadCount >= sl.Count then begin
                s := Trim(HistoryNode.Attributes['url']);
                if s <> '' then
                  sl.Add(s);
                  //sl.Add(HttpDecode(s));
              end;
            end;
          end;
        end;
      finally
        XMLDoc.Free;
      end;
		except
		end;
	end;

//	AddressSAXHandler.OnStartDocument := SAXStartDocument;
//	AddressSAXHandler.OnEndDocument := SAXEndDocument;
//	AddressSAXHandler.OnStartElement := SAXStartElement;
//	AddressSAXHandler.OnStartElement := SAXStartElement;
//	AddressSAXHandler.OnEndElement := SAXEndElement;
//	AddressSAXHandler.OnCharacters := SAXCharacters;

//	AddressSAXReader.Vendor := 'Keith Wood';
//	AddressSAXReader.URL := FileName;
//	AddressSAXReader.Parse;
end;

procedure TAddressHistoryDM.WriteHistory(sl: TStrings; WriteCount: Integer);
var
	FileName: string;
	SaveList: TStringList;
	i: Integer;
	Count: Integer;
{
	XMLDoc: IXMLDocument;
	XMLNode: IXMLNode;
	HistoryNode: IXMLNode;
}
begin
{
	XMLDoc :=	NewXMLDocument;
	XMLDoc.Encoding := 'Shift_JIS';
	XMLDoc.StandAlone := 'yes';
	XMLNode := XMLDoc.AddChild('address');

	FileName := GikoSys.GetConfigDir + ADDRESS_HISTORY_FILE_NAME;
	if sl.Count > WriteCount then
		Count := WriteCount
	else
		Count := sl.Count;

	for i := 0 to Count - 1 do begin
		HistoryNode := XMLNode.AddChild('history');
		HistoryNode.Attributes['url'] := Trim(sl[i]);
	end;
	XMLDoc.SaveToFile(FileName);
}
	FileName := GikoSys.GetConfigDir + ADDRESS_HISTORY_FILE_NAME;
	SaveList := TStringList.Create;
	try
		if sl.Count > WriteCount then
			Count := WriteCount
		else
			Count := sl.Count;
		SaveList.Add('<?xml version="1.0" encoding="Shift_JIS" standalone="yes"?>');
		SaveList.Add('<address>');
		for i := 0 to Count - 1 do begin
			SaveList.Add('<history url="' + HtmlEncode(Trim(sl[i])) + '"/>');
		end;
		SaveList.Add('</address>');
		SaveList.SaveToFile(FileName);
	finally
		SaveList.Free;
	end;
end;

{procedure TAddressHistoryDM.SAXStartDocument(Sender: TObject);
begin
//
end;

procedure TAddressHistoryDM.SAXEndDocument(Sender: TObject);
begin
//
end;

procedure TAddressHistoryDM.SAXStartElement(Sender: TObject; const NamespaceURI, LocalName, QName: SAXString;
	const Atts: IAttributes);
var
	s: string;
begin
	if QName = 'history' then begin
		if FReadCount >= FList.Count then begin
			s := Atts.getValue('url');
			if Trim(s) <> '' then
				FList.Add(s);
		end;
	end;
end;

procedure TAddressHistoryDM.SAXEndElement(Sender: TObject; const NamespaceURI, LocalName, QName: SAXString);
begin
//
end;

procedure TAddressHistoryDM.SAXCharacters(Sender: TObject; const PCh: SAXString);
begin
//
end;
}
end.
