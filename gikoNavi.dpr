program gikoNavi;



uses
  Windows,
  SysUtils,
  Forms,
  Messages,
  MainForm in 'MainForm.pas' {MainWindow},
  Giko in 'Giko.pas' {GikoForm},
  Splash in 'Splash.pas' {SplashWindow},
  About in 'About.pas' {AboutDialog},
  Option in 'Option.pas' {OptionDialog},
  Editor in 'Editor.pas' {EditorForm},
  Round in 'Round.pas' {RoundDialog},
  ListSelect in 'ListSelect.pas' {ListSelectDialog},
  Search in 'Search.pas' {SearchDialog},
  GikoSystem in 'GikoSystem.pas',
  Setting in 'Setting.pas',
  BoardGroup in 'BoardGroup.pas',
  Sort in 'Sort.pas',
  ThreadControl in 'ThreadControl.pas',
  ItemDownload in 'ItemDownload.pas',
  RoundData in 'RoundData.pas',
  RoundName in 'RoundName.pas' {RoundNameDialog},
  NewBoard in 'NewBoard.pas' {NewBoardDialog},
  UBase64 in 'Encrypt\UBase64.pas',
  UCryptAuto in 'Encrypt\UCryptAuto.pas',
  KeySetting in 'KeySetting.pas' {KeySettingForm},
  FavoriteAdd in 'FavoriteAdd.pas' {FavoriteAddDialog},
  NewFavoriteFolder in 'NewFavoriteFolder.pas' {NewFavoriteFolderDialog},
  FavoriteArrange in 'FavoriteArrange.pas' {FavoriteArrangeDialog},
  Favorite in 'Favorite.pas' {FavoriteDM: TDataModule},
  AddressHistory in 'AddressHistory.pas' {AddressHistoryDM: TDataModule},
  Preview in 'Preview.pas',
  HTMLDocumentEvent in 'HTMLDocumentEvent.pas',
  Kotehan in 'Kotehan.pas' {KotehanDialog},
  GikoUtil in 'GikoUtil.pas',
  ToolBarSetting in 'ToolBarSetting.pas' {ToolBarSettingDialog},
  ToolBarUtil in 'ToolBarUtil.pas',
  YofUtils in 'YofUtils.pas',
  AbonUnit in 'AbonUnit.pas',
  IndividualAbon in 'IndividualAbon.pas' {IndividualAbonForm},
  Trip in 'Trip.pas',
  GikoXMLDoc in 'GikoXMLDoc.pas',
  ExternalBoardManager in 'ExternalBoardManager.pas',
  ExternalThreadItem in 'ExternalThreadItem.pas',
  ExternalBoardItem in 'ExternalBoardItem.pas',
  ExternalBoardPlugInMain in 'ExternalBoardPlugInMain.pas',
  ExternalFilePath in 'ExternalFilePath.pas',
  MojuUtils in 'MojuUtils.pas',
  gzip in 'gzip_delphi2\gzip.pas',
  zlib in 'gzip_delphi2\zlib.pas',
  bmregexp in 'bmRegExp\bmregexp.pas',
  GikoCoolBar in 'Component\GikoCoolBar.pas',
  GikoListView in 'Component\GikoListView.pas',
  GikoPanel in 'Component\GikoPanel.pas',
  KuroutSetting in 'KuroutSetting.pas' {KuroutOption},
  GestureModel in 'GestureModel.pas',
  Gesture in 'Gesture.pas',
  GikoBayesian in 'GikoBayesian.pas',
  Y_TextConverter in 'res\ExternalBoardPlugIn\Y_TextConverter.pas',
  HTMLCreate in 'HTMLCreate.pas',
  ListViewUtils in 'ListViewUtils.pas',
  GikoDataModule in 'GikoDataModule.pas' {GikoDM: TDataModule},
  BrowserRecord in 'BrowserRecord.pas',
  GikoMessage in 'GikoMessage.pas',
  InputAssist in 'InputAssist.pas' {InputAssistForm},
  InputAssistDataModule in 'InputAssistDataModule.pas' {InputAssistDM: TDataModule},
  DefaultFileManager in 'DefaultFileManager.pas',
  MoveHistoryItem in 'MoveHistoryItem.pas',
  SambaTimer in 'SambaTimer.pas',
  HistoryList in 'HistoryList.pas',
  ReplaceDataModule in 'ReplaceDataModule.pas' {ReplaceDM: TDataModule},
  ResPopupBrowser in 'ResPopupBrowser.pas',
  SkinFiles in 'SkinFiles.pas',
  NewBoardURL in 'NewBoardURL.pas' {NewBoardURLForm},
  ExtPreviewDatamodule in 'ExtPreviewDatamodule.pas' {ExtPreviewDM: TDataModule},
  UpdateCheck in 'UpdateCheck.pas' {UpdateCheckForm},
  SHA1Unit in 'SHA1Unit.pas',
  PopupMenuUtil in 'PopupMenuUtil.pas',
  PopupMenuSetting in 'PopupMenuSetting.pas' {PopupMenuSettingDialog},
  Belib in 'Belib.pas',
  WideCtrls in 'WideCtrls.pas',
  ThreadSearch in 'ThreadSearch.pas' {ThreadSrch},
  uLkJSON in 'lkJSON\uLkJSON.pas',
  ThreadNGEdt in 'ThreadNGEdt.pas' {ThreadNGEdit},
  AbonInfo in 'AbonInfo.pas',
  AbonInfoSet in 'AbonInfoSet.pas' {AbonInfoEdit},
  NgEditor in 'NgEditor.pas' {NgEdit},
  RegExpTester in 'RegExpTester.pas' {RegExpTest},
  BbsThrSel in 'BbsThrSel.pas' {BbsThreadSel},
  IndyModule in 'IndyModule.pas' {IndyMdl: TDataModule},
  DmSession5ch in 'DmSession5ch.pas' {Session5ch: TDataModule},
  RangeAbon in 'RangeAbon.pas' {RangeAbonForm},
  GikoInputBoxForm in 'GikoInputBoxForm.pas' {GikoInputBox},
  DonguriBase in 'DonguriBase.pas' {DonguriForm},
  DonguriSystem in 'DonguriSystem.pas';

{$R *.RES}
{$R gikoResource.res}

var
	hMutex: THandle;
	Wnd{, AppWnd}: HWnd;
	i: Integer;
	CDS: TCopyDataStruct;
const
	MutexString: string = 'gikoNaviInstance';
begin
	hMutex := OpenMutex(MUTEX_ALL_ACCESS, False, PChar(MutexString));
	if hMutex <> 0 then begin
		//ミューテックスが存在した場合は起動中止
		Wnd := FindWindow('TGikoForm', nil);
		if Wnd <> 0 then begin
			//既に起動済みギコナビのアクティブ化＆アイコン化されてたら復元
			try
				SetForegroundWindow(Wnd);
			except
            	//初期化が終わっていないとフォアグラウンドに移せずに例外発生
			end;
			if IsIconic(Wnd) then
				SendMessage(Wnd, WM_SYSCOMMAND, SC_RESTORE, -1);
//			AppWnd := GetWindowLong(Wnd, GWL_HWNDPARENT);
//			if (AppWnd <> 0) and (IsIconic(AppWnd)) then
//				SendMessage(AppWnd, WM_SYSCOMMAND, SC_RESTORE, -1);

			//で、引数があったら起動済みギコナビに送る
			for i := 1 to ParamCount do	begin
				CDS.dwData := 0;
				CDS.cbData := Length(ParamStr(i)) + 1;
				GetMem(CDS.lpData, CDS.cbData);
				try
					StrPCopy(CDS.lpData, ParamStr(i));
					SendMessage(Wnd, WM_COPYDATA, 0, LParam(@CDS));
				finally
					FreeMem(CDS.lpData);
				end;
			end;
		end;

		CloseHandle(hMutex);
    Exit;
	end;
  //ミューテックスが存在しない場合はアプリケーション起動続行
  hMutex := CreateMutex(nil, False, PChar(MutexString));
  Application.Initialize;
  Application.Title := 'ギコナビ';
  Application.ShowMainForm := False;
  Application.CreateForm(TMainWindow, MainWindow);
  Application.CreateForm(TFavoriteDM, FavoriteDM);
  Application.CreateForm(TAddressHistoryDM, AddressHistoryDM);
  Application.CreateForm(TIndyMdl, IndyMdl);
  Application.CreateForm(TSession5ch, Session5ch);
  Application.CreateForm(TGikoDM, GikoDM);
  Application.CreateForm(TInputAssistDM, InputAssistDM);
  Application.CreateForm(TReplaceDM, ReplaceDM);
  Application.CreateForm(TExtPreviewDM, ExtPreviewDM);
  Application.CreateForm(TGikoForm, GikoForm);
  Application.CreateForm(TUpdateCheckForm, UpdateCheckForm);
  Application.Run;
	ReleaseMutex(hMutex);
end.

