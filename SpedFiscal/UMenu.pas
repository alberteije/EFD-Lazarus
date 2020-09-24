{*******************************************************************************
Title: AlbertEije ERP
Description: Janela Principal

The MIT License

Copyright: Copyright (C) 2012 Albert Eije

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

       The author may be contacted at:
           alberteije@gmail.com

@author Albert Eije
@version 1.0
*******************************************************************************}
unit UMenu;

{$mode objfpc}{$H+}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ComCtrls, Menus, ExtCtrls, Buttons, StdCtrls, inifiles;

type

  { TFMenu }

  TFMenu = class(TForm)
    PanelBarra: TPanel;
    MainMenu1: TMainMenu;
    LinhaStatus: TStatusBar;
    Cadastro1: TMenuItem;
    Movimento1: TMenuItem;
    Compras1: TMenuItem;
    Ajuda1: TMenuItem;
    Sobre1: TMenuItem;
    Image1: TImage;
    N1: TMenuItem;
    Sair1: TMenuItem;
    PanelCarga: TPanel;
    ImageCarga: TImage;
    SpeedButton1: TSpeedButton;
    SpeedButton5: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
  private
    Procedure ShowHint(Sender: TObject);
    { Private declarations }
  public
  var
  UsuarioLogado: string;
  end;

var
  FMenu: TFMenu;

implementation

uses UDataModule, USpedFiscal;
{$R *.lfm}

procedure TFMenu.Sair1Click(Sender: TObject);
begin
  Application.Terminate;
end;

Procedure TFMenu.ShowHint(Sender: TObject);
Begin
  LinhaStatus.Panels.items[0].text := Application.Hint;
End;

procedure TFMenu.FormCreate(Sender: TObject);
begin
  Application.OnHint := @ShowHint;
end;

procedure TFMenu.SpeedButton1Click(Sender: TObject);
begin
  Application.CreateForm(TFSpedFiscal, FSpedFiscal);
  FSpedFiscal.ShowModal;
end;

procedure TFMenu.SpeedButton5Click(Sender: TObject);
begin
  Close;
end;

end.
