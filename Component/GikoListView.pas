unit GikoListView;

interface

uses
	Windows, Messages, SysUtils, Classes, Controls, ComCtrls, CommCtrl{, TntComCtrls};

type
	TColumnInfoEvent = procedure(Sender: TObject; var Column: PLVColumn) of object;

	TGikoListView = class(TListView) {class(TTntListView)}
	private
		{ Private �錾 }
		FColumnInfoEvent: TColumnInfoEvent;
		procedure LVMSetColumn(var Message: TMessage); message LVM_SETCOLUMN;
		procedure LVMInsertColumn(var Message: TMessage); message LVM_INSERTCOLUMN;
	protected
		{ Protected �錾 }
	public
		{ Public �錾 }
	published
		{ Published �錾 }
		property OnColumnInfo: TColumnInfoEvent read FColumnInfoEvent write FColumnInfoEvent;
	end;

procedure Register;

implementation

procedure Register;
begin
	RegisterComponents('gikoNavi', [TGikoListView]);
end;


procedure TGikoListView.LVMSetColumn(var Message: TMessage);
begin
	if Assigned(FColumnInfoEvent) then
		FColumnInfoEvent(Self, PLVColumn(Message.LParam));
	inherited;
end;

procedure TGikoListView.LVMInsertColumn(var Message: TMessage);
begin
	if Assigned(FColumnInfoEvent) then
		FColumnInfoEvent(Self, PLVColumn(Message.LParam));
	inherited;
end;

end.
