object GikoDM: TGikoDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 336
  Width = 286
  object GikoFormActionList: TActionList
    Images = ToobarImageList
    Left = 48
    Top = 12
    object OnlyAHundredResAction: TAction
      Category = #12473#12524#12483#12489
      AutoCheck = True
      Caption = #26368#26032'100'#12524#12473#12398#12415#34920#31034'(&H)'
      GroupIndex = 2
      Hint = #26368#26032'100'#12524#12473#12398#12415#34920#31034
      ImageIndex = 38
      OnExecute = OnlyAHundredResActionExecute
    end
    object OnlyKokoResAction: TAction
      Category = #12473#12524#12483#12489
      AutoCheck = True
      Caption = #26410#35501#12524#12473#12398#12415#34920#31034'(&K)'
      GroupIndex = 2
      Hint = #26410#35501#12524#12473#12398#12415#34920#31034
      ImageIndex = 46
      OnExecute = OnlyKokoResActionExecute
    end
    object LoginAction: TAction
      Category = #12501#12449#12452#12523
      AutoCheck = True
      Caption = #12525#12464#12452#12531'(&L)'
      Hint = #12525#12464#12452#12531#65295#12525#12464#12450#12454#12488#12434#12377#12427
      ImageIndex = 3
      OnExecute = LoginActionExecute
    end
    object NewBoardAction: TAction
      Category = #12501#12449#12452#12523
      Caption = #26495#19968#35239#26356#26032'(&B)...'
      Hint = #12508#12540#12489#26356#26032#12480#12452#12450#12525#12464#12434#34920#31034#12377#12427
      OnExecute = NewBoardActionExecute
    end
    object LogDeleteAction: TAction
      Category = #12501#12449#12452#12523
      Caption = #12525#12464#21066#38500'(&D)'
      Hint = #36984#25246#12373#12428#12390#12356#12427#12473#12524#12483#12489#12434#21066#38500#12377#12427
      ShortCut = 46
      OnExecute = LogDeleteActionExecute
      OnUpdate = LogDeleteActionUpdate
    end
    object KidokuAction: TAction
      Category = #32232#38598
      Caption = #26082#35501#12395#12377#12427'(&K)'
      Hint = #36984#25246#12373#12428#12390#12356#12427#12473#12524#12483#12489#12434#26082#35501#12395#12377#12427
      OnExecute = KidokuActionExecute
    end
    object StdToolBarVisibleAction: TAction
      Category = #34920#31034
      AutoCheck = True
      Caption = #27161#28310#12484#12540#12523#12496#12540'(&S)'
      Checked = True
      Hint = #27161#28310#12484#12540#12523#12496#12540#12398#34920#31034#29366#24907#12434#22793#26356#12377#12427
      OnExecute = StdToolBarVisibleActionExecute
    end
    object AddressBarVisibleAction: TAction
      Category = #34920#31034
      AutoCheck = True
      Caption = #12450#12489#12524#12473#12496#12540'(&A)'
      Checked = True
      Hint = #12450#12489#12524#12473#12496#12540#12398#34920#31034#29366#24907#12434#22793#26356#12377#12427
      OnExecute = AddressBarVisibleActionExecute
    end
    object LinkBarVisibleAction: TAction
      Category = #34920#31034
      AutoCheck = True
      Caption = #12522#12531#12463#12496#12540'(&K)'
      Checked = True
      Hint = #12522#12531#12463#12496#12540#12398#34920#31034#29366#24907#12434#22793#26356#12377#12427
      OnExecute = LinkBarVisibleActionExecute
    end
    object ListToolBarVisibleAction: TAction
      Category = #34920#31034
      AutoCheck = True
      Caption = #12522#12473#12488#12484#12540#12523#12496#12540'(&L)'
      Checked = True
      Hint = #12522#12473#12488#12484#12540#12523#12496#12540#12398#34920#31034#29366#24907#12434#22793#26356#12377#12427
      OnExecute = ListToolBarVisibleActionExecute
    end
    object SearchAction: TAction
      Category = #12484#12540#12523
      Caption = #12525#12464#26908#32034'(&S)'
      Hint = #12525#12464#26908#32034#12480#12452#12450#12525#12464#12434#34920#31034#12377#12427
      ImageIndex = 34
      ShortCut = 49222
      OnExecute = SearchActionExecute
    end
    object GikoNaviWebPageAction: TAction
      Category = #12504#12523#12503
      Caption = #12462#12467#12490#12499#12398#12454#12455#12502#12469#12452#12488'(&G)'
      Hint = #12462#12467#12490#12499#12398#12454#12455#12502#12469#12452#12488#12434#34920#31034#12377#12427
      OnExecute = GikoNaviWebPageActionExecute
    end
    object MonazillaWebPageAction: TAction
      Category = #12504#12523#12503
      Caption = #12514#12490#12472#12521#12398#12454#12455#12502#12469#12452#12488'(&M)'
      Enabled = False
      Hint = #12514#12490#12472#12521#12398#12454#12455#12502#12469#12452#12488#12434#34920#31034#12377#12427
      OnExecute = MonazillaWebPageActionExecute
    end
    object BBS2chWebPageAction: TAction
      Category = #12504#12523#12503
      Caption = '2'#12385#12419#12435#12397#12427#12488#12483#12503#12506#12540#12472'(&N)'
      Hint = '2'#12385#12419#12435#12397#12427#12488#12483#12503#12506#12540#12472#12434#34920#31034#12377#12427
      OnExecute = BBS2chWebPageActionExecute
    end
    object GikoFolderOpenAction: TAction
      Category = #12504#12523#12503
      Caption = #12462#12467#12490#12499#12501#12457#12523#12480#12434#38283#12367'(&F)'
      Hint = #12462#12467#12490#12499#12398#12501#12457#12523#12480#12434#38283#12367
      OnExecute = GikoFolderOpenActionExecute
    end
    object AboutAction: TAction
      Category = #12504#12523#12503
      Caption = #12496#12540#12472#12519#12531#24773#22577'(&A)...'
      Hint = #12496#12540#12472#12519#12531#24773#22577#12434#34920#31034#12377#12427
      OnExecute = AboutActionExecute
    end
    object SelectTextClearAction: TAction
      Category = #12501#12449#12452#12523
      Caption = #32094#36796#12415#23653#27508#28040#21435'(&S)'
      Hint = #32094#36796#12415#23653#27508#12434#28040#21435#12377#12427
      OnExecute = SelectTextClearActionExecute
    end
    object NameTextClearAction: TAction
      Category = #12501#12449#12452#12523
      Caption = #12524#12473#12456#12487#12451#12479#21517#21069#23653#27508#20840#28040#21435'(&N)'
      Hint = #12524#12473#12456#12487#12451#12479#12398#21517#21069#23653#27508#12434#28040#21435#12377#12427
      OnExecute = NameTextClearActionExecute
    end
    object MailTextClearAction: TAction
      Category = #12501#12449#12452#12523
      Caption = #12524#12473#12456#12487#12451#12479#12513#12540#12523#23653#27508#28040#21435'(&N)'
      Hint = #12524#12473#12456#12487#12451#12479#12398#12513#12540#12523#23653#27508#12434#28040#21435#12377#12427
      OnExecute = MailTextClearActionExecute
    end
    object ExitAction: TAction
      Category = #12501#12449#12452#12523
      Caption = #32066#20102'(&X)'
      Hint = #12462#12467#12490#12499#12434#32066#20102#12377#12427
      OnExecute = ExitActionExecute
    end
    object ListNameBarVisibleAction: TAction
      Category = #34920#31034
      AutoCheck = True
      Caption = #12522#12473#12488#21517#31216'(&I)'
      Checked = True
      Hint = #12522#12473#12488#21517#31216#12398#34920#31034#29366#24907#12434#22793#26356#12377#12427
      OnExecute = ListNameBarVisibleActionExecute
    end
    object BrowserToolBarVisibleAction: TAction
      Category = #34920#31034
      AutoCheck = True
      Caption = #12502#12521#12454#12470#12484#12540#12523#12496#12540'(&B)'
      Checked = True
      Hint = #12502#12521#12454#12470#12484#12540#12523#12496#12540#12398#34920#31034#29366#24907#12434#22793#26356#12377#12427
      OnExecute = BrowserToolBarVisibleActionExecute
    end
    object BrowserNameBarVisibleAction: TAction
      Category = #34920#31034
      AutoCheck = True
      Caption = #12502#12521#12454#12470#21517#31216'(&R)'
      Checked = True
      Hint = #12502#12521#12454#12470#21517#31216#12398#34920#31034#29366#24907#12434#22793#26356#12377#12427
      OnExecute = BrowserNameBarVisibleActionExecute
    end
    object MsgBarVisibleAction: TAction
      Category = #34920#31034
      AutoCheck = True
      Caption = #12513#12483#12475#12540#12472#12496#12540'(&E)'
      Hint = #12513#12483#12475#12540#12472#12496#12540#12398#34920#31034#29366#24907#12434#22793#26356#12377#12427
      OnExecute = MsgBarVisibleActionExecute
    end
    object MsgBarCloseAction: TAction
      Category = #34920#31034
      Caption = #38281#12376#12427'(&C)'
      Hint = #12513#12483#12475#12540#12472#12496#12540#12434#38281#12376#12427
      OnExecute = MsgBarCloseActionExecute
    end
    object StatusBarVisibleAction: TAction
      Category = #34920#31034
      AutoCheck = True
      Caption = #12473#12486#12540#12479#12473#12496#12540'(&U)'
      Hint = #12473#12486#12540#12479#12473#12496#12540#12398#34920#31034#29366#24907#12434#22793#26356#12377#12427
      OnExecute = StatusBarVisibleActionExecute
    end
    object CabinetBBSAction: TAction
      Category = #34920#31034
      AutoCheck = True
      Caption = #25522#31034#26495'(&N)'
      Hint = #12461#12515#12499#12493#12483#12488#12398#34920#31034#12434#25522#31034#26495#12395#12377#12427
      ImageIndex = 35
      OnExecute = CabinetBBSActionExecute
    end
    object CabinetHistoryAction: TAction
      Category = #34920#31034
      AutoCheck = True
      Caption = #23653#27508#12522#12473#12488'(&H)'
      Hint = #12461#12515#12499#12493#12483#12488#12398#34920#31034#12434#23653#27508#12522#12473#12488#12395#12377#12427
      ImageIndex = 36
      OnExecute = CabinetHistoryActionExecute
    end
    object OnlyNewResAction: TAction
      Category = #12473#12524#12483#12489
      AutoCheck = True
      Caption = #26032#30528#12524#12473#12398#12415#34920#31034'(&N)'
      GroupIndex = 2
      Hint = #26032#30528#12524#12473#12398#12415#34920#31034
      ImageIndex = 45
      OnExecute = OnlyNewResActionExecute
    end
    object CabinetFavoriteAction: TAction
      Category = #34920#31034
      AutoCheck = True
      Caption = #12362#27671#12395#20837#12426'(&A)'
      Hint = #12461#12515#12499#12493#12483#12488#12398#34920#31034#12434#12362#27671#12395#20837#12426#12522#12473#12488#12395#12377#12427
      ImageIndex = 37
      OnExecute = CabinetFavoriteActionExecute
    end
    object CabinetVisibleAction: TAction
      Category = #34920#31034
      AutoCheck = True
      Caption = #12461#12515#12499#12493#12483#12488#34920#31034'(&O)'
      Hint = #12461#12515#12499#12493#12483#12488#12398#34920#31034#29366#24907#12434#22793#26356#12377#12427
      ImageIndex = 1
      OnExecute = CabinetVisibleActionExecute
    end
    object ListNumberVisibleAction: TAction
      Category = #26495
      AutoCheck = True
      Caption = #12522#12473#12488#30058#21495#34920#31034'(&N)'
      Hint = #12522#12473#12488#30058#21495#34920#31034#12434#22793#26356#12377#12427
      ImageIndex = 6
      OnExecute = ListNumberVisibleActionExecute
    end
    object UpFolderAction: TAction
      Category = #26495
      Caption = #19978#12408'(&U)'
      Hint = #19978#20301#12501#12457#12523#12480#12395#31227#21205#12377#12427
      ImageIndex = 8
      ShortCut = 8
      OnExecute = UpFolderActionExecute
      OnUpdate = UpFolderActionUpdate
    end
    object CabinetCloseAction: TAction
      Category = #34920#31034
      Caption = #38281#12376#12427'(&C)'
      Hint = #12461#12515#12499#12493#12483#12488#12434#38281#12376#12427
      OnExecute = CabinetCloseActionExecute
    end
    object IconStyle: TAction
      Category = #26495
      Caption = #34920#31034'(&V)'
      Hint = #34920#31034
      ImageIndex = 7
      OnExecute = IconStyleExecute
    end
    object LargeIconAction: TAction
      Category = #34920#31034
      Caption = #22823#12365#12356#12450#12452#12467#12531'(&G)'
      GroupIndex = 2
      Hint = #12522#12473#12488#12434#22823#12365#12356#12450#12452#12467#12531#34920#31034#12395#12377#12427
      OnExecute = LargeIconActionExecute
    end
    object SmallIconAction: TAction
      Category = #34920#31034
      Caption = #23567#12373#12356#12450#12452#12467#12531'(&M)'
      GroupIndex = 2
      Hint = #12522#12473#12488#12434#23567#12373#12356#12450#12452#12467#12531#34920#31034#12395#12377#12427
      OnExecute = SmallIconActionExecute
    end
    object ListIconAction: TAction
      Category = #34920#31034
      Caption = #19968#35239'(&L)'
      GroupIndex = 2
      Hint = #12522#12473#12488#12434#19968#35239#34920#31034#12395#12377#12427
      OnExecute = ListIconActionExecute
    end
    object DetailIconAction: TAction
      Category = #34920#31034
      Caption = #35443#32048'(&D)'
      GroupIndex = 2
      Hint = #12522#12473#12488#12434#35443#32048#34920#31034#12395#12377#12427
      OnExecute = DetailIconActionExecute
    end
    object MidokuAction: TAction
      Category = #32232#38598
      Caption = #26410#35501#12395#12377#12427'(&M)'
      Hint = #36984#25246#12373#12428#12390#12356#12427#12473#12524#12483#12489#12434#26410#35501#12395#12377#12427
      OnExecute = MidokuActionExecute
    end
    object AllSelectAction: TAction
      Category = #32232#38598
      Caption = #12377#12409#12390#36984#25246'(&A)'
      Hint = #12522#12473#12488#12434#12377#12409#12390#36984#25246#12377#12427
      ShortCut = 16449
      OnExecute = AllSelectActionExecute
      OnUpdate = AllSelectActionUpdate
    end
    object AllItemAction: TAction
      Category = #26495
      AutoCheck = True
      Caption = #12377#12409#12390#12398#12473#12524#12483#12489#12434#34920#31034'(&A)'
      GroupIndex = 1
      Hint = #12473#12524#12483#12489#12434#12377#12409#12390#34920#31034#12377#12427
      ImageIndex = 9
      ShortCut = 16433
      OnExecute = AllItemActionExecute
      OnUpdate = DependActiveListTBoardWithSpeciapActionUpdate
    end
    object LogItemAction: TAction
      Category = #26495
      AutoCheck = True
      Caption = #12525#12464#26377#12426#12473#12524#12483#12489#34920#31034'(&L)'
      GroupIndex = 1
      Hint = #12525#12464#26377#12426#12473#12524#12483#12489#12398#12415#34920#31034#12377#12427
      ImageIndex = 10
      ShortCut = 16434
      OnExecute = LogItemActionExecute
      OnUpdate = DependActiveListTBoardWithSpeciapActionUpdate
    end
    object NewItemAction: TAction
      Category = #26495
      AutoCheck = True
      Caption = #26032#30528#12473#12524#12483#12489#34920#31034'(&N)'
      GroupIndex = 1
      Hint = #26032#30528#12473#12524#12483#12489#12398#12415#34920#31034#12377#12427
      ImageIndex = 11
      ShortCut = 16435
      OnExecute = NewItemActionExecute
      OnUpdate = DependActiveListTBoardWithSpeciapActionUpdate
    end
    object ArchiveItemAction: TAction
      Category = #26495
      AutoCheck = True
      Caption = 'DAT'#33853#12385#12473#12524#12483#12489#34920#31034'(&D)'
      GroupIndex = 1
      Hint = 'DAT'#33853#12385#12473#12524#12483#12489#12398#12415#34920#31034#12377#12427
      ImageIndex = 55
      OnExecute = ArchiveItemActionExecute
      OnUpdate = DependActiveListTBoardWithSpeciapActionUpdate
    end
    object LiveItemAction: TAction
      Category = #26495
      AutoCheck = True
      Caption = #29983#23384#12473#12524#12483#12489#34920#31034'(&S)'
      GroupIndex = 1
      Hint = #29983#23384#12375#12390#12356#12427#12473#12524#12483#12489#12398#12415#12434#34920#31034#12377#12427
      ImageIndex = 54
      OnExecute = LiveItemActionExecute
      OnUpdate = DependActiveListTBoardWithSpeciapActionUpdate
    end
    object ThreadRangeAction: TAction
      Category = #26495
      AutoCheck = True
      Caption = #12473#12524#12483#12489#12398#34920#31034#31684#22258#12434#35373#23450'(&H)'
      GroupIndex = 1
      Hint = #12473#12524#12483#12489#12398#34920#31034#31684#22258#12434#35373#23450
      ImageIndex = 10
      OnExecute = ThreadRangeActionExecute
      OnUpdate = DependActiveListTBoardWithSpeciapActionUpdate
    end
    object SelectItemAction: TAction
      Category = #26495
      AutoCheck = True
      Caption = #12473#12524#12483#12489#32094#36796#12415#34920#31034'(&S)...'
      GroupIndex = 1
      Hint = #12473#12524#12483#12489#32094#36796#12415#12480#12452#12450#12525#12464#12434#34920#31034#12377#12427
      ImageIndex = 12
      ShortCut = 16436
      OnExecute = SelectItemActionExecute
      OnUpdate = DependActiveListTBoardWithSpeciapActionUpdate
    end
    object StopAction: TAction
      Category = #34920#31034
      Caption = #20013#27490'(&S)'
      GroupIndex = 2
      Hint = #12480#12454#12531#12525#12540#12489#12434#20013#27490#12377#12427
      ImageIndex = 2
      ShortCut = 27
      OnExecute = StopActionExecute
    end
    object OptionAction: TAction
      Category = #12484#12540#12523
      Caption = #12458#12503#12471#12519#12531'(&O)...'
      Hint = #12458#12503#12471#12519#12531#12480#12452#12450#12525#12464#12434#34920#31034#12377#12427
      OnExecute = OptionActionExecute
    end
    object RoundAction: TAction
      Category = #12484#12540#12523
      Caption = #24033#22238#12434#23455#34892'(&R)...'
      Hint = #24033#22238#12480#12452#12450#12525#12464#12434#34920#31034#12377#12427
      ImageIndex = 0
      OnExecute = RoundActionExecute
    end
    object BrowserMaxAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #12473#12524#12434#22823#12365#12367#34920#31034'(&E)'
      Hint = #12473#12524#12483#12489#34920#31034#12456#12522#12450#12434#22823#12365#12367#34920#31034#12377#12427
      ImageIndex = 16
      OnExecute = BrowserMaxActionExecute
    end
    object BrowserMinAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #12473#12524#12434#23567#12373#12367#34920#31034'(&W)'
      Hint = #12473#12524#12483#12489#34920#31034#12456#12522#12450#12434#23567#12373#12367#34920#31034#12377#12427
      ImageIndex = 17
      OnExecute = BrowserMinActionExecute
    end
    object ScrollTopAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #20808#38957#12408#31227#21205'(&T)'
      Hint = #29694#22312#34920#31034#12375#12390#12356#12427#12473#12524#12483#12489#12398#20808#38957#12408#31227#21205#12377#12427
      ImageIndex = 22
      OnExecute = ScrollTopActionExecute
      OnUpdate = DependActiveCntentLogActionUpdate
    end
    object ScrollLastAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #26368#24460#12408#31227#21205'(&L)'
      Hint = #29694#22312#34920#31034#12375#12390#12356#12427#12473#12524#12483#12489#26368#24460#12408#31227#21205#12377#12427
      ImageIndex = 23
      OnExecute = ScrollLastActionExecute
      OnUpdate = DependActiveCntentLogActionUpdate
    end
    object ScrollNewAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #26032#30528#12408#31227#21205'(&N)'
      Hint = #29694#22312#34920#31034#12375#12390#12356#12427#12473#12524#12483#12489#12398#26032#30528#12408#31227#21205#12377#12427
      ImageIndex = 24
      OnExecute = ScrollNewActionExecute
      OnUpdate = DependActiveCntentLogActionUpdate
    end
    object ScrollKokoAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #12467#12467#12414#12391#35501#12435#12384#12408#31227#21205'(&K)'
      Hint = #29694#22312#34920#31034#12375#12390#12356#12427#12473#12524#12483#12489#12398#12467#12467#12414#12391#35501#12435#12384#12408#31227#21205#12377#12427
      ImageIndex = 25
      OnExecute = ScrollKokoActionExecute
      OnUpdate = ScrollKokoActionUpdate
    end
    object ScrollPageDownAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #27425#12506#12540#12472
      Hint = #27425#12506#12540#12472#12473#12463#12525#12540#12523
      OnExecute = ScrollPageDownActionExecute
      OnUpdate = DependActiveCntentActionUpdate
    end
    object ScrollPageUpAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #21069#12506#12540#12472#12473#12463#12525#12540#12523
      Hint = #21069#12506#12540#12472#12473#12463#12525#12540#12523
      OnExecute = ScrollPageUpActionExecute
      OnUpdate = DependActiveCntentActionUpdate
    end
    object EditorAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #12524#12473#26360#12365#36796#12415'(&R)'
      Hint = #12524#12473#26360#12365#36796#12415#12454#12451#12531#12489#12454#12434#34920#31034#12377#12427
      ImageIndex = 26
      ShortCut = 16466
      OnExecute = EditorActionExecute
      OnUpdate = DependActiveCntentLogActionUpdate
    end
    object IEAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #12502#12521#12454#12470#12391#34920#31034'(&B)'
      Hint = #12473#12524#12434#12502#12521#12454#12470#12391#34920#31034#12377#12427
      ImageIndex = 27
      OnExecute = IEActionExecute
      OnUpdate = DependActiveCntentActionUpdate
    end
    object ShowThreadAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #12473#12524#12483#12489#12434#12502#12521#12454#12470#12391#34920#31034'(&S)'
      Hint = #29694#22312#34920#31034#12375#12390#12356#12427#12473#12524#12483#12489#12434#12502#12521#12454#12470#12391#34920#31034#12377#12427
      ImageIndex = 27
      OnExecute = ShowThreadActionExecute
      OnUpdate = DependActiveCntentActionUpdate
    end
    object ShowBoardAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #26495#12434#12502#12521#12454#12470#12391#34920#31034'(&B)'
      Hint = #29694#22312#34920#31034#12375#12390#12356#12427#12473#12524#12483#12489#12398#26495#12434#12502#12521#12454#12470#12391#34920#31034#12377#12427
      ImageIndex = 27
      OnExecute = ShowBoardActionExecute
      OnUpdate = DependActiveCntentActionUpdate
    end
    object URLCopyAction: TAction
      Category = #12473#12524#12483#12489
      Caption = 'URL'#12434#12467#12500#12540'(&C)'
      Hint = #29694#22312#34920#31034#12375#12390#12356#12427#12473#12524#12483#12489#12398'URL'#12434#12467#12500#12540#12377#12427
      OnExecute = URLCopyActionExecute
      OnUpdate = DependActiveCntentActionUpdate
    end
    object NameCopyAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #12473#12524#12483#12489#21517#12434#12467#12500#12540'(&T)'
      Hint = #29694#22312#34920#31034#12375#12390#12356#12427#12473#12524#12483#12489#21517#12434#12467#12500#12540#12377#12427
      OnExecute = NameCopyActionExecute
      OnUpdate = DependActiveCntentActionUpdate
    end
    object NameURLCopyAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #12473#12524#12483#12489#21517#12392'URL'#12434#12467#12500#12540'(&M)'
      Hint = #29694#22312#34920#31034#12375#12390#12356#12427#12473#12524#12483#12489#21517#12392'URL'#12434#12467#12500#12540#12377#12427
      OnExecute = NameURLCopyActionExecute
      OnUpdate = DependActiveCntentActionUpdate
    end
    object ItemReloadAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #12473#12524#12483#12489#12480#12454#12531#12525#12540#12489'(&A)'
      Hint = #34920#31034#12373#12428#12390#12356#12427#12473#12524#12483#12489#12434#12480#12454#12531#12525#12540#12489#12377#12427
      ImageIndex = 28
      OnExecute = ItemReloadActionExecute
      OnUpdate = DependActiveCntentActionUpdate
    end
    object ThreadEditorAction: TAction
      Category = #26495
      Caption = #26032#12473#12524#20316#25104'(&T)'
      Hint = #26032#12473#12524#26360#12365#36796#12415#12454#12451#12531#12489#12454#12434#34920#31034#12377#12427
      ImageIndex = 26
      OnExecute = ThreadEditorActionExecute
      OnUpdate = DependActiveListTBoardActionUpdate
    end
    object BoardIEAction: TAction
      Category = #26495
      Caption = #12502#12521#12454#12470#12391#34920#31034'(&B)'
      Hint = #29694#22312#34920#31034#12375#12390#12356#12427#26495#12434#12502#12521#12454#12470#12391#34920#31034#12377#12427
      ImageIndex = 27
      OnExecute = BoardIEActionExecute
      OnUpdate = DependActiveListTBoardActionUpdate
    end
    object SelectItemURLCopyAction: TAction
      Category = #26495
      Caption = 'URL'#12434#12467#12500#12540'(&C)'
      Hint = #36984#25246#12373#12428#12390#12356#12427#12473#12524#12483#12489#12398'URL'#12434#12467#12500#12540#12377#12427
      OnExecute = SelectItemURLCopyActionExecute
      OnUpdate = SelectItemURLCopyActionUpdate
    end
    object SelectItemNameCopyAction: TAction
      Category = #26495
      Caption = #21517#21069#12434#12467#12500#12540'(&C)'
      Hint = #36984#25246#12373#12428#12390#12356#12427#26495#12398#21517#21069#12434#12467#12500#12540#12377#12427
      OnExecute = SelectItemNameCopyActionExecute
      OnUpdate = SelectItemNameCopyActionUpdate
    end
    object SelectItemNameURLCopyAction: TAction
      Category = #26495
      Caption = #21517#21069#12392'URL'#12434#12467#12500#12540'(&N)'
      Hint = #36984#25246#12373#12428#12390#12356#12427#12473#12524#12483#12489#12398#21517#21069#12392'URL'#12434#12467#12500#12540#12377#12427
      OnExecute = SelectItemNameURLCopyActionExecute
      OnUpdate = SelectItemNameCopyActionUpdate
    end
    object SelectListReloadAction: TAction
      Category = #26495
      Caption = #36984#25246#12473#12524#12483#12489#19968#35239#12480#12454#12531#12525#12540#12489'(&D)'
      Hint = #36984#25246#12373#12428#12390#12356#12427#12473#12524#12483#12489#19968#35239#12434#12480#12454#12531#12525#12540#12489#12377#12427
      ImageIndex = 13
      OnExecute = SelectListReloadActionExecute
      OnUpdate = SelectListReloadActionUpdate
    end
    object SelectThreadReloadAction: TAction
      Category = #26495
      Caption = #36984#25246#12473#12524#12483#12489#12480#12454#12531#12525#12540#12489'(&E)'
      Hint = #36984#25246#12373#12428#12390#12356#12427#12473#12524#12483#12489#12434#12480#12454#12531#12525#12540#12489#12377#12427
      ImageIndex = 14
      OnExecute = SelectThreadReloadActionExecute
      OnUpdate = SelectThreadReloadActionUpdate
    end
    object BrowserTabCloseAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #12450#12463#12486#12451#12502#12479#12502#12434#38281#12376#12427'(&X)'
      Hint = #29694#22312#38283#12356#12390#12356#12427#12479#12502#12434#38281#12376#12427
      ImageIndex = 41
      OnExecute = BrowserTabCloseActionExecute
      OnUpdate = BrowserTabCloseActionUpdate
    end
    object NotSelectTabCloseAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #12450#12463#12486#12451#12502#12479#12502#20197#22806#12434#38281#12376#12427'(&V)'
      Hint = #29694#22312#38283#12356#12390#12356#12427#12479#12502#20197#22806#12434#20840#12390#38281#12376#12427
      ImageIndex = 39
      OnExecute = NotSelectTabCloseActionExecute
      OnUpdate = NotSelectTabCloseActionUpdate
    end
    object AllTabCloseAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #12377#12409#12390#12398#12479#12502#12434#38281#12376#12427'(&Z)'
      Hint = #12377#12409#12390#12398#12479#12502#12434#38281#12376#12427
      ImageIndex = 40
      OnExecute = AllTabCloseActionExecute
      OnUpdate = BrowserTabCloseActionUpdate
    end
    object KokomadeAction: TAction
      Tag = -1
      Category = #12502#12521#12454#12470#12509#12483#12503#12450#12483#12503
      Caption = #12467#12467#12414#12391#35501#12435#12384'(&K)'
      OnExecute = KokomadeActionExecute
    end
    object ZenbuAction: TAction
      Tag = -1
      Category = #12502#12521#12454#12470#12509#12483#12503#12450#12483#12503
      Caption = #20840#37096#35501#12435#12384'(&A)'
      OnExecute = ZenbuActionExecute
    end
    object KokoResAction: TAction
      Tag = -1
      Category = #12502#12521#12454#12470#12509#12483#12503#12450#12483#12503
      Caption = #12467#12467#12395#12524#12473'(&R)'
      OnExecute = KokoResActionExecute
    end
    object TreeSelectBoradReload: TAction
      Tag = -1
      Category = #12484#12522#12540#12509#12483#12503#12450#12483#12503
      Caption = #12473#12524#12483#12489#19968#35239#12480#12454#12531#12525#12540#12489'(&D)'
      Hint = #12473#12524#12483#12489#19968#35239#12434#12480#12454#12531#12525#12540#12489#12377#12427
      OnExecute = TreeSelectBoradReloadExecute
    end
    object TreeSelectThreadReload: TAction
      Tag = -1
      Category = #12484#12522#12540#12509#12483#12503#12450#12483#12503
      Caption = #36984#25246#12473#12524#12483#12489#12480#12454#12531#12525#12540#12489'(&E)'
      Hint = #36984#25246#12373#12428#12383#12473#12524#12483#12489#12434#12480#12454#12531#12525#12540#12489#12377#12427
      OnExecute = TreeSelectThreadReloadExecute
    end
    object TreeSelectURLCopy: TAction
      Tag = -1
      Category = #12484#12522#12540#12509#12483#12503#12450#12483#12503
      Caption = 'URL'#12434#12467#12500#12540'(&C)'
      Hint = #36984#25246#12373#12428#12383#26495#12398'URL'#12434#12467#12500#12540#12377#12427
      OnExecute = TreeSelectURLCopyExecute
    end
    object SelectReservAction: TAction
      Category = #26495
      Caption = #12473#12524#12483#12489#24033#22238#20104#32004'(&R)'
      Hint = #12473#12524#12483#12489#24033#22238#20104#32004
      ImageIndex = 15
      OnExecute = SelectReservActionExecute
      OnUpdate = SelectReservActionUpdate
    end
    object SelectNewRoundName: TAction
      Category = #26495
      Caption = #26032#12375#12356#21517#21069#12391#24033#22238#20104#32004
      Hint = #36984#25246#12373#12428#12390#12356#12427#12473#12524#12483#12489#12395#26032#12375#12356#21517#21069#12391#24033#22238#12434#25351#23450#12377#12427
      OnExecute = SelectNewRoundNameExecute
    end
    object SelectDeleteRound: TAction
      Category = #26495
      Caption = #24033#22238#20104#32004#21066#38500
      Hint = #36984#25246#12373#12428#12390#12356#12427#12473#12524#12483#12489#12398#24033#22238#12434#21066#38500#12377#12427
      OnExecute = SelectDeleteRoundExecute
    end
    object KeySettingAction: TAction
      Category = #12484#12540#12523
      Caption = #12461#12540#35373#23450'(&K)...'
      Hint = #12461#12540#35373#23450#12480#12452#12450#12525#12464#12434#38283#12367
      OnExecute = KeySettingActionExecute
    end
    object ArrangeAction: TAction
      Category = #34920#31034
      AutoCheck = True
      Caption = #32294#27178#37197#32622#12434#22793#26356#12377#12427'(&H)'
      Hint = #12522#12473#12488#12392#12502#12521#12454#12470#12398#32294#27178#37197#32622#12434#22793#26356#12377#12427
      ImageIndex = 4
      OnExecute = ArrangeActionExecute
    end
    object ActiveLogDeleteAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #12450#12463#12486#12451#12502#12479#12502#12398#12525#12464#12434#21066#38500'(&D)'
      Hint = #29694#22312#38283#12356#12390#12356#12427#12479#12502#12398#12473#12524#12483#12489#12434#21066#38500#12377#12427
      ImageIndex = 29
      OnExecute = ActiveLogDeleteActionExecute
      OnUpdate = DependActiveCntentActionUpdate
    end
    object TreeSelectNameURLCopy: TAction
      Tag = -1
      Category = #12484#12522#12540#12509#12483#12503#12450#12483#12503
      Caption = #21517#21069#12392'URL'#12434#12467#12500#12540'(&N)'
      Hint = #36984#25246#12373#12428#12383#26495#12398#21517#21069#12392'URL'#12434#12467#12500#12540#12377#12427
      OnExecute = TreeSelectNameURLCopyExecute
    end
    object PaneInitAction: TAction
      Category = #34920#31034
      Caption = #12506#12452#12531#12398#12469#12452#12474#12434#21021#26399#21270#12377#12427'(&I)'
      GroupIndex = 2
      Hint = #12506#12452#12531#12398#12469#12452#12474#12434#21021#26399#21270#12377#12427
      OnExecute = PaneInitActionExecute
    end
    object LeftmostTabSelectAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #19968#30058#24038#12398#12479#12502#36984#25246'(&F)'
      Hint = #19968#30058#24038#12398#12479#12502#12434#36984#25246#12377#12427
      ImageIndex = 50
      OnExecute = LeftmostTabSelectActionExecute
      OnUpdate = LeftmostTabSelectActionUpdate
    end
    object LeftTabSelectAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #24038#12398#12479#12502#36984#25246'(&G)'
      Hint = #24038#12398#12479#12502#12434#36984#25246#12377#12427
      ImageIndex = 48
      OnExecute = LeftTabSelectActionExecute
      OnUpdate = LeftTabSelectActionUpdate
    end
    object RightTabSelectAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #21491#12398#12479#12502#36984#25246'(&H)'
      Hint = #21491#12398#12479#12502#12434#36984#25246#12377#12427
      ImageIndex = 47
      OnExecute = RightTabSelectActionExecute
      OnUpdate = RightTabSelectActionUpdate
    end
    object RightmostTabSelectAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #19968#30058#21491#12398#12479#12502#36984#25246'(&J)'
      Hint = #19968#30058#21491#12398#12479#12502#12434#36984#25246#12377#12427
      ImageIndex = 49
      OnExecute = RightmostTabSelectActionExecute
      OnUpdate = RightmostTabSelectActionUpdate
    end
    object FavoriteAddAction: TAction
      Category = #12362#27671#12395#20837#12426
      Caption = #12362#27671#12395#20837#12426#12395#36861#21152'(&A)...'
      Hint = #12362#27671#12395#20837#12426#36861#21152#12480#12452#12450#12525#12464#12434#38283#12367
      OnExecute = FavoriteAddActionExecute
      OnUpdate = DependActiveCntentActionUpdate
    end
    object BoardFavoriteAddAction: TAction
      Category = #26495
      Caption = #12362#27671#12395#20837#12426#12395#36861#21152'(&F)...'
      Hint = #36984#25246#12373#12428#12390#12356#12427#26495#12434#12362#27671#12395#20837#12426#12395#36861#21152#12377#12427
      OnExecute = BoardFavoriteAddActionExecute
      OnUpdate = BoardFavoriteAddActionUpdate
    end
    object ThreadFavoriteAddAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #12362#27671#12395#20837#12426#12395#36861#21152'(&F)...'
      Hint = #36984#25246#12373#12428#12390#12356#12427#12473#12524#12483#12489#12434#12362#27671#12395#20837#12426#12395#36861#21152#12377#12427
      OnExecute = ThreadFavoriteAddActionExecute
      OnUpdate = ThreadFavoriteAddActionUpdate
    end
    object TreeSelectFavoriteAddAction: TAction
      Tag = -1
      Category = #12484#12522#12540#12509#12483#12503#12450#12483#12503
      Caption = #12362#27671#12395#20837#12426#12395#36861#21152'(&F)...'
      Hint = #12362#27671#12395#20837#12426#12395#36861#21152#12377#12427
      OnExecute = TreeSelectFavoriteAddActionExecute
    end
    object FavoriteArrangeAction: TAction
      Category = #12362#27671#12395#20837#12426
      Caption = #12362#27671#12395#20837#12426#12398#25972#29702'(&O)...'
      Hint = #12362#27671#12395#20837#12426#25972#29702#12480#12452#12450#12525#12464#12434#38283#12367
      OnExecute = FavoriteArrangeActionExecute
    end
    object MoveToAction: TAction
      Category = #12450#12489#12524#12473#12496#12540
      Caption = #31227#21205
      Hint = #12450#12489#12524#12473#12496#12540#12395#34920#31034#12375#12390#12356#12427#12450#12489#12524#12473#12408#31227#21205#12377#12427
      ImageIndex = 33
      OnExecute = MoveToActionExecute
    end
    object BrowserTabVisibleAction: TAction
      Category = #34920#31034
      AutoCheck = True
      Caption = #34920#31034'(&V)'
      Hint = #12502#12521#12454#12470#12479#12502#12398#34920#31034#29366#24907#12434#22793#26356#12377#12427
      OnExecute = BrowserTabVisibleActionExecute
    end
    object BrowserTabTopAction: TAction
      Category = #34920#31034
      AutoCheck = True
      Caption = #19978#12395#34920#31034'(&T)'
      GroupIndex = 1
      Hint = #12502#12521#12454#12470#12479#12502#12434#19978#12395#34920#31034#12377#12427
      OnExecute = BrowserTabTopActionExecute
    end
    object BrowserTabBottomAction: TAction
      Category = #34920#31034
      AutoCheck = True
      Caption = #19979#12395#34920#31034'(&B)'
      GroupIndex = 1
      Hint = #12502#12521#12454#12470#12479#12502#12434#19979#12395#34920#31034#12377#12427
      OnExecute = BrowserTabBottomActionExecute
    end
    object BrowserTabTabStyleAction: TAction
      Category = #34920#31034
      AutoCheck = True
      Caption = #12479#12502' '#12473#12479#12452#12523'(&A)'
      GroupIndex = 2
      Hint = #12502#12521#12454#12470#12479#12502#12398#12473#12479#12452#12523#12434#12479#12502#12473#12479#12452#12523#12395#12377#12427
      OnExecute = BrowserTabTabStyleActionExecute
    end
    object BrowserTabButtonStyleAction: TAction
      Category = #34920#31034
      AutoCheck = True
      Caption = #12508#12479#12531' '#12473#12479#12452#12523'(&U)'
      GroupIndex = 2
      Hint = #12502#12521#12454#12470#12479#12502#12398#12473#12479#12452#12523#12434#12508#12479#12531#12473#12479#12452#12523#12395#12377#12427
      OnExecute = BrowserTabButtonStyleActionExecute
    end
    object BrowserTabFlatStyleAction: TAction
      Category = #34920#31034
      AutoCheck = True
      Caption = #12501#12521#12483#12488#12508#12479#12531' '#12473#12479#12452#12523'(&F)'
      GroupIndex = 2
      Hint = #12502#12521#12454#12470#12479#12502#12398#12473#12479#12452#12523#12434#12501#12521#12483#12488#12508#12479#12531#12473#12479#12452#12523#12395#12377#12427
      OnExecute = BrowserTabFlatStyleActionExecute
    end
    object GikoHelpAction: TAction
      Category = #12504#12523#12503
      Caption = #12462#12467#12490#12499' '#12504#12523#12503'(&H)'
      Hint = #12462#12467#12490#12499#12398#12504#12523#12503#12434#34920#31034#12377#12427
      OnExecute = GikoHelpActionExecute
    end
    object KotehanAction: TAction
      Category = #12484#12540#12523
      Caption = #12467#12486#12495#12531#35373#23450'(&H)...'
      Hint = #12467#12486#12495#12531#35373#23450#12480#12452#12450#12525#12464#12434#38283#12367
      OnExecute = KotehanActionExecute
    end
    object ToolBarSettingAction: TAction
      Category = #12484#12540#12523
      Caption = #12484#12540#12523#12496#12540#35373#23450'(&T)...'
      Hint = #12484#12540#12523#12496#12540#35373#23450#12480#12452#12450#12525#12464#12434#38283#12367
      OnExecute = ToolBarSettingActionExecute
    end
    object SelectResAction: TAction
      Category = #12473#12524#12483#12489
      AutoCheck = True
      Caption = #12524#12473#32094#36796#12415#34920#31034'(&S)...'
      GroupIndex = 2
      Hint = #12524#12473#12398#20869#23481#12434#32094#36796#12416
      ImageIndex = 12
      OnExecute = SelectResActionExecute
      OnUpdate = DependActiveCntentLogActionUpdate
    end
    object AllResAction: TAction
      Category = #12473#12524#12483#12489
      AutoCheck = True
      Caption = #12377#12409#12390#12398#12524#12473#12434#34920#31034'(&A)'
      GroupIndex = 2
      Hint = #12377#12409#12390#12398#12524#12473#12434#34920#31034#12377#12427
      ImageIndex = 9
      OnExecute = AllResActionExecute
    end
    object EditNGAction: TAction
      Category = 'NGword'
      Caption = 'NG'#12527#12540#12489#12501#12449#12452#12523#32232#38598
      Hint = 'NG'#12527#12540#12489#12501#12449#12452#12523#32232#38598
      ImageIndex = 43
      OnExecute = EditNGActionExecute
    end
    object ReloadAction: TAction
      Category = 'NGword'
      Caption = 'NG'#12527#12540#12489#35501#12415#36796#12415#65288#20877#35501#12415#36796#12415#65289
      Hint = 'NG'#12527#12540#12489#35501#12415#36796#12415#65288#20877#35501#12415#36796#12415#65289
      OnExecute = ReloadActionExecute
    end
    object GoFowardAction: TAction
      Category = 'NGword'
      Caption = 'NG'#12527#12540#12489#35501#12415#36796#12415#65288#19968#12388#24460#12429#65289
      Hint = 'NG'#12527#12540#12489#35501#12415#36796#12415#65288#19968#12388#24460#12429#65289
      OnExecute = GoFowardActionExecute
    end
    object GoBackAction: TAction
      Category = 'NGword'
      Caption = 'NG'#12527#12540#12489#35501#12415#36796#12415#65288#19968#12388#21069#65289
      Hint = 'NG'#12527#12540#12489#35501#12415#36796#12415#65288#19968#12388#21069#65289
      OnExecute = GoBackActionExecute
    end
    object TreeSelectSearchBoardName: TAction
      Tag = -1
      Category = #12484#12522#12540#12509#12483#12503#12450#12483#12503
      Caption = #26495#21517#26908#32034
      Hint = #26495#21517#26908#32034
      OnExecute = TreeSelectSearchBoardNameExecute
    end
    object FavoriteTreeViewRenameAction: TAction
      Tag = -1
      Category = #12362#27671#12395#20837#12426#12484#12522#12540#12509#12483#12503#12450#12483#12503
      Caption = #21517#21069#12398#22793#26356'(&M)'
      Hint = #12362#27671#12395#20837#12426#12398#21517#21069#12434#32232#38598#12377#12427
      ImageIndex = 26
      OnExecute = FavoriteTreeViewRenameActionExecute
    end
    object FavoriteTreeViewNewFolderAction: TAction
      Tag = -1
      Category = #12362#27671#12395#20837#12426#12484#12522#12540#12509#12483#12503#12450#12483#12503
      Caption = #26032#12375#12356#12501#12457#12523#12480#12398#20316#25104'(&W)'
      Hint = #26032#12375#12367#12362#27671#12395#20837#12426#12395#12501#12457#12523#12480#12434#20316#25104#12377#12427
      ImageIndex = 31
      OnExecute = FavoriteTreeViewNewFolderActionExecute
    end
    object FavoriteTreeViewDeleteAction: TAction
      Tag = -1
      Category = #12362#27671#12395#20837#12426#12484#12522#12540#12509#12483#12503#12450#12483#12503
      Caption = #21066#38500'(&D)'
      Hint = #12371#12398#12362#27671#12395#20837#12426#12434#21066#38500#12377#12427
      ImageIndex = 29
      OnExecute = FavoriteTreeViewDeleteActionExecute
    end
    object FavoriteTreeViewBrowseFolderAction: TAction
      Tag = -1
      Category = #12362#27671#12395#20837#12426#12484#12522#12540#12509#12483#12503#12450#12483#12503
      Caption = #12371#12428#12425#12434#12377#12409#12390#38283#12367'(&A)'
      Hint = #12371#12398#12501#12457#12523#12480#12395#20837#12387#12390#12356#12427#12362#27671#12395#20837#12426#12434#20840#12390#38283#12367
      OnExecute = FavoriteTreeViewBrowseFolderActionExecute
    end
    object FavoriteTreeViewReloadAction: TAction
      Tag = -1
      Category = #12362#27671#12395#20837#12426#12484#12522#12540#12509#12483#12503#12450#12483#12503
      Caption = #12480#12454#12531#12525#12540#12489'(&R)'
      Hint = #36984#25246#12373#12428#12390#12356#12427#12362#27671#12395#20837#12426#12434#12480#12454#12531#12525#12540#12489#12377#12427
      ImageIndex = 14
      OnExecute = FavoriteTreeViewReloadActionExecute
    end
    object FavoriteTreeViewURLCopyAction: TAction
      Tag = -1
      Category = #12362#27671#12395#20837#12426#12484#12522#12540#12509#12483#12503#12450#12483#12503
      Caption = 'URL'#12434#12467#12500#12540'(&U)'
      Hint = #36984#25246#12373#12428#12390#12356#12427#12473#12524#12483#12489#12398'URL'#12434#12467#12500#12540#12377#12427
      OnExecute = FavoriteTreeViewURLCopyActionExecute
    end
    object FavoriteTreeViewNameCopyAction: TAction
      Tag = -1
      Category = #12362#27671#12395#20837#12426#12484#12522#12540#12509#12483#12503#12450#12483#12503
      Caption = #21517#21069#12434#12467#12500#12540'(&C)'
      Hint = #36984#25246#12373#12428#12390#12356#12427#26495#12398#21517#21069#12434#12467#12500#12540#12377#12427
      OnExecute = FavoriteTreeViewNameCopyActionExecute
    end
    object FavoriteTreeViewNameURLCopyAction: TAction
      Tag = -1
      Category = #12362#27671#12395#20837#12426#12484#12522#12540#12509#12483#12503#12450#12483#12503
      Caption = #21517#21069#12392'URL'#12434#12467#12500#12540'(&N)'
      Hint = #36984#25246#12373#12428#12390#12356#12427#12473#12524#12483#12489#12398#21517#21069#12392'URL'#12434#12467#12500#12540#12377#12427
      OnExecute = FavoriteTreeViewNameURLCopyActionExecute
    end
    object FavoriteTreeViewLogDeleteAction: TAction
      Tag = -1
      Category = #12362#27671#12395#20837#12426#12484#12522#12540#12509#12483#12503#12450#12483#12503
      Caption = #12525#12464#21066#38500'(&D)'
      Hint = #36984#25246#12373#12428#12390#12356#12427#12473#12524#12483#12489#12434#21066#38500#12377#12427
      OnExecute = FavoriteTreeViewLogDeleteActionExecute
    end
    object ResRangeAction: TAction
      Category = #12473#12524#12483#12489
      AutoCheck = True
      Caption = #34920#31034#31684#22258
      GroupIndex = 2
      Hint = #12524#12473#12398#34920#31034#31684#22258#12434#35373#23450
      ImageIndex = 38
      OnExecute = ResRangeActionExecute
    end
    object ExportFavoriteFile: TFileSaveAs
      Category = #12501#12449#12452#12523
      Caption = #12362#27671#12395#20837#12426#12398#12456#12463#12473#12509#12540#12488
      Dialog.Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
      Hint = #12362#27671#12395#20837#12426#12398#12456#12463#12473#12509#12540#12488
      BeforeExecute = ExportFavoriteFileBeforeExecute
      OnAccept = ExportFavoriteFileAccept
    end
    object FavoriteTreeViewBrowseBoardAction: TAction
      Tag = -1
      Category = #12362#27671#12395#20837#12426#12484#12522#12540#12509#12483#12503#12450#12483#12503
      Caption = #26495#12434#12502#12521#12454#12470#12391#34920#31034'(&B)'
      Hint = #29694#22312#34920#31034#12375#12390#12356#12427#12473#12524#12483#12489#12398#26495#12434#12502#12521#12454#12470#12391#34920#31034#12377#12427
      ImageIndex = 27
    end
    object FavoriteTreeViewBrowseThreadAction: TAction
      Tag = -1
      Category = #12362#27671#12395#20837#12426#12484#12522#12540#12509#12483#12503#12450#12483#12503
      Caption = #12473#12524#12483#12489#12434#12502#12521#12454#12470#12391#34920#31034'(&S)'
      Hint = #29694#22312#34920#31034#12375#12390#12356#12427#12473#12524#12483#12489#12434#12502#12521#12454#12470#12391#34920#31034#12377#12427
      ImageIndex = 27
      OnExecute = FavoriteTreeViewBrowseThreadActionExecute
    end
    object UpBoardAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #26495#12434#34920#31034
      Hint = #12371#12398#12473#12524#12483#12489#12434#21547#12416#12473#12524#12483#12489#19968#35239#12434#34920#31034
      ImageIndex = 8
      OnExecute = UpBoardActionExecute
      OnUpdate = DependActiveCntentActionUpdate
    end
    object KoreCopy: TAction
      Tag = -1
      Category = #12502#12521#12454#12470#12509#12483#12503#12450#12483#12503
      Caption = #12371#12398#12524#12473#12467#12500#12540
      Hint = #36984#25246#12375#12383#12524#12473#12434#12467#12500#12540#12377#12427
      OnExecute = KoreCopyExecute
    end
    object TreeSelectNameCopy: TAction
      Tag = -1
      Category = #12484#12522#12540#12509#12483#12503#12450#12483#12503
      Caption = #21517#21069#12434#12467#12500#12540'(&Y)'
      Hint = #36984#25246#12373#12428#12383#26495#12398#21517#21069#12434#12467#12500#12540#12377#12427
      OnExecute = TreeSelectNameCopyExecute
    end
    object SetFocusForBrowserAction: TAction
      Category = #34920#31034
      Caption = #12502#12521#12454#12470#12395#12501#12457#12540#12459#12473#12434#24403#12390#12427
      Hint = #12502#12521#12454#12470#12395#12501#12457#12540#12459#12473#12434#24403#12390#12427
      OnExecute = SetFocusForBrowserActionExecute
      OnUpdate = SetFocusForBrowserActionUpdate
    end
    object SetFocusForThreadListAction: TAction
      Category = #34920#31034
      Caption = #12473#12524#12483#12489#19968#35239#12395#12501#12457#12540#12459#12473#12434#24403#12390#12427
      Hint = #12473#12524#12483#12489#19968#35239#12395#12501#12457#12540#12459#12473#12434#24403#12390#12427
      OnExecute = SetFocusForThreadListActionExecute
    end
    object SetFocusForCabinetAction: TAction
      Category = #34920#31034
      Caption = #12461#12515#12499#12493#12483#12488#12395#12501#12457#12540#12459#12473#12434#24403#12390#12427
      Hint = #12461#12515#12499#12493#12483#12488#12395#12501#12457#12540#12459#12473#12434#24403#12390#12427
      OnExecute = SetFocusForCabinetActionExecute
      OnUpdate = SetFocusForCabinetActionUpdate
    end
    object FileRun1: TFileRun
      Tag = -1
      Category = #12501#12449#12452#12523
      Browse = False
      BrowseDlg.Title = #23455#34892
      Caption = #23455#34892'(&R)...'
      FileName = 'notepad'
      Hint = #23455#34892'|'#12450#12503#12522#12465#12540#12471#12519#12531#12398#23455#34892
      Operation = 'open'
      ShowCmd = scShowNormal
    end
    object ThreadlistMaxAndFocusAction: TAction
      Category = #34920#31034
      Caption = #12473#12524#12483#12489#19968#35239#12434#26368#22823#21270#12375#12390#12501#12457#12540#12459#12473#12434#24403#12390#12427
      Hint = #12473#12524#12483#12489#19968#35239#12434#26368#22823#21270#12375#12390#12501#12457#12540#12459#12473#12434#24403#12390#12427
      OnExecute = ThreadlistMaxAndFocusActionExecute
    end
    object BrowserMaxAndFocusAction: TAction
      Category = #34920#31034
      Caption = #12473#12524#34920#31034#12434#26368#22823#21270#12375#12390#12501#12457#12540#12459#12473#12434#24403#12390#12427
      Hint = #12473#12524#34920#31034#12434#26368#22823#21270#12375#12390#12501#12457#12540#12459#12473#12434#24403#12390#12427
      OnExecute = BrowserMaxAndFocusActionExecute
      OnUpdate = SetFocusForBrowserActionUpdate
    end
    object SelectItemSaveForHTML: TAction
      Category = #12501#12449#12452#12523
      Caption = 'HTML'#21270#12377#12427
      Hint = #36984#25246#12473#12524#12483#12489#12434'HTML'#21270#12375#12390#20445#23384
      ImageIndex = 44
      OnExecute = SelectItemSaveForHTMLExecute
    end
    object SelectItemSaveForDat: TAction
      Category = #12501#12449#12452#12523
      Caption = 'DAT'#24418#24335#12398#12414#12414
      Hint = #36984#25246#12473#12524#12483#12489#12434'DAT'#24418#24335#12398#12414#12414#20445#23384
      ImageIndex = 44
      OnExecute = SelectItemSaveForDatExecute
    end
    object LogFolderOpenAction: TAction
      Category = #26495
      Caption = 'Explorer'#12391'Log'#12501#12457#12523#12480#12434#38283#12367
      Hint = 'Explorer'#12391'Log'#12501#12457#12523#12480#12434#38283#12367
      OnExecute = LogFolderOpenActionExecute
      OnUpdate = LogFolderOpenActionUpdate
    end
    object TabsSaveAction: TAction
      Category = #12501#12449#12452#12523
      Caption = #12479#12502#12398#38918#30058#12434#20445#23384
      Hint = #12479#12502#12398#38918#30058#12434#20445#23384
      OnExecute = TabsSaveActionExecute
    end
    object TabsOpenAction: TAction
      Category = #12501#12449#12452#12523
      Caption = #12479#12502#12398#38918#30058#12434#24489#20803
      Hint = #12479#12502#12398#38918#30058#12434#24489#20803
      OnExecute = TabsOpenActionExecute
    end
    object BrowsBoradHeadAction: TAction
      Tag = -1
      Category = #26495
      Caption = 'Head.txt'#12434#12502#12521#12454#12470#12391#34920#31034#12377#12427
      Hint = 'Head.txt'#12434#12502#12521#12454#12470#12391#34920#31034#12377#12427
      ImageIndex = 42
      Visible = False
      OnExecute = BrowsBoradHeadActionExecute
      OnUpdate = LogFolderOpenActionUpdate
    end
    object JumpToNumOfResAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #25351#23450#12375#12383#30058#21495#12398#12524#12473#12395#39131#12406
      Hint = #25351#23450#12375#12383#30058#21495#12398#12524#12473#12395#39131#12406
      ShortCut = 16455
      OnExecute = JumpToNumOfResActionExecute
      OnUpdate = DependActiveCntentLogActionUpdate
    end
    object FavoriteTreeViewCollapseAction: TAction
      Category = #12362#27671#12395#20837#12426
      Caption = #12362#27671#12395#20837#12426#12484#12522#12540#12434#12377#12409#12390#38281#12376#12427
      Hint = #12362#27671#12395#20837#12426#12484#12522#12540#12434#12377#12409#12390#38281#12376#12427
      OnExecute = FavoriteTreeViewCollapseActionExecute
    end
    object RightTabCloseAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #12450#12463#12486#12451#12502#12394#12479#12502#12424#12426#21491#12434#38281#12376#12427
      Hint = #12450#12463#12486#12451#12502#12394#12479#12502#12424#12426#21491#12434#38281#12376#12427
      OnExecute = RightTabCloseActionExecute
      OnUpdate = RightTabCloseActionUpdate
    end
    object LeftTabCloseAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #12450#12463#12486#12451#12502#12394#12479#12502#12424#12426#24038#12434#38281#12376#12427
      Hint = #12450#12463#12486#12451#12502#12394#12479#12502#12424#12426#24038#12434#38281#12376#12427
      OnExecute = LeftTabCloseActionExecute
      OnUpdate = RightTabCloseActionUpdate
    end
    object SameIDResAnchorAction: TAction
      Tag = -1
      Category = #12502#12521#12454#12470#12509#12483#12503#12450#12483#12503
      Caption = #21516'ID'#12408#12398#12524#12473#12450#12531#12459#12540#34920#31034
      Hint = #21516'ID'#12408#12398#12524#12473#12450#12531#12459#12540#34920#31034
      OnExecute = SameIDResAnchorActionExecute
    end
    object IndividualAbon1Action: TAction
      Tag = -1
      Category = #12502#12521#12454#12470#12509#12483#12503#12450#12483#12503
      Caption = #12354#12412#65374#12435
      Hint = #12354#12412#65374#12435
      OnExecute = IndividualAbon1ActionExecute
    end
    object IndividualAbon0Action: TAction
      Tag = -1
      Category = #12502#12521#12454#12470#12509#12483#12503#12450#12483#12503
      Caption = #36879#26126#12354#12412#65374#12435
      Hint = #36879#26126#12354#12412#65374#12435
      OnExecute = IndividualAbon0ActionExecute
    end
    object AntiIndividualAbonAction: TAction
      Tag = -1
      Category = #12502#12521#12454#12470#12509#12483#12503#12450#12483#12503
      Caption = #12371#12398#12524#12473
      Hint = #12371#12398#12524#12473
      OnExecute = AntiIndividualAbonActionExecute
    end
    object AntiIndividualAbonDlgAction: TAction
      Tag = -1
      Category = #12502#12521#12454#12470#12509#12483#12503#12450#12483#12503
      Caption = #12524#12473#30058#21495#25351#23450
      Hint = #12524#12473#30058#21495#25351#23450
      OnExecute = AntiIndividualAbonDlgActionExecute
      OnUpdate = DependActiveCntentLogActionUpdate
    end
    object IndividualAbonID1Action: TAction
      Tag = -1
      Category = #12502#12521#12454#12470#12509#12483#12503#12450#12483#12503
      Caption = #12354#12412#65374#12435
      Hint = #12354#12412#65374#12435
      OnExecute = IndividualAbonID1ActionExecute
    end
    object IndividualAbonID0Action: TAction
      Tag = -1
      Category = #12502#12521#12454#12470#12509#12483#12503#12450#12483#12503
      Caption = #36879#26126#12354#12412#65374#12435
      Hint = #36879#26126#12354#12412#65374#12435
      OnExecute = IndividualAbonID0ActionExecute
    end
    object MuteAction: TAction
      Category = #12484#12540#12523
      AutoCheck = True
      Caption = #12511#12517#12540#12488
      Hint = #12511#12517#12540#12488
      ImageIndex = 52
      OnExecute = MuteActionExecute
    end
    object SortActiveColumnAction: TAction
      Category = #26495
      Caption = #29694#22312#12398#12459#12521#12512#12434#12477#12540#12488#12377#12427
      Hint = #29694#22312#12398#12459#12521#12512#12434#12477#12540#12488#12377#12427
      OnExecute = SortActiveColumnActionExecute
    end
    object SortNextColumnAction: TAction
      Category = #26495
      Caption = #21491#38563#12398#12459#12521#12512#12434#12477#12540#12488
      Hint = #21491#38563#12398#12459#12521#12512#12434#12477#12540#12488
      OnExecute = SortNextColumnActionExecute
    end
    object SortPrevColumnAction: TAction
      Category = #26495
      Caption = #24038#38563#12398#12459#12521#12512#12434#12477#12540#12488
      Hint = #24038#38563#12398#12459#12521#12512#12434#12477#12540#12488
      OnExecute = SortPrevColumnActionExecute
    end
    object BeLogInOutAction: TAction
      Category = #12501#12449#12452#12523
      AutoCheck = True
      Caption = 'Be2ch'#12395#12525#12464#12452#12531'/'#12525#12464#12450#12454#12488#12377#12427
      Hint = 'Be2ch'#12395#12525#12464#12452#12531'/'#12525#12464#12450#12454#12488#12377#12427
      ImageIndex = 53
      OnExecute = BeLogInOutActionExecute
    end
    object UnSelectedListViewAction: TAction
      Category = #34920#31034
      Caption = #12473#12524#12483#12489#19968#35239#12398#36984#25246#12434#35299#38500#12377#12427
      Hint = #12473#12524#12483#12489#19968#35239#12398#36984#25246#12434#35299#38500#12377#12427
      OnExecute = UnSelectedListViewActionExecute
    end
    object WikiFAQWebPageAction: TAction
      Category = #12504#12523#12503
      Caption = #12462#12467#12490#12499'Wiki FAQ'
      Hint = #12462#12467#12490#12499'Wiki'#12398'FAQ'#12434#34920#31034#12377#12427
      OnExecute = WikiFAQWebPageActionExecute
    end
    object ThreadSizeCalcForFileAction: TAction
      Category = #12484#12540#12523
      Caption = #12473#12524#12483#12489#12398#23481#37327#12434#12501#12449#12452#12523#12363#12425#20877#35336#31639#12377#12427
      Hint = #12473#12524#12483#12489#12398#23481#37327#12434#12501#12449#12452#12523#12363#12425#20877#35336#31639#12377#12427
      OnExecute = ThreadSizeCalcForFileActionExecute
    end
    object SetInputAssistAction: TAction
      Category = #12484#12540#12523
      Caption = #20837#21147#12450#12471#12473#12488#12398#35373#23450
      Hint = #20837#21147#12450#12471#12473#12488#12398#35373#23450#12501#12457#12540#12512#12434#38283#12367
      OnExecute = SetInputAssistActionExecute
    end
    object OpenFindDialogAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #29694#22312#34920#31034#12375#12390#12356#12427#12473#12524#12483#12489#12398#26908#32034#12480#12452#12450#12525#12464#12434#34920#31034#12377#12427
      Hint = #29694#22312#34920#31034#12375#12390#12356#12427#12473#12524#12483#12489#12398#26908#32034#12480#12452#12450#12525#12464#12434#34920#31034#12377#12427
      ShortCut = 16454
      OnExecute = OpenFindDialogActionExecute
    end
    object FavoriteTreeViewItemNameCopyAction: TAction
      Tag = -1
      Category = #12362#27671#12395#20837#12426#12484#12522#12540#12509#12483#12503#12450#12483#12503
      Caption = #34920#31034#21517#12434#12467#12500#12540'(&S)'
      Hint = #34920#31034#12375#12390#12356#12427#21517#21069#12434#12463#12522#12483#12503#12508#12540#12489#12395#12467#12500#12540#12377#12427
      OnExecute = FavoriteTreeViewItemNameCopyActionExecute
    end
    object CloseAllEditorAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #12377#12409#12390#12398#12524#12473#12456#12487#12451#12479#12434#38281#12376#12427
      Hint = #12377#12409#12390#12398#12524#12473#12456#12487#12451#12479#12434#38281#12376#12427
      OnExecute = CloseAllEditorActionExecute
      OnUpdate = CloseAllEditorActionUpdate
    end
    object PrevMoveHistory: TAction
      Category = #25805#20316
      Caption = #12522#12531#12463#23653#27508#12434#25147#12427
      Hint = #12522#12531#12463#23653#27508#12434#25147#12427
      OnExecute = PrevMoveHistoryExecute
      OnUpdate = PrevMoveHistoryUpdate
    end
    object NextMoveHistory: TAction
      Category = #25805#20316
      Caption = #12522#12531#12463#23653#27508#12434#36914#12416
      Hint = #12522#12531#12463#23653#27508#12434#36914#12416
      OnExecute = NextMoveHistoryExecute
      OnUpdate = NextMoveHistoryUpdate
    end
    object ClickActiveElementAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #12450#12463#12486#12451#12502#12394#35201#32032#12434#12463#12522#12483#12463#12377#12427
      Hint = #12450#12463#12486#12451#12502#12394#35201#32032#12434#12463#12522#12483#12463#12377#12427
      OnExecute = ClickActiveElementActionExecute
    end
    object VKDownAction: TAction
      Category = #25805#20316
      Caption = #19979#30690#21360#12461#12540#25276#19979
      Hint = #19979#30690#21360#12461#12540#25276#19979
      OnExecute = VKDownActionExecute
    end
    object VKUpAction: TAction
      Category = #25805#20316
      Caption = #19978#30690#21360#12461#12540#25276#19979
      Hint = #19978#30690#21360#12461#12540#25276#19979
      OnExecute = VKUpActionExecute
    end
    object VKRightAction: TAction
      Category = #25805#20316
      Caption = #21491#30690#21360#12461#12540#25276#19979
      Hint = #21491#30690#21360#12461#12540#25276#19979
      OnExecute = VKRightActionExecute
    end
    object VKLeftAction: TAction
      Category = #25805#20316
      Caption = #24038#30690#21360#12461#12540#25276#19979
      Hint = #24038#30690#21360#12461#12540#25276#19979
      OnExecute = VKLeftActionExecute
    end
    object StoredTaskTrayAction: TAction
      Category = #25805#20316
      Caption = #12479#12473#12463#12488#12524#12452#12395#26684#32013#12377#12427
      Hint = #12479#12473#12463#12488#12524#12452#12395#26684#32013#12377#12427
      OnExecute = StoredTaskTrayActionExecute
    end
    object AllImageLinkToClipbordAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #12452#12513#12540#12472#12522#12531#12463'URL'#21462#24471
      Hint = #34920#31034#12373#12428#12390#12356#12427#12377#12409#12390#12398#12524#12473#12363#12425#12452#12513#12540#12472#12408#12398#12522#12531#12463'URL'#12434#12463#12522#12483#12503#12508#12540#12489#12395#12467#12500#12540#12377#12427
      OnExecute = AllImageLinkToClipbordActionExecute
      OnUpdate = DependActiveCntentLogActionUpdate
    end
    object NewImageLinkToClipBoardAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #26032#30528#12524#12473#12452#12513#12540#12472#12522#12531#12463'URL'#21462#24471
      Hint = #34920#31034#12373#12428#12390#12356#12427#26032#30528#12524#12473#12363#12425#12452#12513#12540#12472#12408#12398#12522#12531#12463'URL'#12434#12463#12522#12483#12503#12508#12540#12489#12395#12467#12500#12540#12377#12427
      OnExecute = NewImageLinkToClipBoardActionExecute
      OnUpdate = DependActiveCntentLogActionUpdate
    end
    object SetForcusForAddresBarAction: TAction
      Category = #12450#12489#12524#12473#12496#12540
      Caption = #12450#12489#12524#12473#12496#12540#12395#12501#12457#12540#12459#12473#12434#24403#12390#12427
      Hint = #12450#12489#12524#12473#12496#12540#12395#12501#12457#12540#12459#12473#12434#24403#12390#12427
      OnExecute = SetForcusForAddresBarActionExecute
    end
    object NewBoardSearchAction: TAction
      Category = #12501#12449#12452#12523
      Caption = #31227#36578#26495#26908#32034
      Hint = #31227#36578#12375#12390#12356#12427#26495#12398'URL'#12434#26908#32034#12377#12427
      OnExecute = NewBoardSearchActionExecute
    end
    object NGWordEditFormAction: TAction
      Category = 'NGword'
      Caption = 'NG'#12527#12540#12489#32232#38598#12501#12457#12540#12512
      Hint = 'NG'#12527#12540#12489#32232#38598#12501#12457#12540#12512#12458#12540#12503#12531
    end
    object AllLinkToClipboardAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #12522#12531#12463'URL'#21462#24471
      Hint = #12522#12531#12463'URL'#21462#24471
      OnExecute = AllLinkToClipboardActionExecute
      OnUpdate = DependActiveCntentActionUpdate
    end
    object NewLinkToClipboardAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #26032#30528#12524#12473#12522#12531#12463'URL'#21462#24471
      Hint = #26032#30528#12524#12473#12522#12531#12463'URL'#21462#24471
      OnExecute = NewLinkToClipboardActionExecute
      OnUpdate = DependActiveCntentActionUpdate
    end
    object AddIDtoNGWord0Action: TAction
      Tag = -1
      Category = #12502#12521#12454#12470#12509#12483#12503#12450#12483#12503
      Caption = 'ID'#12434'NG'#12527#12540#12489#12395#36861#21152'('#36879#26126')'
      Hint = #12524#12473#12398'ID'#12434'NG'#12527#12540#12489#12501#12449#12452#12523#12395#36861#21152#12377#12427#65288#36879#26126#65289
      OnExecute = AddIDtoNGWord0ActionExecute
    end
    object AddIDtoNGWord1Action: TAction
      Tag = -1
      Category = #12502#12521#12454#12470#12509#12483#12503#12450#12483#12503
      Caption = 'ID'#12434'NG'#12527#12540#12489#12395#36861#21152
      Hint = 'ID'#12434'NG'#12527#12540#12489#12501#12449#12452#12523#12395#36861#21152#12377#12427
      OnExecute = AddIDtoNGWord1ActionExecute
    end
    object ExtractSameIDAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #12463#12522#12483#12503#12508#12540#12489#12398#25991#23383#21015#12434#21547#12416'ID'#12398#12524#12473#12450#12531#12459#12540#34920#31034
      Hint = #12463#12522#12483#12503#12508#12540#12489#12398#25991#23383#21015#12434#21547#12416'ID'#12398#12524#12473#12450#12531#12459#12540#34920#31034
      OnExecute = ExtractSameIDActionExecute
      OnUpdate = DependActiveCntentLogActionUpdate
    end
    object ShowTabListAction: TAction
      Category = #34920#31034
      Caption = #12479#12502#19968#35239#34920#31034
      Hint = #12479#12502#19968#35239#34920#31034
      OnExecute = ShowTabListActionExecute
    end
    object DereferenceResAction: TAction
      Tag = 1
      Category = #12473#12524#12483#12489
      Caption = #12371#12398#12524#12473#12434#21442#29031#12375#12390#12356#12427#12524#12473#12450#12531#12459#12540#34920#31034
      Hint = #12371#12398#12524#12473#12434#21442#29031#12375#12390#12356#12427#12524#12473#12450#12531#12459#12540#34920#31034
      OnExecute = DereferenceResActionExecute
      OnUpdate = DependActiveCntentLogActionUpdate
    end
    object UpdateGikonaviAction: TAction
      Category = #12501#12449#12452#12523
      Caption = #12462#12467#12490#12499#26356#26032
      Hint = #12462#12467#12490#12499#12398#26356#26032
      OnExecute = UpdateGikonaviActionExecute
    end
    object konoURLPATHAction: TAction
      Tag = -1
      Category = #12502#12521#12454#12470#12509#12483#12503#12450#12483#12503
      Caption = 'PATH_INFO'#24418#24335
      Hint = #12371#12398#12524#12473#12398'URL'#12467#12500#12540#65288'PATH_INFO'#65289
      OnExecute = konoURLPATHActionExecute
    end
    object konoURLQueryAction: TAction
      Tag = -1
      Category = #12502#12521#12454#12470#12509#12483#12503#12450#12483#12503
      Caption = 'QUERY_STRING'#24418#24335
      Hint = #12371#12398#12524#12473#12398'URL'#12467#12500#12540#65288'QUERY_STRING'#65289
      OnExecute = konoURLQueryActionExecute
      OnUpdate = konoURLQueryActionUpdate
    end
    object PopupMenuSettingAction: TAction
      Tag = -1
      Category = #12484#12540#12523
      Caption = #12509#12483#12503#12450#12483#12503#12513#12491#12517#12540#35373#23450
      Hint = #12509#12483#12503#12450#12483#12503#12513#12491#12517#12540#35373#23450
      OnExecute = PopupMenuSettingActionExecute
    end
    object GikoNaviGoesonWebPageAction: TAction
      Category = #12504#12523#12503
      Caption = #12462#12467#12490#12499'('#36991#38627#25152#29256')'#12398#12454#12455#12502#12469#12452#12488'(&K)'
      Hint = #12462#12467#12490#12499'('#36991#38627#25152#29256')'#12398#12454#12455#12502#12469#12452#12488#12434#34920#31034#12377#12427
      OnExecute = GikoNaviGoesonWebPageActionExecute
    end
    object GoWikiFAQWebPageAction: TAction
      Category = #12504#12523#12503
      Caption = #12462#12467#12490#12499'('#36991#38627#25152#29256')Wiki FAQ'
      Hint = #12462#12467#12490#12499'('#36991#38627#25152#29256')Wiki'#12398'FAQ'#12434#34920#31034#12377#12427
      OnExecute = GoWikiFAQWebPageActionExecute
    end
    object ThreadSearchAction: TAction
      Category = #12484#12540#12523
      Caption = #65298#12385#12419#12435#12397#12427#12473#12524#12479#12452#26908#32034'(&L)'
      Enabled = False
      Hint = #65298#12385#12419#12435#12397#12427#12473#12524#12479#12452#26908#32034#12480#12452#12450#12525#12464#12434#34920#31034#12377#12427
      OnExecute = ThreadSearchActionExecute
    end
    object ThreadNgEditAction: TAction
      Category = #12484#12540#12523
      Caption = #12473#12524#12479#12452'NG'#12527#12540#12489#32232#38598'(&W)'
      Hint = #12473#12524#12479#12452'NG'#32232#38598#12480#12452#12450#12525#12464#12434#34920#31034#12377#12427
      OnExecute = ThreadNgEditActionExecute
    end
    object RangeAbonAction: TAction
      Tag = -1
      Category = #12502#12521#12454#12470#12509#12483#12503#12450#12483#12503
      Caption = #31684#22258#12354#12412#65374#12435
      Hint = #31684#22258#12354#12412#65374#12435
      OnExecute = RangeAbonActionExecute
    end
    object ThreadRangeAbonAction: TAction
      Category = #12473#12524#12483#12489
      Caption = #31684#22258#12354#12412#65374#12435
      Hint = #31684#22258#12354#12412#65374#12435
      OnExecute = ThreadRangeAbonActionExecute
      OnUpdate = BrowserTabCloseActionUpdate
    end
  end
  object ToobarImageList: TImageList
    Left = 44
    Top = 60
    Bitmap = {
      494C010138003B00300010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000040000000F0000000010020000000000000F0
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004A4A4A000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000008484000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400848484000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600000000000000
      00004A4A4A004A4A4A004A4A4A0000000000000000000000000084848400FFFF
      FF001818180018181800181818001818180018181800FFFFFF00C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000084840000000000C6C6C600C6C6C600848484000000
      0000000000000000000084848400000000000000000000000000000000000000
      000084848400C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6008484
      8400000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600000000000000
      0000000000004A4A4A000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000008484008484840084848400FFFFFF00FFFFFF00848484000000
      0000000000008484840000000000000000000000000000000000000000008484
      8400C6C6C6000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000000000000000000000000000C6C6C600FFFF
      FF00C6C6C600C6C6C600C6C6C600C6C6C600FFFFFF00C6C6C600000000000000
      0000000000004A4A4A000000000000000000000000000000000084848400FFFF
      FF001818180018181800181818001818180018181800FFFFFF00C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000084840000FFFF0000000000C6C6C600FFFFFF00FFFFFF00848484000000
      000084848400000000000000000000000000000000000000000084848400C6C6
      C600C6C6C6000000000000000000FFFFFF00FFFFFF00FFFFFF00C6C6C6000000
      0000000000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000084
      840000FFFF00FFFFFF0000000000C6C6C600FFFFFF00FFFFFF00848484000000
      0000000000000000000000000000000000000000000084848400C6C6C600C6C6
      C600C6C6C6000000000000000000FFFFFF00C6C6C600C6C6C600C6C6C6000000
      000000000000C6C6C6008484840000000000000000000000000084848400C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600FFFFFF00848484000000
      00000000000000000000000000000000000000000000008484008484840000FF
      FF00FFFFFF0000FFFF000000000000000000FFFFFF00FFFFFF00848484000000
      0000000000000000000000000000000000000000000084848400C6C6C600C6C6
      C600C6C6C6000000000000000000FFFFFF00C6C6C600C6C6C600C6C6C6000000
      000000000000C6C6C6008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600000000000000
      000000000000848484000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C60084848400000000000000
      0000000000000000000000000000000000000084840000FFFF00C6C6C600FFFF
      FF0000FFFF00FFFFFF00000000008484840000000000FFFFFF00848484000000
      0000848484008484840084848400848484000000000084848400C6C6C600C6C6
      C600C6C6C6000000000000000000000000000000000000000000000000000000
      0000C6C6C600C6C6C6008484840000000000000000000000000084848400FFFF
      FF0018181800181818001818180018181800FFFFFF00C6C6C600000000000000
      0000848484008484840084848400000000000000000000000000848484008484
      8400848484008484840084848400848484008484840000000000000000000000
      0000000000000000000000000000000000000084840000FFFF00C6C6C60000FF
      FF00FFFFFF0000FFFF0000000000C6C6C60000000000FFFFFF00848484000000
      0000000000000000000000000000000000000000000084848400C6C6C600C6C6
      C600C6C6C6000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000C6C6
      C600C6C6C600C6C6C6008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600000000000000
      0000000000008484840000000000000000000000000000000000000000000000
      000000000000E7E7E70000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000848400FFFFFF00C6C6C600FFFF
      FF0000FFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00848484000000
      0000000000000000000000000000000000000000000084848400C6C6C600C6C6
      C600C6C6C6000000000000000000FFFFFF00C6C6C600C6C6C600000000000000
      0000C6C6C600C6C6C6008484840000000000000000000000000084848400FFFF
      FF0018181800181818001818180018181800FFFFFF00C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E7E7E70000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000008484000084840000FF
      FF00FFFFFF0000FFFF0000000000C6C6C600FFFFFF00FFFFFF00848484000000
      0000848484000000000000000000000000000000000084848400C6C6C600C6C6
      C600C6C6C6000000000000000000FFFFFF00C6C6C600C6C6C600000000000000
      0000C6C6C600C6C6C6008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E7E7E70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000084
      840000FFFF00FFFFFF0000000000C6C6C600FFFFFF00FFFFFF00848484000000
      000000000000848484000000000000000000000000000000000084848400C6C6
      C600C6C6C6000000000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
      0000C6C6C600848484000000000000000000000000000000000084848400FFFF
      FF0018181800181818001818180018181800FFFFFF00C6C6C600000000000000
      0000000000004A4A4A0000000000000000000000000000000000000000000000
      000000000000E7E7E70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000084840000FFFF008484840084848400C6C6C600FFFFFF00848484000000
      0000000000000000000084848400000000000000000000000000000000008484
      8400C6C6C600000000000000000000000000000000000000000000000000C6C6
      C60084848400000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000004A4A4A000000000000000000000000000000000000000000E7E7
      E700E7E7E700E7E7E700E7E7E700E7E7E7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084840000FFFF0000000000C6C6C600C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6008484
      840000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00C6C6C600FFFFFF0084848400000000000000
      00004A4A4A004A4A4A004A4A4A00000000000000000000000000000000000000
      000000000000E7E7E70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000848400848484000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400848484000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00C6C6C6008484840000000000000000000000
      0000000000004A4A4A0000000000000000000000000000000000000000000000
      000000000000E7E7E70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C6000000000000000000000000000000000000000000FFFF
      FF00000000008484840084848400848484008484840084848400848484000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C6000000000000000000000000000000000000000000FFFF
      FF00000000008484840084848400848484008484840084848400848484000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C6000000000000000000000000000000000000000000FFFF
      FF00000000008484840084848400848484008484840084848400848484000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C6000000000000000000000000000000000000000000FFFF
      FF00000000008484840084848400848484008484840084848400848484000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C6000000000000000000000000000000000000000000FFFF
      FF00000000008484840084848400848484008484840084848400848484000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600C6C6C600C6C6C6000000000000000000000000000000000000000000FFFF
      FF00000000008484840084848400848484008484840084848400848484000000
      0000FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C6000000000000000000000000000000000000000000FFFF
      FF00000000008484840084848400848484008484840084848400848484000000
      0000FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C6000000000000000000000000000000000000000000FFFF
      FF00000000008484840084848400848484008484840084848400848484000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484008484840000000000000000000000000000000000C6C6C6000000
      00008484840000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF0000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484008484840000000000000000000000000000000000C6C6C6000000
      00008484840000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF008484
      84008484840084848400FFFFFF008484840084848400FFFFFF00848484008484
      840084848400FFFFFF00FFFFFF00000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484008484840000000000000000000000000000000000000000000000
      00008484840000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000FFFFFF0000000000FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00848484008484840084848400848484008484840084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484008484840084848400848484008484840084848400848484008484
      84008484840000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400848484008484840084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484008484840000000000000000000000000000000000000000008484
      84008484840000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400FFFFFF00FFFFFF00000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484840000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      00008484840000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484840000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      00008484840000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000C6C6C600C6C6
      C600C6C6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484840000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00FFFFFF00FFFFFF00000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00008484840000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000C6C6C60000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600000000000000000084848400C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600000000000000000000000000FFFFFF00FFFFFF00C6C6
      C600C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00C6C6C600C6C6C600FFFFFF00FFFFFF00C6C6C600C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C6000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600000000000000000084848400FFFF
      FF00848484008484840084848400848484000000000084848400848484000000
      0000FFFFFF00C6C6C600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6C600C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000C6C6C600C6C6C600000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00000000000000
      0000FFFFFF00C6C6C600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6C600C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600000000000000000084848400FFFF
      FF00848484008484840084848400848484000000000000000000848484000000
      0000FFFFFF00C6C6C600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00C6C6C600C6C6C600FFFFFF00FFFFFF00C6C6C600C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000C6C6C600C6C6C600000000000000
      0000000000000000000000000000C6C6C60000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400FFFFFF000000
      0000FFFFFF00C6C6C600000000000000000000000000FFFFFF00FFFFFF00C6C6
      C600C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600000000000000000084848400FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00C6C6C600C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000C6C6C600C6C6C600000000000000
      000000000000C6C6C6000000000000000000000000000000000000000000C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600000000000000000000000000FFFFFF00C6C6C600C6C6
      C600FFFFFF00C6C6C600C6C6C600FFFFFF00C6C6C600C6C6C600FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF00FFFFFF00C6C6
      C600C6C6C600C6C6C600C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600000000000000000084848400FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C600000000000000000000000000FFFFFF00C6C6C600C6C6
      C600FFFFFF00C6C6C600C6C6C600FFFFFF00C6C6C600C6C6C600FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF00FFFFFF00C6C6
      C600C6C6C600FFFFFF00C6C6C600C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000C6C6C600C6C6C60000000000C6C6
      C60000000000C6C6C60000000000C6C6C60000000000C6C6C60000000000C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF00C6C6C600C6C6
      C600FFFFFF00FFFFFF00FFFFFF00C6C6C600C6C6C600FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600000000000000000084848400FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C60000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600C6C6C600C6C6C6000000
      000000000000000000000000000000000000C6C6C600C6C6C600000000000000
      000000000000000000000000000000000000C6C6C60000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C60000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600FFFFFF008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600C6C6C600000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484008484840084848400000000000000
      0000000000000000000000000000000000008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484008484840084848400C6C6C600C6C6C600C6C6C600848484008484
      84000000000000000000000000000000000084848400C6C6C600C6C6C6008484
      8400848484000000000000000000000000000000000000000000848484008484
      8400C6C6C600C6C6C60084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400C6C6C600FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00C6C6C6008484
      8400000000000000000000000000000000008484840084848400C6C6C600C6C6
      C60084848400848484008484840000000000848484008484840084848400C6C6
      C600C6C6C60084848400848484000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000000000C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600848484008484840000000000000000000000000084848400C6C6C600C6C6
      C600C6C6C600C6C6C600848484008484840084848400C6C6C600C6C6C600C6C6
      C600C6C6C60084848400000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000C6C6C6008484
      840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00C6C6C600848484000000000000000000000000008484840084848400C6C6
      C600C6C6C600C6C6C600C6C6C60084848400C6C6C600C6C6C600C6C6C600C6C6
      C6008484840084848400000000000000000000000000FFFFFF00000000000000
      000000000000FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF000000
      000000000000FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000C6C6C6008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C6C600848484008484840000000000000000000000000084848400C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C6008484840000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000000000000000FFFF
      FF00FFFFFF0000000000FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000C6C6C60084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00C6C6C600C6C6C600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C6008484840000000000000000000000000084848400C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C6008484840000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000000000000000FFFF
      FF00FFFFFF0000000000FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000C6C6C60000000000FFFF
      FF00FFFFFF00FFFFFF00C6C6C6008484840084848400C6C6C600C6C6C600FFFF
      FF0000000000C6C6C60084848400000000000000000000000000848484008484
      8400C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6008484
      84008484840000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000000000000000FFFF
      FF00FFFFFF0000000000FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000C6C6C60084848400FFFF
      FF00FFFFFF00C6C6C60084848400FFFFFF00FFFFFF008484840084848400C6C6
      C600FFFFFF00C6C6C6008484840000000000000000008484840084848400C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C6008484840084848400000000000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000000000000000FFFF
      FF00FFFFFF0000000000FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000C6C6C6008484
      8400FFFFFF0084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484
      8400C6C6C6008484840000000000000000008484840084848400C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C60084848400848484000000000000000000FFFFFF00000000000000
      0000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000000000000000FFFF
      FF00FFFFFF0000000000FFFFFF000000000000000000FFFFFF00C6C6C600C6C6
      C600FFFFFF00C6C6C600C6C6C600FFFFFF00C6C6C600C6C6C600FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000C6C6C6008484
      840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00C6C6C60084848400000000000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600848484000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF000000
      000000000000FFFFFF00FFFFFF000000000000000000FFFFFF00C6C6C600C6C6
      C600FFFFFF00C6C6C600C6C6C600FFFFFF00C6C6C600C6C6C600FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000000000000000C6C6
      C60084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600848484000000000000000000000000008484840084848400848484008484
      840084848400C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600848484008484
      84008484840084848400848484000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600848484008484840000000000FFFFFF00FFFFFF00C6C6C6008484
      8400000000000000000000000000000000000000000000000000000000000000
      00008484840084848400C6C6C600C6C6C600C6C6C60084848400848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084848400C6C6C600C6C6C600C6C6C60084848400000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C600C6C6C600C6C6C60084848400848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400C6C6C6008484840084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400848484008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      0000000000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00000000000000
      0000000000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF0000000000848484008484
      8400848484008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000008484
      8400C6C6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00C6C6C600FFFFFF000000000084848400848484008484
      8400C6C6C6008484840000000000000000000000000000000000000000008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000008484
      8400C6C6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C6000000
      000000000000000000000000000000000000848484008484840084848400C6C6
      C600FFFFFF008484840000000000000000000000000000000000000000000000
      0000000000000000000084848400848484008484840084848400848484000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000008484
      8400C6C6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400000000008484840084848400C6C6C600FFFF
      FF00C6C6C6008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000008484
      8400FFFFFF00C6C6C60000000000000000000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000848484008484
      8400C6C6C600C6C6C600C6C6C600FFFFFF0000000000C6C6C600FFFFFF00C6C6
      C600FFFFFF008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      000084848400C6C6C600C6C6C60000000000000000000000000000000000C6C6
      C60084848400000000000000000000000000000000000000000084848400C6C6
      C600C6C6C600C6C6C600C6C6C600FFFFFF0000000000FFFFFF00C6C6C600FFFF
      FF00C6C6C6008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      000084848400FFFFFF00C6C6C600C6C6C6008484840084848400C6C6C600C6C6
      C600C6C6C600848484000000000000000000000000000000000084848400C6C6
      C600C6C6C600C6C6C600C6C6C600FFFFFF0000000000FFFFFF00FFFFFF00C6C6
      C600FFFFFF008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      00000000000084848400FFFFFF00FFFFFF00C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C6008484840000000000000000000000000084848400C6C6
      C600C6C6C600C6C6C600FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00C6C6C6008484840000000000000000000000000000000000000000000000
      0000848484000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      000000000000000000008484840084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C600C6C6C600C6C6C6000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008484840000000000000000000000000000000000000000000000
      0000848484000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      000000000000000000000000000000000000848484008484840084848400FFFF
      FF00C6C6C6000000000000000000000000000000000000000000C6C6C6000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF008484
      8400848484008484840000000000000000000000000000000000000000000000
      0000848484008484840000000000000000000000000000000000000000008484
      8400848484000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484
      8400848484008484840084848400000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000008484840000000000000000000000000084848400848484000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400848484008484840084848400000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      840084848400848484008484840000000000000000000000000084848400C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840084848400848484008484
      840084848400848484008484840084848400848484008484840000000000FFFF
      FF00FFFFFF00FFFFFF008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600000000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      84008484840084848400848484000000000084848400FFFFFF00FFFFFF00C6C6
      C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF008484840000000000FFFF
      FF00FFFFFF00FFFFFF008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000084848400848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFF
      FF00C6C6C600FFFFFF00848484000000000084848400FFFFFF00C6C6C600FFFF
      FF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C6008484840000000000FFFF
      FF00FFFFFF00FFFFFF008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000084848400C6C6C6008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000000000000000000084848400FFFFFF00C6C6
      C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6
      C600FFFFFF00C6C6C600848484000000000084848400FFFFFF00FFFFFF00C6C6
      C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF008484840000000000FFFF
      FF00FFFFFF00FFFFFF008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF008484840084848400848484008484840084848400FFFF
      FF00FFFFFF00C6C6C6000000000000000000000000000000000084848400C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFF
      FF00C6C6C600FFFFFF00848484000000000084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484840000000000FFFF
      FF00FFFFFF00FFFFFF008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840084848400FFFFFF00848484008484
      8400FFFFFF00C6C6C60000000000000000000000000000000000000000008484
      8400C6C6C6000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000084848400FFFFFF00C6C6
      C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6
      C600FFFFFF00C6C6C600848484000000000084848400FFFFFF00C6C6C600FFFF
      FF00C6C6C600FFFFFF00C6C6C600848484008484840084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0084848400FFFFFF00FFFFFF008484
      8400FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000848484008484840000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFF
      FF00C6C6C600FFFFFF0084848400000000000000000084848400FFFFFF00C6C6
      C600FFFFFF00C6C6C60084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008484840000000000000000000000000084848400FFFF
      FF0084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484
      8400FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000008484840084848400000000008484840000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00C6C6
      C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6
      C600FFFFFF00C6C6C60084848400000000000000000000000000848484008484
      84008484840084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008484840000000000000000000000000084848400FFFF
      FF0084848400FFFFFF00FFFFFF0084848400FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFF
      FF00C6C6C600FFFFFF0084848400000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008484840000000000000000000000000084848400FFFF
      FF008484840084848400FFFFFF008484840084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000008484840084848400000000008484840000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008484840000000000000000000000000084848400FFFF
      FF00FFFFFF008484840084848400848484008484840084848400FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      000084848400C6C6C60000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00C6C6
      C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF0084848400848484008484
      8400848484008484840084848400000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840084848400FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400C6C6C6000000000000000000000000000000000000000000848484000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00C6C6C600FFFFFF00C6C6C600FFFFFF008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484
      840084848400848484008484840000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C600FFFFFF008484840000000000000000000000000084848400C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C6000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600848484000000000000000000000000000000000084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C6C6000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000008484840084848400848484000000000000000000848484000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000848484008484
      840084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      000084848400C6C6C600C6C6C600000000000000000084848400000000008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      000000000000FFFFFF00C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600FFFFFF00000000000000000000000000000000008484
      84008484840084848400C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600FFFFFF0000000000000000000000000000000000FFFF
      FF0084848400848484008484840084848400FFFFFF00FFFFFF00000000008484
      8400C6C6C600C6C6C60000000000000000008484840084848400848484008484
      84008484840084848400848484008484840084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      000084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000084848400C6C6
      C600C6C6C6000000000000000000000000008484840084848400848484008484
      840084848400FFFFFF00FFFFFF00848484008484840084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      000000000000FFFFFF00C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600FFFFFF00000000000000000000000000000000000000
      00000000000084848400848484008484840084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600FFFFFF0000000000000000000000000000000000FFFF
      FF00848484008484840084848400FFFFFF000000000084848400C6C6C600C6C6
      C600000000000000000000000000000000008484840084848400848484008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000848484000000
      00000000000084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000C6C6C6000000
      0000FFFFFF000000000000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000848484008484
      84000000000084848400C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600FFFFFF00000000008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400C6C6C600C6C6C600FFFFFF0000000000000000000000000000000000FFFF
      FF00848484008484840084848400FFFFFF00000000000000000000000000FFFF
      FF00FFFFFF000000000000000000000000000000000084848400848484008484
      840084848400FFFFFF00FFFFFF00848484008484840084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000008484
      84008484840084848400FFFFFF008484840084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000848484008484
      84008484840084848400848484008484840084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000008484840084848400848484008484
      840084848400848484008484840084848400C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600FFFFFF00000000000000000000000000000000000000
      00000000000084848400848484008484840084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600FFFFFF0000000000000000000000000000000000FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF000000000000000000000000000000000000000000000000008484
      840084848400848484008484840084848400FFFFFF0084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000848484008484
      8400000000008484840084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      000084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF008484840084848400FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000084848400848484008484
      84008484840084848400848484008484840084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600FFFFFF00000000000000000000000000000000008484
      84008484840084848400C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600FFFFFF0000000000000000000000000000000000FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF000000000000000000000000008484840084848400000000008484
      84008484840084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000848484008484
      840084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400000000008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400000000000000000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484008484840084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400FFFFFF0084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400000000000000000000000000000000008484840000000000000000000000
      0000848484000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400FFFFFF0084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400FFFFFF0084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0084848400000000000000000000000000FFFFFF00848484000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00848484000000000000000000000000008484840000000000000000008484
      8400FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400FFFFFF0084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400FFFFFF00FFFFFF00FFFFFF00848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00848484000000000000000000FFFFFF00FFFFFF008484
      840000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00848484000000000000000000848484000000000084848400FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400FFFFFF0084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000848484008484840084848400FFFFFF00FFFFFF00FFFFFF008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF008484840000000000FFFFFF00FFFFFF00FFFF
      FF0084848400000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF0084848400000000008484840084848400FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400FFFFFF0084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF0084848400000000000000000084848400FFFFFF008484
      8400000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00848484000000000000000000848484000000000084848400FFFF
      FF00848484000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400FFFFFF0084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484008484840000000000000000000000000084848400848484000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484000000000000000000000000008484840000000000000000008484
      8400848484000000000000000000000000000000000000000000000000000000
      000000000000848484008484840084848400FFFFFF00FFFFFF00FFFFFF008484
      8400000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400FFFFFF0084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400000000000000000000000000000000008484840000000000000000000000
      0000848484000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400FFFFFF00FFFFFF00FFFFFF00848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400FFFFFF0084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400FFFFFF0084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400FFFFFF0084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400FFFFFF0084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484008484840084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000848484008484840084848400FFFFFF00FFFFFF00FFFFFF008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000848484008484840084848400FFFFFF00FFFFFF00FFFFFF008484
      8400000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400FFFFFF0084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400FFFFFF00FFFFFF00FFFFFF00848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400FFFFFF00FFFFFF00FFFFFF00848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400FFFFFF00FFFFFF00FFFFFF00848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400FFFFFF0084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084848400FFFFFF0000000000000000000000000084848400FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400FFFFFF0084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000848484008484840084848400FFFFFF00FFFFFF00FFFFFF008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF00FFFFFF00000000000000000084848400FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF000000000084848400FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF0084848400000000000000000084848400FFFFFF008484
      8400000000000000000000000000000000000000000000000000000000000000
      000000000000848484008484840084848400FFFFFF00FFFFFF00FFFFFF008484
      8400000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400FFFFFF0084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400000000000000000000000000848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400FFFFFF00FFFFFF00FFFFFF00848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400FFFFFF00FFFFFF00FFFFFF00848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400FFFFFF0084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400FFFFFF0084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000848484008484840084848400FFFFFF00FFFFFF00FFFFFF008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400FFFFFF00FFFFFF00FFFFFF00848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000848484008484840084848400FFFFFF00FFFFFF00FFFFFF008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00848484008484840084848400FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600000000000000000084848400C6C6C600000000000000
      0000848484008484840000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00848484008484840084848400FFFFFF00FFFFFF0084848400848484008484
      840084848400C6C6C600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF008484840084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484
      8400FFFFFF00FFFFFF00FFFFFF0000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600000000000000000084848400C6C6C600000000008484
      8400848484008484840000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF0084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00848484008484
      8400FFFFFF00C6C6C600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF0084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00848484008484
      840084848400FFFFFF00FFFFFF0000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF008484840084848400848484008484840084848400FFFF
      FF00FFFFFF00C6C6C600000000000000000084848400C6C6C600C6C6C6000000
      0000C6C6C6000000000000000000000000000000000084848400C6C6C600C6C6
      C600C6C6C600C6C6C6000000000000000000000000000000000084848400FFFF
      FF00FFFFFF0084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00848484008484
      8400FFFFFF00C6C6C600000000000000000000000000FFFFFF00848484008484
      8400848484008484840084848400FFFFFF00FFFFFF0084848400848484008484
      84008484840084848400FFFFFF0000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840084848400FFFFFF00848484008484
      8400FFFFFF00C6C6C600000000000000000084848400FFFFFF00C6C6C600C6C6
      C60000000000C6C6C60000000000000000000000000084848400FFFFFF00C6C6
      C600C6C6C600000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF0084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C600000000000000000000000000FFFFFF00FFFFFF008484
      84008484840084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484
      8400FFFFFF00FFFFFF00FFFFFF0000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0084848400FFFFFF00FFFFFF008484
      8400FFFFFF00C6C6C60000000000000000000000000084848400FFFFFF00C6C6
      C600C6C6C600C6C6C60000000000848484000000000084848400C6C6C600FFFF
      FF00C6C6C600C6C6C6000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF0084848400FFFFFF00FFFFFF008484840084848400FFFF
      FF00FFFFFF00C6C6C600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF0084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00848484008484
      8400FFFFFF00FFFFFF00FFFFFF0000000000000000000000000084848400FFFF
      FF0084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484
      8400FFFFFF00C6C6C6000000000000000000000000000000000000000000FFFF
      FF00C6C6C600C6C6C60000000000000000008484840084848400FFFFFF008484
      8400FFFFFF00C6C6C600C6C6C60000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF0084848400FFFFFF00FFFFFF008484840084848400FFFF
      FF00FFFFFF00C6C6C600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00848484008484840084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000084848400FFFF
      FF0084848400FFFFFF00FFFFFF0084848400FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000FFFFFF00C6C6
      C600FFFFFF00C6C6C60000000000848484000000000084848400848484000000
      000084848400FFFFFF00C6C6C60000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00848484008484840084848400FFFFFF00FFFF
      FF00FFFFFF00C6C6C600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000084848400FFFF
      FF008484840084848400FFFFFF008484840084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000008484840084848400848484008484
      8400848484008484840000000000000000000000000084848400000000000000
      00008484840084848400FFFFFF0000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00848484008484840084848400FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF008484840084848400848484008484840084848400FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      000084848400C6C6C60084848400848484008484840084848400848484008484
      84000000000084848400C6C6C60000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00848484008484840084848400FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF008484840084848400FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084848400FFFFFF00FFFFFF00C6C6C60084848400848484000000
      0000C6C6C600C6C6C6000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600FFFFFF00848484000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084848400FFFFFF00FFFFFF00FFFFFF00C6C6
      C600FFFFFF008484840000000000000000000000000000000000000000000000
      0000000000000000000084848400848484008484840084848400848484000000
      000084848400848484000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      8400848484008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00848484000000000084848400C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      0000000000000000000084848400C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C6000000000000000000000000000000000084848400C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00848484000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C6000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00848484000000000084848400FFFFFF008484
      840084848400FFFFFF00C6C6C600000000000000000000000000000000000000
      000084848400C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C60000000000C6C6C6000000000000000000000000000000000084848400FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008484840084848400848484008484840084848400848484008484
      8400FFFFFF00FFFFFF00FFFFFF000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00848484000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6C600000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C60000000000C6C6C6000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00848484000000000084848400FFFFFF008484
      840084848400FFFFFF00C6C6C60000000000000000000000000084848400C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C60000000000C6C6
      C60000000000C6C6C6000000000000000000000000000000000084848400FFFF
      FF00848484008484840084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00848484000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6C60000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C60000000000C6C6
      C60000000000C6C6C6000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600000000000000000000000000FFFFFF00FFFFFF008484
      840084848400848484008484840084848400FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600848484000000000084848400848484008484
      840084848400848484008484840000000000000000000000000084848400FFFF
      FF0084848400848484008484840084848400FFFFFF00C6C6C60000000000C6C6
      C60000000000C6C6C60000000000000000000000000000000000C6C6C600FFFF
      FF0084848400C6C6C60084848400848484008484840084848400848484008484
      8400FFFFFF00C6C6C600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00848484008484840084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      840084848400848484008484840084848400000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C60000000000C6C6
      C600000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600FFFFFF00C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000084848400C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084848400000000000000000084848400FFFF
      FF0084848400848484008484840084848400FFFFFF00C6C6C60000000000C6C6
      C60000000000848484000000000000000000000000000000000084848400C6C6
      C600C6C6C600C6C6C60084848400C6C6C600C6C6C60084848400848484008484
      8400FFFFFF00C6C6C600000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6C6000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084848400000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600000000000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF008484
      840084848400FFFFFF00C6C6C6000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084848400000000000000000084848400FFFF
      FF0084848400848484008484840084848400FFFFFF00C6C6C600000000008484
      8400000000000000000000000000000000000000000000000000C6C6C600C6C6
      C60084848400C6C6C600C6C6C600848484008484840084848400848484008484
      8400FFFFFF00C6C6C60000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6C6000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084848400000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600FFFFFF00FFFFFF000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF008484
      840084848400FFFFFF00C6C6C6000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084848400000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00C6C6C600FFFFFF0084848400000000000000
      000000000000000000000000000000000000C6C6C600C6C6C60084848400C6C6
      C600C6C6C600C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600FFFFFF008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6C6000000000000000000C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0084848400000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00C6C6C6008484840000000000000000000000
      000000000000000000000000000000000000000000000000000084848400C6C6
      C600FFFFFF00C6C6C600C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C600848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      84008484840084848400848484000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600848484000000000000000000848484008484
      8400848484008484840084848400848484000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400C6C6
      C6008484840084848400C6C6C600848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00848484008484
      840084848400848484008484840084848400FFFFFF0084848400848484008484
      840084848400FFFFFF00FFFFFF000000000000000000FFFFFF00848484008484
      840084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF0084848400848484008484
      8400FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF008484840084848400FFFFFF00FFFFFF008484840084848400FFFFFF00FFFF
      FF008484840084848400FFFFFF000000000000000000FFFFFF0084848400FFFF
      FF0084848400FFFFFF008484840084848400FFFFFF0084848400FFFFFF008484
      8400FFFFFF0084848400FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF008484840084848400FFFFFF00FFFFFF008484840084848400FFFFFF00FFFF
      FF008484840084848400FFFFFF000000000000000000FFFFFF00848484008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484840084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000000000000FFFFFF00FFFFFF00FFFF
      FF00C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF008484840084848400FFFFFF00FFFFFF008484840084848400FFFFFF00FFFF
      FF008484840084848400FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00848484008484
      84008484840084848400FFFFFF00FFFFFF008484840084848400FFFFFF00FFFF
      FF008484840084848400FFFFFF000000000000000000FFFFFF00848484008484
      840084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF0084848400848484008484
      8400FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF008484840084848400FFFFFF00FFFFFF00FFFFFF0084848400848484008484
      840084848400FFFFFF00FFFFFF000000000000000000FFFFFF0084848400FFFF
      FF0084848400FFFFFF008484840084848400FFFFFF0084848400FFFFFF008484
      8400FFFFFF0084848400FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00848484008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008484840084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400C6C6C600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6C6C60084848400848484000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400C6C6C600848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400C6C6C60084848400848484000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600848484008484
      8400C6C6C60084848400848484000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000FFFFFF00FFFFFF000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484000000000000000000C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600848484008484
      8400C6C6C60084848400848484000000000000000000FFFFFF00FFFFFF00FFFF
      FF0000000000C6C6C60000000000FFFFFF00FFFFFF0000000000C6C6C6000000
      0000FFFFFF00FFFFFF00FFFFFF00000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      84008484840084848400848484000000000000000000C6C6C600000000000000
      000000000000000000000000000000000000C6C6C60000000000000000000000
      00000000000000000000000000000000000084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0084848400848484000000000000000000FFFFFF00FFFFFF000000
      0000C6C6C600C6C6C60000000000FFFFFF00FFFFFF0000000000C6C6C600C6C6
      C60000000000FFFFFF00FFFFFF00000000000000000084848400848484008484
      840084848400FFFFFF00FFFFFF008484840084848400FFFFFF00FFFFFF008484
      8400848484008484840084848400000000000000000000000000C6C6C600C6C6
      C60000000000000000000000000000000000C6C6C600C6C6C600000000000000
      0000000000000000000000000000000000000000000084848400C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C60000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600848484000000000000000000FFFFFF00FFFFFF00FFFF
      FF0000000000C6C6C60000000000FFFFFF00FFFFFF0000000000C6C6C6000000
      0000FFFFFF00FFFFFF00FFFFFF00000000000000000084848400848484008484
      84008484840084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00848484008484
      840084848400848484008484840000000000000000000000000000000000C6C6
      C600C6C6C600000000000000000000000000C6C6C600C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840000000000FFFFFF000000000084848400848484008484
      84008484840084848400848484000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000FFFFFF00FFFFFF000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000084848400848484008484
      8400848484008484840084848400FFFFFF00FFFFFF0084848400848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000C6C6C600C6C6C60000000000C6C6C600C6C6C60000000000C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000848484000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000084848400848484008484
      84008484840084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600C6C6C600000000000000000000000000C6C6
      C600C6C6C6000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008484
      84000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000084848400848484008484
      840084848400FFFFFF00FFFFFF008484840084848400FFFFFF00FFFFFF008484
      8400848484008484840084848400000000000000000000000000000000000000
      00000000000000000000C6C6C600C6C6C6000000000000000000000000000000
      0000C6C6C600C6C6C60000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000C6C6C6000000000000000000000000000000
      00000000000000000000C6C6C600000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000008484840000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C6C6C6000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000848484000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000F00000000100010000000000800700000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FE7FFFFFC01BC00FFC3FF81FC011C00F
      F81DF00FC01BC00FF01BE007C01BC00FE017C003C01FC00F801F8001C01FC01F
      001F8001C01BC03F00108001C011C07F001F8001C01BFBFF001F8001C01FFBFF
      80178001C01FFBFFE01BC003C01BFBFFF01DE007C01BE0FFF83FF00FC031FBFF
      FC3FF81FC07BFBFFFE7FFFFFC0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC003
      FFFFFFFFFFFFC003FC01803FFC01C003FC01803C3C01C003FC01803C3C01C003
      FC01803C3C01C003FC01803C3C01C003FC01803C3C01C003C00180000001C003
      C00180000001C003C00180000001C003C00180000001C003FFFFFFFC3FFFC003
      FFFFFFFC3FFFC003FFFFFFFFFFFFFFFFFF7EFFFFFFFFFFFFBFFF00000000FFFF
      F00300000000FFFFE00300000000803FE00300000000803FE00300000000803F
      E00300000000803F200300000000803FE00200000000803FE003000000008003
      E003000000008003E003000000008003E003000000008003FFFF00000000FFFF
      BF7D00000000FFFF7F7EFFFFFFFFFFFFFFFFFFFFFFFFC001000000000000C001
      000000000000C001000000000000C001000000000000C001000000000000C001
      000000000000C001000000000000C001000000000000C001000700070000C001
      000700070000C001000700070000C001000700070000C001800F000F0000C003
      FFFFFFE70000C007FFFFFFFF0000C00FFE3F0FE1FFFFFFFFF00F07C100000000
      E00F010100000000E003800300000000C003800300000000C001C00700000000
      8001C007000000008001C007000000008001800300000000C003000100000007
      C003000100000007E007000100000007F00FF01F00000007F81FF83F0000800F
      FC1FF83F0000FFFFF81FFC7FFFFFFFFFC001F8FFC003FFFFC001F1FFC003FFFF
      C001E3FFC003FFFFC001E3FFC003E003C001E3DFC003FC1FC001E3CFC003FFEF
      C001E1C78003FFE7C001F0038003FFF7C001F0018003FFF7C001F8008003F7F7
      C001FC01C003F7F7C001FF03C003F3E7C001FFC7C003FB9FC003FFCFC007FC3F
      C007FFDFC00FFFFFC00FFFFFFFFFFFFFC001FFFFFFFF8001C001FFFFC0000001
      C0019FFB80000001C0018FFF80000001C00187F780000001C001C7EF80000001
      C001E3CF80000001C001F19F80008001C001F83F8000C001C001FC7F8000C001
      C001F83F8000C001C001F19F8001C001C001C3CFC07FC001C00387E7E0FFC003
      C0078FFBFFFFC007C00FFFFFFFFFC00FFFFFFFFFFFFFE001F000F000C001E001
      F000F000C000C001F000C000C000A001F000E000C0010001F000F000C0030001
      F000F000C0030001D0000000C0038001C0000000C0038001E0000000C003C001
      0000F000C003E001C000F000C003E0018000E000C003E0032000C000C003E007
      E000F000C003E00FEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC3FC003
      FFFFFE7FFC3FC003EF7FDE7BFC3FFE7FE73FCE73FC3FFC3FE31FC663FC3FF81F
      E10FC243FC3FF00FE007C003FC3FE007E007C003E007FC3FE10FC243F00FFC3F
      E31FC663F81FFC3FE73FCE73FC3FFC3FEF7FDE7BFE7FFC3FFFFFFE7FC003FC3F
      FFFFFFFFC003FC3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFE007FFFFE007FE7FF00FFEF7F00FFC3FF81FFCE7F81FF81FFC3FF8C7
      FC3FF00FFE7FF087FE7FE007C003E007E007FE7FC003E007F00FFC3FFE7FF087
      F81FF81FFC3FF8C7FC3FF00FF81FFCE7FE7FE007F00FFEF7FFFFFFFFE007FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC001FFFFC001FFFFC0010000C001CC1F
      C0010000C001800FC0010000C0010007C0010000C0010000C0010000C0010001
      C0010000C0010001C0010000C0018001C0010000C001C000C0010000C0018000
      C0010000C0010000C0010000C001F000C001803FC001F801C003C07FC003FC13
      C007E0FFC007FFFFC00FFFFFC00FFFFFFFFF8080FC01C00100008080FC01C001
      00008080F001C00100008080F001C00100008080C001C00100008080C001C001
      00008080C001C00100008080C001C00100008080C001C00100008080C003C001
      00008080C007000100008080C00FC001803F8080C01F8001C07F8080C03F0003
      E0FF8080C07FC007FFFF8080C0FFC00FFFFFFFFFFFFFFFFF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FFFFFFFFFFFFFFFF8003FFFFF81FFFFF00010000E007FFFF
      00000000C003FFFF0000000080017FFF0000000080013F7F0000000000000E3F
      000000000000861F800000000000C20FC00100000000E007F81F00000000F043
      F00F00000000F861E00700008001FC70C003803F8001FEFCF81FC07FC003FFFE
      F81FE0FFE007FFFFF83FFFFFF81FFFFF00000000000000000000000000000000
      000000000000}
  end
  object SaveDialog: TSaveDialog
    Left = 48
    Top = 128
  end
end
