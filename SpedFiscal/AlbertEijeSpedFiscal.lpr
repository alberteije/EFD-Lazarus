program AlbertEijeSpedFiscal;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, printer4lazarus, UMenu, UDataModule, Biblioteca, Constantes,
  USpedFiscal, UPreview, EmpresaVO, ContadorVO, UnidadeProdutoVO, ProdutoVO,
  ImpressoraVO, NotaFiscalDetalheVO, NotaFiscalCabecalhoVO, R05VO, R04VO, R03VO,
  R02VO, ViewSpedNfeEmitenteVO, ViewSpedNfeDestinatarioVO, ViewSpedNfeItemVO,
  ProdutoAlteracaoItemVO, TributOperacaoFiscalVO, UnidadeConversaoVO,
  NfeCabecalhoLimpaVO, ViewSpedNfeDetalheVO, ViewSpedC190VO, NfeTransporteVO,
  NfeCupomFiscalReferenciadoVO, ViewSpedC425VO, ViewSpedC390VO, ViewSpedC370VO,
  ViewSpedC321VO, ViewSpedC300VO, ViewSpedC490VO, FiscalApuracaoIcmsVO,
  SpedFiscalController, UnidadeController, ProdutoController, EmpresaController,
  ContadorController, ImpressoraController, NotaFiscalController,
  RegistroRController, zcomponent;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TFMenu, FMenu);
  Application.CreateForm(TFDataModule, FDataModule);
  Application.CreateForm(TFSpedFiscal, FSpedFiscal);
  Application.CreateForm(TFPreview, FPreview);
  Application.Run;
end.

