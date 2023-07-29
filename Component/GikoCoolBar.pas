unit GikoCoolBar;

interface

uses
	Windows, Messages, SysUtils, Classes, Controls, ToolWin, ComCtrls, CommCtrl;

type
	tagNMREBARCHEVRON = packed record
		hdr: TNMHdr;
		uBand: UINT;
		wID: UINT;
		lParam: LPARAM;
		rc: TRect;
		lParamNM: LPARAM;
	end;
	PNMRebarChevron = ^TNMRebarChevron;
	TNMRebarChevron = tagNMRebarChevron;

	TGikoCoolBar = class;

	TBandInfoEvent = procedure(Sender: TObject; var BandInfo: PReBarBandInfo) of object;
	TChevronClickEvent = procedure(Sender: TObject; RebarChevron: PNMRebarChevron) of object;

	TGikoCoolBar = class(TCoolBar)
	private
		FOnBandInfo: TBandInfoEvent;
		FOnChevronClick: TChevronClickEvent;
		procedure RBInsertBand(var Message: TMessage); message RB_INSERTBAND;
		procedure RBSetBandInfo(var Message: TMessage); message RB_SETBANDINFO;
		procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
	protected
	public
	published
		property OnBandInfo: TBandInfoEvent read FOnBandInfo write FOnBandInfo;
		property OnChevronClick: TChevronClickEvent read FOnChevronClick write FOnChevronClick;
	end;

const
	RBBS_USECHEVRON		= $00000200;
	RBN_CHEVRONPUSHED = RBN_FIRST - 10;

procedure Register;

implementation

procedure Register;
begin
	RegisterComponents('gikoNavi', [TGikoCoolBar]);
end;

procedure TGikoCoolBar.RBInsertBand(var Message: TMessage);
begin
	if Assigned(FOnBandInfo) then
		FOnBandInfo(Self, PReBarBandInfo(Message.LParam));
	inherited;
end;

procedure TGikoCoolBar.RBSetBandInfo(var Message: TMessage);
begin
	if Assigned(FOnBandInfo) then
		FOnBandInfo(Self, PReBarBandInfo(Message.LParam));
	inherited;
end;

procedure TGikoCoolBar.CNNotify(var Message: TWMNotify);
begin
	if Message.NMHdr^.code = RBN_CHEVRONPUSHED then begin
		if Assigned(FOnChevronClick) then begin
			FOnChevronClick(Self, PNMRebarChevron(Message.NMHdr));
		end;
	end;
	inherited;
end;

end.
