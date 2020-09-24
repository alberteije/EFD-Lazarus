object FPreview: TFPreview
  Left = 559
  Top = 246
  BorderStyle = bsSingle
  Caption = 'Preview'
  ClientHeight = 378
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object RichEdit2: TRichEdit
    Left = 0
    Top = 0
    Width = 628
    Height = 378
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    HideScrollBars = False
    Lines.Strings = (
      '')
    ParentFont = False
    PlainText = True
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
    WordWrap = False
    ExplicitTop = 26
    ExplicitHeight = 352
  end
  object RichEdit: TRichEdit
    Left = 0
    Top = 0
    Width = 628
    Height = 378
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    HideScrollBars = False
    Lines.Strings = (
      '')
    ParentFont = False
    PlainText = True
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
    ExplicitTop = 26
    ExplicitHeight = 352
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 312
    Top = 258
  end
  object SaveDialog1: TSaveDialog
    Left = 432
    Top = 201
  end
end
