{*******************************************************************************
Title: AlbertEije ERP
Description: Permite a emissão do arquivo do SPED Fiscal

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
unit USpedFiscal;

{$mode objfpc}{$H+}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, MaskEdit, ComCtrls, DBGrids,
  UDataModule, db, ZDataset, DateUtils;

type

  { TFSpedFiscal }

  TFSpedFiscal = class(TForm)
    Bevel1: TBevel;
    botaoCancela: TBitBtn;
    botaoConfirma: TBitBtn;
    ComboBoxInventario: TComboBox;
    DatasourceContador: TDatasource;
    DBGrid1: TDBGrid;
    GroupBox1: TGroupBox;
    Image1: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label9: TLabel;
    mkeDataFim: TMaskEdit;
    mkeDataIni: TMaskEdit;
    Panel1: TPanel;
    PageControl1: TPageControl;
    PaginaSped: TTabSheet;
    Label6: TLabel;
    ComboBoxVersaoLeiauteSped: TComboBox;
    Label7: TLabel;
    ComboBoxFinalidadeArquivoSped: TComboBox;
    Label8: TLabel;
    ComboBoxPerfilSped: TComboBox;
    ZTableContador: TZTable;
    ZTableContadorBAIRRO: TStringField;
    ZTableContadorCEP: TStringField;
    ZTableContadorCIDADE: TStringField;
    ZTableContadorCOMPLEMENTO: TStringField;
    ZTableContadorEMAIL: TStringField;
    ZTableContadorFAX: TStringField;
    ZTableContadorFONE: TStringField;
    ZTableContadorID: TLargeintField;
    ZTableContadorINSCRICAO_CRC: TStringField;
    ZTableContadorLOGRADOURO: TStringField;
    ZTableContadorMUNICIPIO_IBGE: TLargeintField;
    ZTableContadorNUMERO: TStringField;
    ZTableContadorUF: TStringField;
    ZTableContadorUF_CRC: TStringField;
    procedure botaoCancelaClick(Sender: TObject);
    procedure Confirma;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure botaoConfirmaClick(Sender: TObject);
    procedure mkeDataIniExit(Sender: TObject);
    procedure mkeDataFimExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FSpedFiscal: TFSpedFiscal;

implementation

uses SpedFiscalController, UPreview;

{$R *.lfm}

procedure TFSpedFiscal.botaoConfirmaClick(Sender: TObject);
begin
  Confirma;
end;

procedure TFSpedFiscal.Confirma;
var
  FinalidadeArquivo, Versao, Perfil, Inventario, Contador: Integer;
begin
  if Application.MessageBox('Deseja gerar o arquivo do SPED FISCAL?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
  begin
    Versao := ComboBoxVersaoLeiauteSped.ItemIndex;
    FinalidadeArquivo := ComboBoxVersaoLeiauteSped.ItemIndex;
    Perfil := ComboBoxPerfilSped.ItemIndex;
    Inventario := ComboBoxInventario.ItemIndex;
    Contador := ZTableContadorId.AsInteger;
    TSpedFiscalController.GerarArquivoSpedFiscal(
                                       FormatDateTime('yyyy-mm-dd', StrToDate(mkeDataIni.Text)),
                                       FormatDateTime('yyyy-mm-dd', StrToDate(mkeDataFim.Text)),
                                       Versao,
                                       FinalidadeArquivo,
                                       Perfil,
                                       FDataModule.EmpresaID,
                                       Inventario,
                                       Contador
                                       );
    FPreview.RichEdit.Lines.LoadFromFile(ExtractFilePath(Application.ExeName) + 'SpedFiscal.txt');
    FPreview.ShowModal;
  end;
end;

procedure TFSpedFiscal.botaoCancelaClick(Sender: TObject);
begin
  Close;
end;

procedure TFSpedFiscal.FormActivate(Sender: TObject);
begin
  mkeDataIni.Text := DateToStr(StartOfTheMonth(Now));
  mkeDataFim.Text := DateToStr(EndOfTheMonth(Now));
  mkeDataIni.SetFocus;
  ZTableContador.Active := True;
end;

procedure TFSpedFiscal.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TFSpedFiscal.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = 123 then
    Confirma;
  if key = VK_ESCAPE then
    botaoCancela.Click;
end;

procedure TFSpedFiscal.mkeDataFimExit(Sender: TObject);
begin
  if  StrToDate(mkeDataIni.Text) > StrToDate(mkeDataFim.Text)  then
      begin
        Application.MessageBox('Data inicial não pode ser maior que data final!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
        mkeDataFim.setFocus;
      end;
end;

procedure TFSpedFiscal.mkeDataIniExit(Sender: TObject);
begin
  mkeDataFim.Text := DateToStr(EndOfTheMonth(strtodate(mkeDataIni.Text)));
end;

end.
