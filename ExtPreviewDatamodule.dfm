object ExtPreviewDM: TExtPreviewDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 200
  Top = 120
  Height = 150
  Width = 215
  object ExecuteTimer: TTimer
    Enabled = False
    Interval = 200
    OnTimer = ExecuteTimerTimer
    Left = 120
    Top = 40
  end
end
