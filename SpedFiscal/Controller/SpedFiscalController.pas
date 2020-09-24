{*******************************************************************************
Title: AlbertEije ERP
Description: Classe de controle do Sped Fiscal

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
unit SpedFiscalController;

{$mode objfpc}{$H+}

interface

uses
  Forms, Classes, SysUtils, FGL, Biblioteca, EmpresaVO, ContadorVO,

  ViewSpedC190VO, ViewSpedC300VO, ViewSpedC321VO, ViewSpedC370VO, ViewSpedC390VO,
  ViewSpedC425VO, ViewSpedC490VO, FiscalApuracaoIcmsVO,

  ViewSpedNfeEmitenteVO, MeiosPagamentoVO, ViewSpedNfeDestinatarioVO,
  ViewSpedNfeItemVO, UnidadeProdutoVO, ProdutoVO, ProdutoAlteracaoItemVO,
  TributOperacaoFiscalVO, UnidadeConversaoVO, NfeCabecalhoLimpaVO,
  ViewSpedNfeDetalheVO, NfeCupomFiscalReferenciadoVO,
  Constantes, ZDataset, ACBrEFDBlocos, ACBrSpedFiscal;

type
  TListaObjeto = specialize TFPGObjectList<TObject>;
  TListaProdutoVO = specialize TFPGObjectList<TViewSpedNfeItemVO>;
  TListaProdutoAlteradoVO = specialize TFPGObjectList<TProdutoAlteracaoItemVO>;
  TListaUnidadeProdutoVO = specialize TFPGObjectList<TUnidadeProdutoVO>;
  TListaOperacaoFiscalVO = specialize TFPGObjectList<TTributOperacaoFiscalVO>;
  TListaEmitenteVO = specialize TFPGObjectList<TViewSpedNfeEmitenteVO>;
  TListaDestinatarioVO = specialize TFPGObjectList<TViewSpedNfeDestinatarioVO>;

  TListaSpedFiscalC190VO = specialize TFPGObjectList<TViewSpedC190VO>;
  TListaSpedFiscalC300VO = specialize TFPGObjectList<TViewSpedC300VO>;
  TListaSpedFiscalC321VO = specialize TFPGObjectList<TViewSpedC321VO>;
  TListaSpedFiscalC370VO = specialize TFPGObjectList<TViewSpedC370VO>;
  TListaSpedFiscalC390VO = specialize TFPGObjectList<TViewSpedC390VO>;
  TListaSpedFiscalC425VO = specialize TFPGObjectList<TViewSpedC425VO>;
  TListaSpedFiscalC490VO = specialize TFPGObjectList<TViewSpedC490VO>;

  TListaMeiosPagamentoVO = specialize TFPGObjectList<TMeiosPagamentoVO>;
  TSpedFiscalController = class
  protected
  public
    class function TabelaC190(pId: Integer): TListaSpedFiscalC190VO;
    class function TabelaC300: TListaSpedFiscalC300VO;
    class function TabelaC390: TListaSpedFiscalC390VO;
    class function TabelaC321: TListaSpedFiscalC321VO;
    class function TabelaC370: TListaSpedFiscalC370VO;
    class function TabelaC425: TListaSpedFiscalC425VO;
    class function TabelaC490: TListaSpedFiscalC490VO;
    class function TabelaE110: TFiscalApuracaoIcmsVO;
    class function TabelaEmitente: TListaEmitenteVO;
    class function TabelaDestinatario: TListaDestinatarioVO;
    class function TabelaProduto: TListaProdutoVO;
    class function TabelaProdutoAlterado: TListaProdutoAlteradoVO;
    class function TabelaOperacaoFiscal: TListaOperacaoFiscalVO;
    //
    class procedure GerarBloco0;
    class procedure GerarBlocoC;
    class procedure GerarBlocoE;
    class procedure GerarBlocoH;
    class procedure GerarBloco1;
    class procedure GerarArquivoSpedFiscal(pDataIni: String; pDataFim: String; pVersao: Integer; pFinalidade: Integer; pPerfil: Integer; pEmpresa: Integer; pInventario: Integer; pContador: Integer);
 end;

implementation

uses UDataModule,
  EmpresaController, ContadorController, ImpressoraController, NotaFiscalController,
  RegistroRController, UnidadeController, ProdutoController,
  //
  NotaFiscalCabecalhoVO, NotaFiscalDetalheVO, NFeTransporteVO,
  ImpressoraVO, R02VO, R03VO, R04VO, R05VO;

var
  ConsultaSQL: String;
  Query: TZQuery;
  Empresa: TEmpresaVO;
  VersaoLeiaute, FinalidadeArquivo, PerfilApresentacao, IdEmpresa, Inventario, IdContador: Integer;
  DataInicial, DataFinal: String;


{$Region: 'Consultas no SGBD'}
class function TSpedFiscalController.TabelaC190(pId: Integer): TListaSpedFiscalC190VO;
var
  RegistroC190: TViewSpedC190VO;
begin
   ConsultaSQL := 'select * from VIEW_SPED_C190 '+
                  ' where ID = ' + IntToStr(pId);

  try
    try
      Result := TListaSpedFiscalC190VO.Create;

      Query := TZQuery.Create(nil);
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        RegistroC190 := TViewSpedC190VO.Create;

        RegistroC190.Id := Query.FieldByName('ID').AsInteger;
        RegistroC190.CstIcms := Query.FieldByName('CST_ICMS').AsString;
        RegistroC190.Cfop := Query.FieldByName('CFOP').AsInteger;
        RegistroC190.AliquotaIcms := Query.FieldByName('ALIQUOTA_ICMS').AsFloat;
        RegistroC190.DataEmissao := Query.FieldByName('DATA_EMISSAO').AsDateTime;
        RegistroC190.SomaValorOperacao := Query.FieldByName('SOMA_VALOR_OPERACAO').AsFloat;
        RegistroC190.SomaBaseCalculoIcms := Query.FieldByName('SOMA_BASE_CALCULO_ICMS').AsFloat;
        RegistroC190.SomaValorIcms := Query.FieldByName('SOMA_VALOR_ICMS').AsFloat;
        RegistroC190.SomaBaseCalculoIcmsSt := Query.FieldByName('SOMA_BASE_CALCULO_ICMS_ST').AsFloat;
        RegistroC190.SomaValorIcmsSt := Query.FieldByName('SOMA_VALOR_ICMS_ST').AsFloat;
        RegistroC190.SomaVlRedBc := Query.FieldByName('SOMA_VL_RED_BC').AsFloat;
        RegistroC190.SomaValorIpi := Query.FieldByName('SOMA_VALOR_IPI').AsFloat;

        Result.Add(RegistroC190);
        Query.next;
      end;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TSpedFiscalController.TabelaC370: TListaSpedFiscalC370VO;
var
  RegistroC370: TViewSpedC370VO;
begin
  ConsultaSQL :=
    'select * from VIEW_SPED_C370 '+
    ' where DATA_EMISSAO BETWEEN ' + QuotedStr(DataInicial) + ' and ' + QuotedStr(DataFinal);

  try
    try
      Result := TListaSpedFiscalC370VO.Create;

      Query := TZQuery.Create(nil);
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        RegistroC370 := TViewSpedC370VO.Create;

        RegistroC370.IdNfCabecalho := Query.FieldByName('ID_NF_CABECALHO').AsInteger;
        RegistroC370.IdProduto := Query.FieldByName('ID_PRODUTO').AsInteger;
        RegistroC370.Item := Query.FieldByName('ITEM').AsInteger;
        RegistroC370.IdUnidadeProduto := Query.FieldByName('ID_UNIDADE_PRODUTO').AsInteger;
        RegistroC370.Quantidade := Query.FieldByName('QUANTIDADE').AsFloat;
        RegistroC370.ValorTotal := Query.FieldByName('VALOR_TOTAL').AsFloat;
        RegistroC370.Cst := Query.FieldByName('CST').AsString;
        RegistroC370.Desconto := Query.FieldByName('DESCONTO').AsFloat;

        Result.Add(RegistroC370);
        Query.next;
      end;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;

end;

class function TSpedFiscalController.TabelaC300: TListaSpedFiscalC300VO;
var
  RegistroC300: TViewSpedC300VO;
begin
  ConsultaSQL :=
  'select * from VIEW_SPED_C300 '+
  ' where DATA_EMISSAO BETWEEN ' + QuotedStr(DataInicial) + ' and ' + QuotedStr(DataFinal);

  try
    try
      Result := TListaSpedFiscalC300VO.Create;

      Query := TZQuery.Create(nil);
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        RegistroC300 := TViewSpedC300VO.Create;
        RegistroC300.Serie := Query.FieldByName('SERIE').AsString;
        RegistroC300.Subserie := Query.FieldByName('SUBSERIE').AsString;
        RegistroC300.SomaTotalNf := Query.FieldByName('SOMA_TOTAL_NF').AsFloat;
        RegistroC300.SomaPis := Query.FieldByName('SOMA_PIS').AsFloat;
        RegistroC300.SomaCofins := Query.FieldByName('SOMA_COFINS').AsFloat;

        Result.Add(RegistroC300);
        Query.next;
      end;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TSpedFiscalController.TabelaC390: TListaSpedFiscalC390VO;
var
  RegistroC390: TViewSpedC390VO;
begin
  ConsultaSQL :=
  'select * from VIEW_SPED_C390 '+
  ' where DATA_EMISSAO BETWEEN ' + QuotedStr(DataInicial) + ' and ' + QuotedStr(DataFinal);

  try
    try
      Result := TListaSpedFiscalC390VO.Create;

      Query := TZQuery.Create(nil);
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        RegistroC390 := TViewSpedC390VO.Create;
        RegistroC390.CST := Query.FieldByName('CST').AsString;
        RegistroC390.CFOP := Query.FieldByName('CFOP').AsInteger;
        RegistroC390.TaxaICMS := Query.FieldByName('TAXA_ICMS').AsFloat;
        RegistroC390.SomaItem := Query.FieldByName('SOMA_ITEM').AsFloat;
        RegistroC390.SomaBaseICMS := Query.FieldByName('SOMA_BASE_ICMS').AsFloat;
        RegistroC390.SomaICMS := Query.FieldByName('SOMA_ICMS').AsFloat;
        RegistroC390.SomaICMSOutras := Query.FieldByName('SOMA_ICMS_OUTRAS').AsFloat;

        Result.Add(RegistroC390);
        Query.next;
      end;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TSpedFiscalController.TabelaC321: TListaSpedFiscalC321VO;
var
  RegistroC321: TViewSpedC321VO;
begin
  ConsultaSQL :=
    'select * from VIEW_SPED_C321 '+
    'where '+
    'DATA_EMISSAO between '+
    QuotedStr(DataInicial) + ' and ' + QuotedStr(DataFinal);

  try
    try
      Result := TListaSpedFiscalC321VO.Create;

      Query := TZQuery.Create(nil);
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        RegistroC321 := TViewSpedC321VO.Create;

        RegistroC321.IdProduto := Query.FieldByName('ID_PRODUTO').AsInteger;
        RegistroC321.DescricaoUnidade := Query.FieldByName('DESCRICAO_UNIDADE').AsString;
        RegistroC321.SomaQuantidade := Query.FieldByName('SOMA_QUANTIDADE').AsFloat;
        RegistroC321.SomaItem := Query.FieldByName('SOMA_ITEM').AsFloat;
        RegistroC321.SomaDesconto := Query.FieldByName('SOMA_DESCONTO').AsFloat;
        RegistroC321.SomaBaseIcms := Query.FieldByName('SOMA_BASE_ICMS').AsFloat;
        RegistroC321.SomaIcms := Query.FieldByName('SOMA_ICMS').AsFloat;
        RegistroC321.SomaPis := Query.FieldByName('SOMA_PIS').AsFloat;
        RegistroC321.SomaCofins := Query.FieldByName('SOMA_COFINS').AsFloat;

        Result.Add(RegistroC321);
        Query.next;
      end;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TSpedFiscalController.TabelaC425: TListaSpedFiscalC425VO;
var
  RegistroC425: TViewSpedC425VO;
begin
  ConsultaSQL :=
    'select * from VIEW_SPED_C425 '+
    'where '+
    'TOTALIZADOR_PARCIAL not like ' + QuotedStr('%CAN%') + 'and TOTALIZADOR_PARCIAL not like ' + QuotedStr('%S%') + ' and (DATA_VENDA BETWEEN ' + QuotedStr(DataInicial) + ' and ' + QuotedStr(DataFinal) + ')';

  try
    try
      Result := TListaSpedFiscalC425VO.Create;

      Query := TZQuery.Create(nil);
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        RegistroC425 := TViewSpedC425VO.Create;

        RegistroC425.IdEcfProduto := Query.FieldByName('ID_ECF_PRODUTO').AsInteger;
        RegistroC425.DescricaoUnidade := Query.FieldByName('DESCRICAO_UNIDADE').AsString;
        RegistroC425.TotalizadorParcial := Query.FieldByName('TOTALIZADOR_PARCIAL').AsString;
        RegistroC425.DataVenda := Query.FieldByName('DATA_VENDA').AsDateTime;
        RegistroC425.SomaQuantidade := Query.FieldByName('SOMA_QUANTIDADE').AsFloat;
        RegistroC425.SomaItem := Query.FieldByName('SOMA_ITEM').AsFloat;
        RegistroC425.SomaPis := Query.FieldByName('SOMA_PIS').AsFloat;
        RegistroC425.SomaCofins := Query.FieldByName('SOMA_COFINS').AsFloat;

        Result.Add(RegistroC425);
        Query.next;
      end;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TSpedFiscalController.TabelaC490: TListaSpedFiscalC490VO;
var
  RegistroC490: TViewSpedC490VO;
begin
  ConsultaSQL :=  'select * from VIEW_SPED_C490 '+
    'where '+
    'DATA_VENDA BETWEEN ' + QuotedStr(DataInicial) + ' and ' + QuotedStr(DataFinal);

  try
    try
      Result := TListaSpedFiscalC490VO.Create;

      Query := TZQuery.Create(nil);
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        RegistroC490 := TViewSpedC490VO.Create;

        RegistroC490.CST := Query.FieldByName('CST').AsString;
        RegistroC490.CFOP := Query.FieldByName('CFOP').AsInteger;
        RegistroC490.TaxaIcms := Query.FieldByName('TAXA_ICMS').AsFloat;
        RegistroC490.SomaItem := Query.FieldByName('SOMA_ITEM').AsFloat;
        RegistroC490.SomaBaseIcms := Query.FieldByName('SOMA_BASE_ICMS').AsFloat;
        RegistroC490.SomaIcms := Query.FieldByName('SOMA_ICMS').AsFloat;

        Result.Add(RegistroC490);
        Query.next;
      end;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TSpedFiscalController.TabelaE110: TFiscalApuracaoIcmsVO;
var
  Competencia: String;
begin
    Competencia := Copy(DataInicial, 6, 2) + '/' + Copy(DataInicial, 1, 4);
    ConsultaSQL :=
                  'select * from FISCAL_APURACAO_ICMS '+
                  'where '+
                  'COMPETENCIA = '+ QuotedStr(Competencia);

  try
    try
      Query := TZQuery.Create(nil);
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;

      Result := TFiscalApuracaoIcmsVO.Create;
      Result.Id := Query.FieldByName('ID').AsInteger;
      Result.IdEmpresa := Query.FieldByName('ID_EMPRESA').AsInteger;
      Result.Competencia := Query.FieldByName('COMPETENCIA').AsString;
      Result.ValorTotalDebito := Query.FieldByName('VALOR_TOTAL_DEBITO').AsFloat;
      Result.ValorAjusteDebito := Query.FieldByName('VALOR_AJUSTE_DEBITO').AsFloat;
      Result.ValorTotalAjusteDebito := Query.FieldByName('VALOR_TOTAL_AJUSTE_DEBITO').AsFloat;
      Result.ValorEstornoCredito := Query.FieldByName('VALOR_ESTORNO_CREDITO').AsFloat;
      Result.ValorTotalCredito := Query.FieldByName('VALOR_TOTAL_CREDITO').AsFloat;
      Result.ValorAjusteCredito := Query.FieldByName('VALOR_AJUSTE_CREDITO').AsFloat;
      Result.ValorTotalAjusteCredito := Query.FieldByName('VALOR_TOTAL_AJUSTE_CREDITO').AsFloat;
      Result.ValorEstornoDebito := Query.FieldByName('VALOR_ESTORNO_DEBITO').AsFloat;
      Result.ValorSaldoCredorAnterior := Query.FieldByName('VALOR_SALDO_CREDOR_ANTERIOR').AsFloat;
      Result.ValorSaldoApurado := Query.FieldByName('VALOR_SALDO_APURADO').AsFloat;
      Result.ValorTotalDeducao := Query.FieldByName('VALOR_TOTAL_DEDUCAO').AsFloat;
      Result.ValorIcmsRecolher := Query.FieldByName('VALOR_ICMS_RECOLHER').AsFloat;
      Result.ValorSaldoCredorTransp := Query.FieldByName('VALOR_SALDO_CREDOR_TRANSP').AsFloat;
      Result.ValorDebitoEspecial := Query.FieldByName('VALOR_DEBITO_ESPECIAL').AsFloat;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TSpedFiscalController.TabelaEmitente: TListaEmitenteVO;
var
   Emitente: TViewSpedNfeEmitenteVO;
begin
  ConsultaSQL :=
                'select * from VIEW_SPED_NFE_EMITENTE '+
                'where '+
                'ID in (select ID_FORNECEDOR from NFE_CABECALHO where DATA_EMISSAO BETWEEN ' + QuotedStr(DataInicial) + ' and ' + QuotedStr(DataFinal) + ')';

  try
    try
      Result := TListaEmitenteVO.Create;

      Query := TZQuery.Create(nil);
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        Emitente := TViewSpedNfeEmitenteVO.Create;
        Emitente.Id := Query.FieldByName('ID').AsInteger;
        Emitente.RazaoSocial := Query.FieldByName('RAZAO_SOCIAL').AsString;
        Emitente.CpfCnpj := Query.FieldByName('CPF_CNPJ').AsString;
        Emitente.InscricaoEstadual := Query.FieldByName('INSCRICAO_ESTADUAL').AsString;
        Emitente.CodigoMunicipio := Query.FieldByName('CODIGO_MUNICIPIO').AsInteger;
        Emitente.Suframa := Query.FieldByName('SUFRAMA').AsString;
        Emitente.Logradouro := Query.FieldByName('LOGRADOURO').AsString;
        Emitente.Numero := Query.FieldByName('NUMERO').AsString;
        Emitente.Complemento := Query.FieldByName('COMPLEMENTO').AsString;
        Emitente.Bairro := Query.FieldByName('BAIRRO').AsString;
        Result.Add(Emitente);
        Query.next;
      end;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TSpedFiscalController.TabelaDestinatario: TListaDestinatarioVO;
var
   Destinatario: TViewSpedNfeDestinatarioVO;
begin
  ConsultaSQL :=
                'select * from VIEW_SPED_NFE_DESTINATARIO '+
                'where '+
                'ID in (select ID_CLIENTE from NFE_CABECALHO where DATA_EMISSAO BETWEEN ' + QuotedStr(DataInicial) + ' and ' + QuotedStr(DataFinal) + ')';

  try
    try
      Result := TListaDestinatarioVO.Create;

      Query := TZQuery.Create(nil);
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        Destinatario := TViewSpedNfeDestinatarioVO.Create;
        Destinatario.Id := Query.FieldByName('ID').AsInteger;
        Destinatario.RazaoSocial := Query.FieldByName('RAZAO_SOCIAL').AsString;
        Destinatario.CpfCnpj := Query.FieldByName('CPF_CNPJ').AsString;
        Destinatario.InscricaoEstadual := Query.FieldByName('INSCRICAO_ESTADUAL').AsString;
        Destinatario.CodigoMunicipio := Query.FieldByName('CODIGO_MUNICIPIO').AsInteger;
        Destinatario.Suframa := Query.FieldByName('SUFRAMA').AsString;
        Destinatario.Logradouro := Query.FieldByName('LOGRADOURO').AsString;
        Destinatario.Numero := Query.FieldByName('NUMERO').AsString;
        Destinatario.Complemento := Query.FieldByName('COMPLEMENTO').AsString;
        Destinatario.Bairro := Query.FieldByName('BAIRRO').AsString;
        Result.Add(Destinatario);
        Query.next;
      end;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TSpedFiscalController.TabelaProduto: TListaProdutoVO;
var
   Produto: TViewSpedNfeItemVO;
begin
  ConsultaSQL :=
                'select * from VIEW_SPED_NFE_ITEM '+
                'where '+
                'ID in (select ID_PRODUTO from NFE_DETALHE JOIN NFE_CABECALHO ON NFE_DETALHE.ID_NFE_CABECALHO = NFE_CABECALHO.ID' +
                ' where NFE_CABECALHO.DATA_EMISSAO BETWEEN ' + QuotedStr(DataInicial) + ' and ' + QuotedStr(DataFinal) + ')';

  try
    try
      Result := TListaProdutoVO.Create;

      Query := TZQuery.Create(nil);
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        Produto := TViewSpedNfeItemVO.Create;
        Produto.Id := Query.FieldByName('ID').AsInteger;
        Produto.Nome := Query.FieldByName('NOME').AsString;
        Produto.Gtin := Query.FieldByName('GTIN').AsString;
        Produto.IdUnidadeProduto := Query.FieldByName('ID_UNIDADE_PRODUTO').AsInteger;
        Produto.Sigla := Query.FieldByName('SIGLA').AsString;
        Produto.TipoItemSped := Query.FieldByName('TIPO_ITEM_SPED').AsString;
        Produto.Ncm := Query.FieldByName('NCM').AsString;
        Produto.ExTipi := Query.FieldByName('EX_TIPI').AsString;
        Produto.CodigoLst := Query.FieldByName('CODIGO_LST').AsString;
        Produto.AliquotaIcmsPaf := Query.FieldByName('ALIQUOTA_ICMS_PAF').AsFloat;
        Result.Add(Produto);
        Query.next;
      end;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TSpedFiscalController.TabelaProdutoAlterado: TListaProdutoAlteradoVO;
var
   ProdutoAlterado: TProdutoAlteracaoItemVO;
begin
  ConsultaSQL :=
                'select * from PRODUTO_ALTERACAO_ITEM '+
                'where '+
                'DATA_INICIAL BETWEEN ' + QuotedStr(DataInicial) + ' and ' + QuotedStr(DataFinal);

  try
    try
      Result := TListaProdutoAlteradoVO.Create;

      Query := TZQuery.Create(nil);
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        ProdutoAlterado := TProdutoAlteracaoItemVO.Create;
        ProdutoAlterado.Id := Query.FieldByName('ID').AsInteger;
        ProdutoAlterado.IdProduto := Query.FieldByName('ID_PRODUTO').AsInteger;
        ProdutoAlterado.Codigo := Query.FieldByName('CODIGO').AsString;
        ProdutoAlterado.Nome := Query.FieldByName('NOME').AsString;
        ProdutoAlterado.DataInicial := Query.FieldByName('DATA_INICIAL').AsDateTime;
        ProdutoAlterado.DataFinal := Query.FieldByName('DATA_FINAL').AsDateTime;
        Result.Add(ProdutoAlterado);
        Query.next;
      end;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TSpedFiscalController.TabelaOperacaoFiscal: TListaOperacaoFiscalVO;
var
   OperacaoFiscal: TTributOperacaoFiscalVO;
begin
  ConsultaSQL :=
                'select * from TRIBUT_OPERACAO_FISCAL '+
                'where ID>0';

  try
    try
      Result := TListaOperacaoFiscalVO.Create;

      Query := TZQuery.Create(nil);
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        OperacaoFiscal := TTributOperacaoFiscalVO.Create;
        OperacaoFiscal.Id := Query.FieldByName('ID').AsInteger;
        OperacaoFiscal.IdEmpresa := Query.FieldByName('ID_EMPRESA').AsInteger;
        OperacaoFiscal.Descricao := Query.FieldByName('DESCRICAO').AsString;
        OperacaoFiscal.DescricaoNaNf := Query.FieldByName('DESCRICAO_NA_NF').AsString;
        OperacaoFiscal.Cfop := Query.FieldByName('CFOP').AsInteger;
        OperacaoFiscal.Observacao := Query.FieldByName('OBSERVACAO').AsString;
        Result.Add(OperacaoFiscal);
        Query.next;
      end;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;
{$EndRegion}

{$Region: 'Geração do Arquivo'}

{$REGION 'BLOCO 0: ABERTURA, IDENTIFICAÇÃO E REFERÊNCIAS'}
class procedure TSpedFiscalController.GerarBloco0;
var
  Contador: TContadorVO;
  ListaProduto: TListaProdutoVO;
  ListaEmitente: TListaEmitenteVO;
  ListaDestinatario: TListaDestinatarioVO;
  ListaUnidade: TListaUnidadeProdutoVO;
  ListaProdutoAlterado: TListaProdutoAlteradoVO;
  ListaOperacaoFiscal: TListaOperacaoFiscalVO;
  UnidadeConversao: TUnidadeConversaoVO;
  UnidadeProduto: TUnidadeProdutoVO;
  ListaParticipante: TStringList;
  ListaSiglaUnidade: TStringList;
  i: Integer;
begin
  try
    Empresa := TEmpresaController.PegaEmpresa(FDataModule.EmpresaID);
    Contador := TContadorController.PegaContador;
    ListaEmitente := TabelaEmitente;
    ListaDestinatario := TabelaDestinatario;
    ListaProduto := TabelaProduto;
    ListaProdutoAlterado := TabelaProdutoAlterado;
    ListaOperacaoFiscal := TabelaOperacaoFiscal;

    with FDataModule.ACBrSpedFiscal.Bloco_0 do
    begin
      // REGISTRO 0000: ABERTURA DO ARQUIVO DIGITAL E IDENTIFICAÇÃO DA ENTIDADE
      with Registro0000New do
      begin
        COD_VER := TACBrVersaoLeiaute(VersaoLeiaute);
        COD_FIN := TACBrCodFinalidade(FinalidadeArquivo);
        DT_INI := TextoParaData(DataInicial);
        DT_FIN := TextoParaData(DataFinal);
        IND_PERFIL := TACBrPerfil(PerfilApresentacao);
        NOME := Empresa.RazaoSocial;
        CNPJ := Empresa.CNPJ;
        CPF := '';
        UF := Empresa.Uf;
        IE := Empresa.InscricaoEstadual;
        COD_MUN := Empresa.CodigoIbgeCidade;
        IM := Empresa.InscricaoMunicipal;
        SUFRAMA := Empresa.SUFRAMA;
        IND_ATIV := atOutros;
      end;

      // REGISTRO 0001: ABERTURA DO BLOCO 0
      with Registro0001New do
      begin
        IND_MOV := imComDados;

        // REGISTRO 0005: DADOS COMPLEMENTARES DA ENTIDADE
        with Registro0005New do
        begin
          FANTASIA := Empresa.NomeFantasia;
          CEP := Empresa.Cep;
          ENDERECO := Empresa.Logradouro;
          NUM := Empresa.Numero;
          COMPL := Empresa.Complemento;
          BAIRRO := Empresa.Bairro;
          FONE := Empresa.Fone;
          FAX := Empresa.Fax;
          EMAIL := Empresa.Email;
        end; // with Registro0005New do

        // REGISTRO 0015: DADOS DO CONTRIBUINTE SUBSTITUTO
        { Implementado a critério do Leitor }

        // REGISTRO 0100: DADOS DO CONTABILISTA
        with Registro0100New do
        begin
          NOME := Contador.Nome;
          if Length(Contador.CpfCnpj) > 11 then
            CNPJ := Contador.CpfCnpj
          else
            CPF := Contador.CpfCnpj;
          CRC := Contador.InscricaoCrc;
          CEP := Contador.CEP;
          ENDERECO := Contador.Logradouro;
          NUM := Contador.Numero;
          COMPL := Contador.Complemento;
          BAIRRO := Contador.BAIRRO;
          FONE := Contador.FONE;
          FAX := Contador.FAX;
          EMAIL := Contador.EMAIL;
          COD_MUN := Contador.MunicipioIbge;
        end; // with Registro0100New do


        // REGISTRO 0150: TABELA DE CADASTRO DO PARTICIPANTE
        ListaParticipante := TStringList.Create;
        if assigned(ListaEmitente) then
        begin
          for i := 0 to ListaEmitente.Count - 1 do
          begin
            with Registro0150New do
            begin
              COD_PART := 'C' + IntToStr(TViewSpedNfeEmitenteVO(ListaEmitente.Items[i]).Id);
              NOME := TViewSpedNfeEmitenteVO(ListaEmitente.Items[i]).RazaoSocial;
              COD_PAIS := '01058';
              if Length(TViewSpedNfeEmitenteVO(ListaEmitente.Items[i]).CpfCnpj) = 11 then
                CPF := TViewSpedNfeEmitenteVO(ListaEmitente.Items[i]).CpfCnpj
              else
                CNPJ := TViewSpedNfeEmitenteVO(ListaEmitente.Items[i]).CpfCnpj;
              IE := TViewSpedNfeEmitenteVO(ListaEmitente.Items[i]).InscricaoEstadual;
              COD_MUN := TViewSpedNfeEmitenteVO(ListaEmitente.Items[i]).CodigoMunicipio;
              SUFRAMA := TViewSpedNfeEmitenteVO(ListaEmitente.Items[i]).Suframa;
              ENDERECO := TViewSpedNfeEmitenteVO(ListaEmitente.Items[i]).Logradouro;
              NUM := TViewSpedNfeEmitenteVO(ListaEmitente.Items[i]).Numero;
              COMPL := TViewSpedNfeEmitenteVO(ListaEmitente.Items[i]).Complemento;
              BAIRRO := TViewSpedNfeEmitenteVO(ListaEmitente.Items[i]).Bairro;
              //
              ListaParticipante.Add(COD_PART);
            end; // with Registro0150New do
          end; // for I := 0 to ListaEmitente.Count - 1 do
        end; // if assigned(ListaEmitente) then

        if assigned(ListaDestinatario) then
        begin
          for i := 0 to ListaDestinatario.Count - 1 do
          begin
            if ListaParticipante.IndexOf(TViewSpedNfeEmitenteVO(ListaEmitente.Items[i]).CpfCnpj) = -1 then
            begin
              with Registro0150New do
              begin
                COD_PART := 'F' + IntToStr(TViewSpedNfeEmitenteVO(ListaEmitente.Items[i]).Id);
                NOME := TViewSpedNfeDestinatarioVO(ListaEmitente.Items[i]).RazaoSocial;
                COD_PAIS := '01058';
                if Length(TViewSpedNfeDestinatarioVO(ListaEmitente.Items[i]).CpfCnpj) = 11 then
                  CPF := TViewSpedNfeDestinatarioVO(ListaEmitente.Items[i]).CpfCnpj
                else
                  CNPJ := TViewSpedNfeDestinatarioVO(ListaEmitente.Items[i]).CpfCnpj;
                IE := TViewSpedNfeDestinatarioVO(ListaEmitente.Items[i]).InscricaoEstadual;
                COD_MUN := TViewSpedNfeDestinatarioVO(ListaEmitente.Items[i]).CodigoMunicipio;
                SUFRAMA := TViewSpedNfeDestinatarioVO(ListaEmitente.Items[i]).Suframa;
                ENDERECO := TViewSpedNfeDestinatarioVO(ListaEmitente.Items[i]).Logradouro;
                NUM := TViewSpedNfeDestinatarioVO(ListaEmitente.Items[i]).Numero;
                COMPL := TViewSpedNfeDestinatarioVO(ListaEmitente.Items[i]).Complemento;
                BAIRRO := TViewSpedNfeDestinatarioVO(ListaEmitente.Items[i]).Bairro;
              end; // with Registro0150New do
            end;
          end; // for I := 0 to ListaDestinatario.Count - 1 do
        end; // if assigned(ListaDestinatario) then

        // REGISTRO 0175: ALTERAÇÃO DA TABELA DE CADASTRO DE PARTICIPANTE
        { Implementado a critério do Leitor }

        //REGISTRO 0200: TABELA DE IDENTIFICAÇÃO DO ITEM (PRODUTO E SERVIÇOS)
        ListaSiglaUnidade := TStringList.Create;
        ListaUnidade := TListaUnidadeProdutoVO.Create;
        for i := 0 to ListaProduto.Count - 1 do
        begin
          with Registro0200New do
          begin
            COD_ITEM := IntToStr(TViewSpedNfeItemVO(ListaProduto.Items[i]).Id);
            DESCR_ITEM := TViewSpedNfeItemVO(ListaProduto.Items[i]).NOME;
            COD_BARRA := TViewSpedNfeItemVO(ListaProduto.Items[i]).GTIN;
            COD_ANT_ITEM := '';
            UNID_INV := IntToStr(TViewSpedNfeItemVO(ListaProduto.Items[i]).IdUnidadeProduto);
            TIPO_ITEM := TACBrTipoItem(StrToInt(TViewSpedNfeItemVO(ListaProduto.Items[i]).TipoItemSped));
            COD_NCM := TViewSpedNfeItemVO(ListaProduto.Items[i]).NCM;
            EX_IPI := TViewSpedNfeItemVO(ListaProduto.Items[i]).ExTipi;
            COD_GEN := Copy(TViewSpedNfeItemVO(ListaProduto.Items[i]).NCM, 1, 2);
            COD_LST := TViewSpedNfeItemVO(ListaProduto.Items[i]).CodigoLst;
            ALIQ_ICMS := TViewSpedNfeItemVO(ListaProduto.Items[i]).AliquotaIcmsPaf;

            if ListaSiglaUnidade.IndexOf(IntToStr(TViewSpedNfeItemVO(ListaProduto.Items[i]).IdUnidadeProduto)) = -1 then
            begin
              ListaSiglaUnidade.Add(IntToStr(TViewSpedNfeItemVO(ListaProduto.Items[i]).IdUnidadeProduto));
              UnidadeProduto := TUnidadeProdutoVO.Create;
              UnidadeProduto.Id := TViewSpedNfeItemVO(ListaProduto.Items[i]).IdUnidadeProduto;
              UnidadeProduto.Sigla := TViewSpedNfeItemVO(ListaProduto.Items[i]).Sigla;
              ListaUnidade.Add(UnidadeProduto);

              // REGISTRO 0220: FATORES DE CONVERSÃO DE UNIDADES
              UnidadeConversao := TUnidadeController.ConsultaUnidadeConversao(TViewSpedNfeItemVO(ListaProduto.Items[i]).Id, UnidadeProduto.Id);
              if Assigned(UnidadeConversao) then
              begin
                with Registro0220New do
                begin
                  UNID_CONV := IntToStr(UnidadeConversao.IdUnidadeProduto);
                  FAT_CONV := UnidadeConversao.FatorConversao;
                end; // with Registro0200New do
              end; // if Assigned(UnidadeConversao) then
            end; // if ListaSiglaUnidade.IndexOf(IntToStr(TViewSpedNfeItemVO(ListaProduto.Items[i]).IdUnidadeProduto)) = -1 then
          end; // with Registro0200New do
        end; // for i := 0 to ListaProduto.Count - 1 do

        // REGISTRO 0190: IDENTIFICAÇÃO DAS UNIDADES DE MEDIDA
        for i := 0 to ListaUnidade.Count - 1 do
        begin
          with Registro0190New do
          begin
            UNID := IntToStr(TUnidadeProdutoVO(ListaUnidade.Items[i]).Id);
            DESCR := TUnidadeProdutoVO(ListaUnidade.Items[i]).Sigla;
          end;
        end;

        // REGISTRO 0205: ALTERAÇÃO DO ITEM
        for i := 0 to ListaProdutoAlterado.Count - 1 do
        begin
          with Registro0205New do
          begin
            DESCR_ANT_ITEM := TProdutoAlteracaoItemVO(ListaProduto.Items[i]).Nome;
            DT_INI := TProdutoAlteracaoItemVO(ListaProduto.Items[i]).DataInicial;
            DT_FIN := TProdutoAlteracaoItemVO(ListaProduto.Items[i]).DataFinal;
            COD_ANT_ITEM  := TProdutoAlteracaoItemVO(ListaProduto.Items[i]).Codigo;
          end; // with Registro0205New do
        end; // for i := 0 to ListaProdutoAlterado.Count - 1 do

        // REGISTRO 0206: CÓDIGO DE PRODUTO CONFORME TABELA PUBLICADA PELA ANP (COMBUSTÍVEIS)
        { Implementado a critério do Leitor }

        // REGISTRO 0300: CADASTRO DE BENS OU COMPONENTES DO ATIVO IMOBILIZADO
        // REGISTRO 0305: INFORMAÇÃO SOBRE A UTILIZAÇÃO DO BEM
        { Implementado a critério do Leitor }

        // REGISTRO 0400: TABELA DE NATUREZA DA OPERAÇÃO/PRESTAÇÃO
        for i := 0 to ListaOperacaoFiscal.Count - 1 do
        begin
          with Registro0400New do
          begin
            COD_NAT := IntToStr(TTributOperacaoFiscalVO(ListaOperacaoFiscal.Items[i]).Id);
            DESCR_NAT := TTributOperacaoFiscalVO(ListaOperacaoFiscal.Items[i]).DescricaoNaNf;
          end; // with Registro0400New do
        end; // for i := 0 to ListaOperacaoFiscal.Count - 1 do

        // REGISTRO 0450: TABELA DE INFORMAÇÃO COMPLEMENTAR DO DOCUMENTO FISCAL
        { Implementado a critério do Leitor }

        // REGISTRO 0460: TABELA DE OBSERVAÇÕES DO LANÇAMENTO FISCAL
        { Implementado a critério do Leitor }

        // REGISTRO 0500: PLANO DE CONTAS CONTÁBEIS
        { Implementado a critério do Leitor }

        // REGISTRO 0600: CENTRO DE CUSTOS
        { Implementado a critério do Leitor }

      end; // with Registro0001New do
    end; // with FDataModule.ACBrSpedFiscal.Bloco_0 do
  finally
    {
    ListaUnidade.Free;
    ListaProduto.Free;
    ListaEmitente.Free;
    ListaDestinatario.Free;
    ListaParticipante.Free;
    ListaProdutoAlterado.Free;
    ListaOperacaoFiscal.Free;
    }
  end;
end;
{$EndRegion}

{$REGION 'BLOCO C: DOCUMENTOS FISCAIS I - MERCADORIAS (ICMS/IPI)'}
class procedure TSpedFiscalController.GerarBlocoC;
var
  ListaImpressora: ImpressoraController.TListaImpressoraVO;
  ListaNF2Cabecalho: NotaFiscalController.TListaNotaFiscalCabecalhoVO;
  ListaNF2CabecalhoCanceladas: NotaFiscalController.TListaNotaFiscalCabecalhoVO;
  ListaNFeCabecalho: NotaFiscalController.TListaNfeCabecalhoLimpaVO;
  ListaNFeDetalhe: NotaFiscalController.TListaNfeDetalheVO;
  ListaNFeAnalitico: TListaSpedFiscalC190VO;
  ListaCupomNFe: NotaFiscalController.TListaCupomNFeVO;
  ListaC300: TListaSpedFiscalC300VO;
  ListaC390: TListaSpedFiscalC390VO;
  ListaC321: TListaSpedFiscalC321VO;
  ListaC370: TListaSpedFiscalC370VO;
  ListaC425: TListaSpedFiscalC425VO;
  ListaC490: TListaSpedFiscalC490VO;
  ListaR02: RegistroRController.TListaR02VO;
  ListaR03: RegistroRController.TListaR03VO;
  ListaR04: RegistroRController.TListaR04VO;
  ListaR05: RegistroRController.TListaR05VO;
  i, j, k, l, m, g: Integer;
  //
  NfeTransporte: TNfeTransporteVO;
  EcfNotaFiscalCabecalho: TNotaFiscalCabecalhoVO;
  Produto: TProdutoVO;
begin
  try
    with FDataModule.ACBrSpedFiscal.Bloco_C do
    begin
      // REGISTRO C001: ABERTURA DO BLOCO C
      with RegistroC001New do
      begin
        IND_MOV := imComDados;

        ListaNF2Cabecalho := TNotaFiscalController.ConsultaNFCabecalhoSPED(DataInicial, DataFinal, 'N');
        ListaNF2CabecalhoCanceladas := TNotaFiscalController.ConsultaNFCabecalhoSPED(DataInicial, DataFinal, 'S');
        ListaNFeCabecalho := TNotaFiscalController.ConsultaNFeCabecalhoSPED(DataInicial, DataFinal);

        { Perfil A }
        if PerfilApresentacao = 0 then
        begin
          if assigned(ListaNFeCabecalho) then
          begin
            for i := 0 to ListaNFeCabecalho.Count - 1 do
            begin
              // REGISTRO C100: NOTA FISCAL (CÓDIGO 01), NOTA FISCAL AVULSA (CÓDIGO 1B), NOTA FISCAL DE PRODUTOR (CÓDIGO 04), NF-e (CÓDIGO 55) e NFC-e (CÓDIGO 65)
              with RegistroC100New do
              begin
                IND_OPER := TACBrTipoOperacao(StrToInt(TNfeCabecalhoLimpaVO(ListaNFeCabecalho.Items[i]).TipoOperacao));
                IND_EMIT := edEmissaoPropria;
                if TNfeCabecalhoLimpaVO(ListaNFeCabecalho.Items[i]).IdCliente > 0 then
                  COD_PART := 'C' + IntToStr(TNfeCabecalhoLimpaVO(ListaNFeCabecalho.Items[i]).IdCliente)
                else
                  COD_PART := 'F' + IntToStr(TNfeCabecalhoLimpaVO(ListaNFeCabecalho.Items[i]).IdFornecedor);
                COD_MOD := TNfeCabecalhoLimpaVO(ListaNFeCabecalho.Items[i]).CodigoModelo;
                if TNfeCabecalhoLimpaVO(ListaNFeCabecalho.Items[i]).StatusNota = 'E' then
                  COD_SIT := sdRegular
                else
                  COD_SIT := sdCancelado;
                SER := TNfeCabecalhoLimpaVO(ListaNFeCabecalho.Items[i]).Serie;
                NUM_DOC := TNfeCabecalhoLimpaVO(ListaNFeCabecalho.Items[i]).Numero;
                CHV_NFE := TNfeCabecalhoLimpaVO(ListaNFeCabecalho.Items[i]).ChaveAcesso;
                DT_DOC := TNfeCabecalhoLimpaVO(ListaNFeCabecalho.Items[i]).DataEmissao;
                DT_E_S := TNfeCabecalhoLimpaVO(ListaNFeCabecalho.Items[i]).DataEntradaSaida;
                VL_DOC := TNfeCabecalhoLimpaVO(ListaNFeCabecalho.Items[i]).ValorTotal;
                IND_PGTO := TACBrTipoPagamento(StrToInt(TNfeCabecalhoLimpaVO(ListaNFeCabecalho.Items[i]).IndicadorFormaPagamento));
                VL_DESC := TNfeCabecalhoLimpaVO(ListaNFeCabecalho.Items[i]).ValorDesconto;
                VL_ABAT_NT := 0;
                VL_MERC := TNfeCabecalhoLimpaVO(ListaNFeCabecalho.Items[i]).ValorTotalProdutos;
                //
                NfeTransporte := TNotaFiscalController.ConsultaNFeTransporte(TNfeCabecalhoLimpaVO(ListaNFeCabecalho.Items[i]).Id);

                if Assigned(NfeTransporte) then
                  IND_FRT := TACBrTipoFrete(StrToInt(NfeTransporte.ModalidadeFrete));

                VL_FRT := TNfeCabecalhoLimpaVO(ListaNFeCabecalho.Items[i]).ValorFrete;
                VL_SEG := TNfeCabecalhoLimpaVO(ListaNFeCabecalho.Items[i]).ValorSeguro;
                VL_OUT_DA := TNfeCabecalhoLimpaVO(ListaNFeCabecalho.Items[i]).ValorDespesasAcessorias;
                VL_BC_ICMS := TNfeCabecalhoLimpaVO(ListaNFeCabecalho.Items[i]).BaseCalculoIcms;
                VL_ICMS := TNfeCabecalhoLimpaVO(ListaNFeCabecalho.Items[i]).ValorIcms;
                VL_BC_ICMS_ST := TNfeCabecalhoLimpaVO(ListaNFeCabecalho.Items[i]).BaseCalculoIcmsSt;
                VL_ICMS_ST := TNfeCabecalhoLimpaVO(ListaNFeCabecalho.Items[i]).ValorIcmsSt;
                VL_IPI := TNfeCabecalhoLimpaVO(ListaNFeCabecalho.Items[i]).ValorIpi;
                VL_PIS := TNfeCabecalhoLimpaVO(ListaNFeCabecalho.Items[i]).ValorPis;
                VL_COFINS := TNfeCabecalhoLimpaVO(ListaNFeCabecalho.Items[i]).ValorCofins;
                VL_PIS_ST := 0;
                VL_COFINS_ST := 0;

                // REGISTRO C105: OPERAÇÕES COM ICMS ST RECOLHIDO PARA UF DIVERSA DO DESTINATÁRIO DO DOCUMENTO FISCAL (CÓDIGO 55).
                { Implementado a critério do Leitor }

                // REGISTRO C110: INFORMAÇÃO COMPLEMENTAR DA NOTA FISCAL (CÓDIGO 01, 1B, 04 e 55).
                { Implementado a critério do Leitor }

                // REGISTRO C111: PROCESSO REFERENCIADO
                { Implementado a critério do Leitor }

                // REGISTRO C112: DOCUMENTO DE ARRECADAÇÃO REFERENCIADO.
                { Implementado a critério do Leitor }

                // REGISTRO C113: DOCUMENTO FISCAL REFERENCIADO.
                { Implementado a critério do Leitor }

                // REGISTRO C114: CUPOM FISCAL REFERENCIADO
                ListaCupomNFe := TNotaFiscalController.ConsultaNFeCupom(TNfeCabecalhoLimpaVO(ListaNFeCabecalho.Items[i]).Id);
                if assigned(ListaCupomNFe) then
                begin
                  for j := 0 to ListaCupomNFe.Count - 1 do
                  begin
                    with RegistroC114New do
                    begin
                      COD_MOD := TNfeCupomFiscalReferenciadoVO(ListaCupomNFe.Items[j]).ModeloDocumentoFiscal;
                      ECF_FAB := TNfeCupomFiscalReferenciadoVO(ListaCupomNFe.Items[j]).NumeroSerieEcf;
                      ECF_CX := IntToStr(TNfeCupomFiscalReferenciadoVO(ListaCupomNFe.Items[j]).NumeroCaixa);
                      NUM_DOC := IntToStr(TNfeCupomFiscalReferenciadoVO(ListaCupomNFe.Items[j]).Coo);
                      DT_DOC := TNfeCupomFiscalReferenciadoVO(ListaCupomNFe.Items[j]).DataEmissaoCupom;
                    end; // with RegistroC114New do
                  end; // for j := 0 to ListaCupomNFe.Count - 1 do
                end; // if Assigned(ListaCupomNFe) then

                // REGISTRO C115: LOCAL DA COLETA E/OU ENTREGA (CÓDIGO 01, 1B E 04).
                { Implementado a critério do Leitor }

                // REGISTRO C116: CUPOM FISCAL ELETRÔNICO REFERENCIADO
                { Implementado a critério do Leitor }

                // REGISTRO C120: COMPLEMENTO DE DOCUMENTO - OPERAÇÕES DE IMPORTAÇÃO (CÓDIGOS 01 e 55).
                { Implementado a critério do Leitor }

                // REGISTRO C130: ISSQN, IRRF E PREVIDÊNCIA SOCIAL.
                { Implementado a critério do Leitor }

                // REGISTRO C140: FATURA (CÓDIGO 01)
                { Implementado a critério do Leitor }

                // REGISTRO C141: VENCIMENTO DA FATURA (CÓDIGO 01).
                { Implementado a critério do Leitor }

                // REGISTRO C160: VOLUMES TRANSPORTADOS (CÓDIGO 01 E 04) - EXCETO COMBUSTÍVEIS.
                { Implementado a critério do Leitor }

                // REGISTRO C165: OPERAÇÕES COM COMBUSTÍVEIS (CÓDIGO 01).
                { Implementado a critério do Leitor }

                // REGISTRO C170: ITENS DO DOCUMENTO (CÓDIGO 01, 1B, 04 e 55).
                ListaNFeDetalhe := TNotaFiscalController.ConsultaNFeDetalhe(TNfeCabecalhoLimpaVO(ListaNFeCabecalho.Items[i]).Id);
                if assigned(ListaNFeDetalhe) then
                begin
                  for j := 0 to ListaNFeDetalhe.Count - 1 do
                  begin
                    with RegistroC170New do
                    begin
                      NUM_ITEM := IntToStr(TViewSpedNfeDetalheVO(ListaNFeDetalhe.Items[j]).NumeroItem);
                      COD_ITEM := TViewSpedNfeDetalheVO(ListaNFeDetalhe.Items[j]).Gtin;
                      DESCR_COMPL := TViewSpedNfeDetalheVO(ListaNFeDetalhe.Items[j]).NomeProduto;
                      QTD := TViewSpedNfeDetalheVO(ListaNFeDetalhe.Items[j]).QuantidadeComercial;
                      UNID := IntToStr(TViewSpedNfeDetalheVO(ListaNFeDetalhe.Items[j]).IdUnidadeProduto);
                      VL_ITEM := TViewSpedNfeDetalheVO(ListaNFeDetalhe.Items[j]).ValorTotal;
                      VL_DESC := TViewSpedNfeDetalheVO(ListaNFeDetalhe.Items[j]).ValorDesconto;
                      IND_MOV := mfSim;
                      CST_ICMS := TViewSpedNfeDetalheVO(ListaNFeDetalhe.Items[j]).CstIcms;
                      CFOP := IntToStr(TViewSpedNfeDetalheVO(ListaNFeDetalhe.Items[j]).Cfop);
                      COD_NAT := IntToStr(TViewSpedNfeDetalheVO(ListaNFeDetalhe.Items[j]).IdTributOperacaoFiscal);
                      VL_BC_ICMS := TViewSpedNfeDetalheVO(ListaNFeDetalhe.Items[j]).BaseCalculoIcms;
                      ALIQ_ICMS := TViewSpedNfeDetalheVO(ListaNFeDetalhe.Items[j]).AliquotaIcms;
                      VL_ICMS := TViewSpedNfeDetalheVO(ListaNFeDetalhe.Items[j]).ValorIcms;
                      VL_BC_ICMS_ST := TViewSpedNfeDetalheVO(ListaNFeDetalhe.Items[j]).ValorBaseCalculoIcmsSt;
                      ALIQ_ST := TViewSpedNfeDetalheVO(ListaNFeDetalhe.Items[j]).AliquotaIcmsSt;
                      VL_ICMS_ST := TViewSpedNfeDetalheVO(ListaNFeDetalhe.Items[j]).ValorIcmsSt;
                      IND_APUR := iaMensal;
                      CST_IPI := TViewSpedNfeDetalheVO(ListaNFeDetalhe.Items[j]).CstIpi;
                      COD_ENQ := TViewSpedNfeDetalheVO(ListaNFeDetalhe.Items[j]).EnquadramentoIpi;
                      VL_BC_IPI := TViewSpedNfeDetalheVO(ListaNFeDetalhe.Items[j]).ValorBaseCalculoIpi;
                      ALIQ_IPI := TViewSpedNfeDetalheVO(ListaNFeDetalhe.Items[j]).AliquotaIpi;
                      VL_IPI := TViewSpedNfeDetalheVO(ListaNFeDetalhe.Items[j]).ValorIpi;
                      CST_PIS := TViewSpedNfeDetalheVO(ListaNFeDetalhe.Items[j]).CstPis;
                      VL_BC_PIS := TViewSpedNfeDetalheVO(ListaNFeDetalhe.Items[j]).ValorBaseCalculoPis;
                      ALIQ_PIS_PERC := TViewSpedNfeDetalheVO(ListaNFeDetalhe.Items[j]).AliquotaPisPercentual;
                      QUANT_BC_PIS := TViewSpedNfeDetalheVO(ListaNFeDetalhe.Items[j]).QuantidadeVendidaPis;
                      ALIQ_PIS_R := TViewSpedNfeDetalheVO(ListaNFeDetalhe.Items[j]).AliquotaPisReais;
                      VL_PIS := TViewSpedNfeDetalheVO(ListaNFeDetalhe.Items[j]).ValorPis;
                      CST_COFINS := TViewSpedNfeDetalheVO(ListaNFeDetalhe.Items[j]).CstCofins;
                      VL_BC_COFINS := TViewSpedNfeDetalheVO(ListaNFeDetalhe.Items[j]).BaseCalculoCofins;
                      ALIQ_COFINS_PERC := TViewSpedNfeDetalheVO(ListaNFeDetalhe.Items[j]).AliquotaCofinsPercentual;
                      QUANT_BC_COFINS := TViewSpedNfeDetalheVO(ListaNFeDetalhe.Items[j]).QuantidadeVendidaCofins;
                      ALIQ_COFINS_R := TViewSpedNfeDetalheVO(ListaNFeDetalhe.Items[j]).AliquotaCofinsReais;
                      VL_COFINS := TViewSpedNfeDetalheVO(ListaNFeDetalhe.Items[j]).ValorCofins;
                      COD_CTA := '';
                    end; // with RegistroC170New do
                  end; // for j := 0 to ListaNFeDetalhe.Count - 1 do
                end; // if Assigned(ListaNFeDetalhe) then

                // REGISTRO C171: ARMAZENAMENTO DE COMBUSTIVEIS (código 01, 55).
                { Implementado a critério do Leitor }

                // REGISTRO C172: OPERAÇÕES COM ISSQN (CÓDIGO 01)
                { Implementado a critério do Leitor }

                // REGISTRO C173: OPERAÇÕES COM MEDICAMENTOS (CÓDIGO 01 e 55).
                { Implementado a critério do Leitor }

                // REGISTRO C174: OPERAÇÕES COM ARMAS DE FOGO (CÓDIGO 01).
                { Implementado a critério do Leitor }

                // REGISTRO C175: OPERAÇÕES COM VEÍCULOS NOVOS (CÓDIGO 01 e 55).
                { Implementado a critério do Leitor }

                // REGISTRO C176: RESSARCIMENTO DE ICMS EM OPERAÇÕES COM SUBSTITUIÇÃO TRIBUTÁRIA (CÓDIGO 01, 55).
                { Implementado a critério do Leitor }

                // REGISTRO C177: OPERAÇÕES COM PRODUTOS SUJEITOS A SELO DE CONTROLE IPI.
                { Implementado a critério do Leitor }

                // REGISTRO C178: OPERAÇÕES COM PRODUTOS SUJEITOS À TRIBUTAÇÀO DE IPI POR UNIDADE OU QUANTIDADE DE PRODUTO.
                { Implementado a critério do Leitor }

                // REGISTRO C179: INFORMAÇÕES COMPLEMENTARES ST (CÓDIGO 01).
                { Implementado a critério do Leitor }

                // REGISTRO C190: REGISTRO ANALÍTICO DO DOCUMENTO (CÓDIGO 01, 1B, 04 ,55 e 65).
                ListaNFeAnalitico := TabelaC190(TNfeCabecalhoLimpaVO(ListaNFeCabecalho.Items[i]).Id);
                if assigned(ListaNFeAnalitico) then
                begin
                  for j := 0 to ListaNFeAnalitico.Count - 1 do
                  begin
                    with RegistroC190New do
                    begin
                      CST_ICMS := TViewSpedC190VO(ListaNFeAnalitico.Items[j]).CstIcms;
                      CFOP := IntToStr(TViewSpedC190VO(ListaNFeAnalitico.Items[j]).CFOP);
                      ALIQ_ICMS := TViewSpedC190VO(ListaNFeAnalitico.Items[j]).AliquotaICMS;
                      VL_OPR := TViewSpedC190VO(ListaNFeAnalitico.Items[j]).SomaValorOperacao;
                      VL_BC_ICMS := TViewSpedC190VO(ListaNFeAnalitico.Items[j]).SomaBaseCalculoIcms;
                      VL_ICMS := TViewSpedC190VO(ListaNFeAnalitico.Items[j]).SomaValorIcms;
                      VL_BC_ICMS_ST := TViewSpedC190VO(ListaNFeAnalitico.Items[j]).SomaBaseCalculoIcmsSt;
                      VL_ICMS_ST := TViewSpedC190VO(ListaNFeAnalitico.Items[j]).SomaValorIcmsSt;
                      VL_RED_BC := TViewSpedC190VO(ListaNFeAnalitico.Items[j]).SomaVlRedBc;
                      VL_IPI := TViewSpedC190VO(ListaNFeAnalitico.Items[j]).SomaValorIpi;
                      COD_OBS := '';
                    end; // with RegistroC190New do
                  end; // for j := 0 to ListaNFeAnalitico.Count - 1 do
                end; // if Assigned(ListaNFeAnalitico) then

                // REGISTRO C195: OBSERVAÇOES DO LANÇAMENTO FISCAL (CÓDIGO 01, 1B E 55)
                { Implementado a critério do Leitor }

                // REGISTRO C197: OUTRAS OBRIGAÇÕES TRIBUTÁRIAS, AJUSTES E INFORMAÇÕES DE VALORES PROVENIENTES DE DOCUMENTO FISCAL.
                { Implementado a critério do Leitor }

              end; // with RegistroC100New do
            end; // for i := 0 to ListaNFeCabecalho.Count - 1 do
          end; // if Assigned(ListaNFeCabecalho) then

          if assigned(ListaNF2Cabecalho) then
          begin
            for i := 0 to ListaNF2Cabecalho.Count - 1 do
            begin
              // REGISTRO C350: NOTA FISCAL DE VENDA A CONSUMIDOR (CÓDIGO 02)
              with RegistroC350New do
              begin
                SER := TNotaFiscalCabecalhoVO(ListaNF2Cabecalho.Items[i]).Serie;
                SUB_SER := TNotaFiscalCabecalhoVO(ListaNF2Cabecalho.Items[i]).SubSerie;
                NUM_DOC := TNotaFiscalCabecalhoVO(ListaNF2Cabecalho.Items[i]).Numero;
                DT_DOC := TNotaFiscalCabecalhoVO(ListaNF2Cabecalho.Items[i]).DataEmissao;
                CNPJ_CPF := TNotaFiscalCabecalhoVO(ListaNF2Cabecalho.Items[i]).CpfCnpjCliente;
                VL_MERC := TNotaFiscalCabecalhoVO(ListaNF2Cabecalho.Items[i]).TotalProdutos;
                VL_DOC := TNotaFiscalCabecalhoVO(ListaNF2Cabecalho.Items[i]).TotalNF;
                VL_DESC := TNotaFiscalCabecalhoVO(ListaNF2Cabecalho.Items[i]).Desconto;
                VL_PIS := TNotaFiscalCabecalhoVO(ListaNF2Cabecalho.Items[i]).PIS;
                VL_COFINS := TNotaFiscalCabecalhoVO(ListaNF2Cabecalho.Items[i]).COFINS;
                COD_CTA := '';

                // REGISTRO C370: ITENS DO DOCUMENTO (CÓDIGO 02)
                ListaC370 := TabelaC370;
                if assigned(ListaC370) then
                begin
                  for j := 0 to ListaC370.Count - 1 do
                  begin
                    with RegistroC370New do
                    begin
                      NUM_ITEM := IntToStr(TViewSpedC370VO(ListaC370.Items[j]).Item);
                      COD_ITEM := IntToStr(TViewSpedC370VO(ListaC370.Items[j]).IdProduto);
                      QTD := TViewSpedC370VO(ListaC370.Items[j]).Quantidade;
                      UNID := IntToStr(TViewSpedC370VO(ListaC370.Items[j]).IdUnidadeProduto);
                      VL_ITEM := TViewSpedC370VO(ListaC370.Items[j]).ValorTotal;
                      VL_DESC := TViewSpedC370VO(ListaC370.Items[j]).Desconto;
                    end; // with RegistroC370New do
                  end; // for j := 0 to ListaNF2Detalhe.Count - 1 do
                end; // if Assigned(ListaNF2Detalhe) then
                // end;//with RegistroC350New do

                // REGISTRO C390: REGISTRO ANALÍTICO DAS NOTAS FISCAIS DE VENDA A CONSUMIDOR (CÓDIGO 02)
                ListaC390 := TabelaC390;
                if assigned(ListaC390) then
                begin
                  for l := 0 to ListaC390.Count - 1 do
                  begin
                    with RegistroC390New do
                    begin
                      CST_ICMS := TViewSpedC390VO(ListaC390.Items[l]).CST;
                      CFOP := IntToStr(TViewSpedC390VO(ListaC390.Items[l]).CFOP);
                      ALIQ_ICMS := TViewSpedC390VO(ListaC390.Items[l]).TaxaICMS;
                      VL_OPR := TViewSpedC390VO(ListaC390.Items[l]).SomaItem;
                      VL_BC_ICMS := TViewSpedC390VO(ListaC390.Items[l]).SomaBaseICMS;
                      VL_ICMS := TViewSpedC390VO(ListaC390.Items[l]).SomaICMS;
                      VL_RED_BC := TViewSpedC390VO(ListaC390.Items[l]).SomaICMSOutras;
                    end; // with RegistroC390New do
                  end; // for i := 0 to ListaC390.Count - 1 do
                end; // if Assigned(ListaC390) then
              end; // with RegistroC350New do
            end; // for i := 0 to ListaNF2Cabecalho.Count - 1 do
          end; // if Assigned(ListaNF2Cabecalho) then

        end; // if PerfilApresentacao = 0 then (Perfil A)


        { Perfil B }
        if PerfilApresentacao = 1 then
        begin
          // REGISTRO C300: RESUMO DIÁRIO DAS NOTAS FISCAIS DE VENDA A CONSUMIDOR (CÓDIGO 02)
          ListaC300 := TabelaC300;
          if assigned(ListaC300) then
          begin
            for i := 0 to ListaC300.Count - 1 do
            begin
              with RegistroC300New do
              begin
                COD_MOD := '2';
                SER := TViewSpedC300VO(ListaC300.Items[i]).Serie;
                SUB := TViewSpedC300VO(ListaC300.Items[i]).Subserie;

                //Filtro := 'SERIE = ' + SER + 'SUBSERIE = ' + SUB + ' and (DATA_EMISSAO BETWEEN ' + QuotedStr(DataInicial) + ' and ' + QuotedStr(DataFinal) + ')';
                { TODO -oLeitor : Use o filtro acima para pegar o primeiro e o ultimo numero das notas do período }
                EcfNotaFiscalCabecalho := TNotaFiscalCabecalhoVO.Create;
                EcfNotaFiscalCabecalho.Numero := '1';
                NUM_DOC_INI := EcfNotaFiscalCabecalho.Numero;
                EcfNotaFiscalCabecalho.Numero := '100';
                NUM_DOC_FIN := EcfNotaFiscalCabecalho.Numero;

                DT_DOC := TViewSpedC300VO(ListaC300.Items[i]).DataEmissao;
                VL_DOC := TViewSpedC300VO(ListaC300.Items[i]).SomaTotalNf;
                VL_PIS := TViewSpedC300VO(ListaC300.Items[i]).SomaPis;
                VL_COFINS := TViewSpedC300VO(ListaC300.Items[i]).SomaCofins;
              end; // with RegistroC300New do
            end; // for i := 0 to ListaC300.Count - 1 do
          end; // if assigned(ListaC300) then

          // REGISTRO C310: DOCUMENTOS CANCELADOS DE NOTAS FISCAIS DE VENDA A CONSUMIDOR (CÓDIGO 02).
          if assigned(ListaNF2CabecalhoCanceladas) then
          begin
            for i := 0 to ListaNF2CabecalhoCanceladas.Count - 1 do
            begin
              with RegistroC310New do
              begin
                NUM_DOC_CANC := TNotaFiscalCabecalhoVO(ListaNF2CabecalhoCanceladas.Items[i]).Numero;
              end; // with RegistroC310New do
            end; // for i := 0 to ListaNF2CabecalhoCanceladas.Count - 1 do
          end; // if Assigned(ListaNF2CabecalhoCanceladas) then

          // REGISTRO C320: REGISTRO ANALÍTICO DO RESUMO DIÁRIO DAS NOTAS FISCAIS DE VENDA A CONSUMIDOR (CÓDIGO 02). ---> igual ao C390
          ListaC390 := TabelaC390;
          if assigned(ListaC390) then
          begin
            for i := 0 to ListaC390.Count - 1 do
            begin
              with RegistroC320New do
              begin
                CST_ICMS := TViewSpedC390VO(ListaC390.Items[i]).CST;
                CFOP := IntToStr(TViewSpedC390VO(ListaC390.Items[i]).CFOP);
                ALIQ_ICMS := TViewSpedC390VO(ListaC390.Items[i]).TaxaICMS;
                VL_OPR := TViewSpedC390VO(ListaC390.Items[i]).SomaItem;
                VL_BC_ICMS := TViewSpedC390VO(ListaC390.Items[i]).SomaBaseICMS;
                VL_ICMS := TViewSpedC390VO(ListaC390.Items[i]).SomaICMS;
                VL_RED_BC := TViewSpedC390VO(ListaC390.Items[i]).SomaICMSOutras;
              end; // with RegistroC320New do
            end; // for i := 0 to ListaC390.Count - 1 do
          end; // if Assigned(ListaC390) then

          // REGISTRO C321: ITENS DO RESUMO DIÁRIO DOS DOCUMENTOS (CÓDIGO 02).
          ListaC321 := TabelaC321;
          if assigned(ListaC321) then
          begin
            for i := 0 to ListaC321.Count - 1 do
            begin
              with RegistroC321New do
              begin
                COD_ITEM := IntToStr(TViewSpedC321VO(ListaC321.Items[i]).IdProduto);
                QTD := TViewSpedC321VO(ListaC321.Items[i]).SomaQuantidade;
                UNID := TViewSpedC321VO(ListaC321.Items[i]).DescricaoUnidade;
                VL_ITEM := TViewSpedC321VO(ListaC321.Items[i]).SomaItem;
                VL_DESC := TViewSpedC321VO(ListaC321.Items[i]).SomaDesconto;
                VL_BC_ICMS := TViewSpedC321VO(ListaC321.Items[i]).SomaBaseICMS;
                VL_ICMS := TViewSpedC321VO(ListaC321.Items[i]).SomaICMS;
                VL_PIS := TViewSpedC321VO(ListaC321.Items[i]).SomaPIS;
                VL_COFINS := TViewSpedC321VO(ListaC321.Items[i]).SomaCOFINS;
              end; // with RegistroC321New do
            end; // for i := 0 to ListaC321.Count - 1 do
          end; // if Assigned(ListaC321) then

        end; // if PerfilApresentacao = 1 then (Perfil B)


        { Ambos os Perfis  }
        ListaImpressora := TImpressoraController.TabelaImpressora;
        if assigned(ListaImpressora) then
        begin
          for i := 0 to ListaImpressora.Count - 1 do
          begin
            // REGISTRO C400: EQUIPAMENTO ECF (CÓDIGO 02, 2D e 60).
            with RegistroC400New do
            begin
              COD_MOD := TImpressoraVO(ListaImpressora.Items[i]).ModeloDocumentoFiscal;
              ECF_MOD := TImpressoraVO(ListaImpressora.Items[i]).Modelo;
              ECF_FAB := TImpressoraVO(ListaImpressora.Items[i]).Serie;
              ECF_CX := IntToStr(TImpressoraVO(ListaImpressora.Items[i]).Numero);

              // verifica se existe movimento no periodo para aquele ECF
              ListaR02 := TRegistroRController.TabelaR02(DataInicial, DataFinal, TImpressoraVO(ListaImpressora.Items[i]).Id);
              if assigned(ListaR02) then
              begin
                for j := 0 to ListaR02.Count - 1 do
                begin
                  // REGISTRO C405: REDUÇÃO Z (CÓDIGO 02, 2D e 60).
                  with RegistroC405New do
                  begin
                    DT_DOC := TR02VO(ListaR02.Items[j]).DataMovimento;
                    CRO := TR02VO(ListaR02.Items[j]).CRO;
                    CRZ := TR02VO(ListaR02.Items[j]).CRZ;
                    NUM_COO_FIN := TR02VO(ListaR02.Items[j]).Coo;
                    GT_FIN := TR02VO(ListaR02.Items[j]).GrandeTotal;
                    VL_BRT := TR02VO(ListaR02.Items[j]).VendaBruta;

                    // REGISTRO C410: PIS E COFINS TOTALIZADOS NO DIA (CÓDIGO 02 e 2D).
                    { Implementado a critério do Leitor }

                    ListaR03 := TRegistroRController.TabelaR03(TR02VO(ListaR02.Items[j]).Id);
                    if assigned(ListaR03) then
                    begin
                      for k := 0 to ListaR03.Count - 1 do
                      begin
                        // REGISTRO C420: REGISTRO DOS TOTALIZADORES PARCIAIS DA REDUÇÃO Z (COD 02, 2D e 60).
                        with RegistroC420New do
                        begin
                          if length(TR03VO(ListaR03.Items[k]).TotalizadorParcial) = 8 then //T01T1700
                            COD_TOT_PAR := Copy(TR03VO(ListaR03.Items[k]).TotalizadorParcial, 2, length(TR03VO(ListaR03.Items[k]).TotalizadorParcial))
                          else
                            COD_TOT_PAR := TR03VO(ListaR03.Items[k]).TotalizadorParcial;
                          VLR_ACUM_TOT := TR03VO(ListaR03.Items[k]).ValorAcumulado;
                          if length(trim(COD_TOT_PAR)) = 7 then
                            NR_TOT := StrToInt(Copy(COD_TOT_PAR, 1, 2))
                          else
                            NR_TOT := 0;
                        end; // with RegistroC420New do

                        if PerfilApresentacao = 1 then
                        begin
                          // REGISTRO C425: RESUMO DE ITENS DO MOVIMENTO DIÁRIO (CÓDIGO 02 e 2D).
                          ListaC425 := TabelaC425;
                          if assigned(ListaC425) then
                          begin
                            for l := 0 to ListaC425.Count - 1 do
                            begin
                              with RegistroC425New do
                              begin
                                COD_ITEM := IntToStr(TViewSpedC425VO(ListaC425.Items[l]).IdEcfProduto);
                                UNID := TViewSpedC425VO(ListaC425.Items[l]).DescricaoUnidade;
                                QTD := TViewSpedC425VO(ListaC425.Items[l]).SomaQuantidade;
                                VL_ITEM := TViewSpedC425VO(ListaC425.Items[l]).SomaItem;
                                VL_PIS := TViewSpedC425VO(ListaC425.Items[l]).SomaPIS;
                                VL_COFINS := TViewSpedC425VO(ListaC425.Items[l]).SomaCOFINS;
                              end; // with RegistroC425New do
                            end; // for l := 0 to ListaC425.Count - 1 do
                          end; // if Assigned(ListaC425) then
                        end; // if PerfilApresentacao = 1 then
                      end; // for k := 0 to ListaR03.Count - 1 do
                    end; // if Assigned(ListaR03) then

                    // se tiver o perfil A, gera o C460 com C470
                    if PerfilApresentacao = 0 then
                    begin
                      ListaR04 := TRegistroRController.TabelaR04(TR02VO(ListaR02.Items[j]).DataMovimento, TR02VO(ListaR02.Items[j]).DataMovimento);
                      if assigned(ListaR04) then
                      begin
                        for l := 0 to ListaR04.Count - 1 do
                        begin
                          // REGISTRO C460: DOCUMENTO FISCAL EMITIDO POR ECF (CÓDIGO 02, 2D e 60).
                          with RegistroC460New do
                          begin
                            COD_MOD := '2D';
                            if TR04VO(ListaR04.Items[l]).StatusVenda = 'C' then
                              COD_SIT := sdCancelado
                            else
                              COD_SIT := sdRegular;

                            if COD_SIT = sdRegular then
                            begin
                              DT_DOC := TR04VO(ListaR04.Items[l]).DataVenda;
                              VL_DOC := TR04VO(ListaR04.Items[l]).ValorLiquido;
                              VL_PIS := TR04VO(ListaR04.Items[l]).PIS;
                              VL_PIS := TR04VO(ListaR04.Items[l]).COFINS;
                              CPF_CNPJ := TR04VO(ListaR04.Items[l]).CPFCNPJ;
                              NOM_ADQ := TR04VO(ListaR04.Items[l]).Cliente;
                            end; // if COD_SIT = sdRegular then

                            NUM_DOC := IntToStr(TR04VO(ListaR04.Items[l]).Coo);

                            // REGISTRO C465: COMPLEMENTO DO CUPOM FISCAL ELETRÔNICO EMITIDO POR ECF – CF-e-ECF (CÓDIGO 60).
                            { Implementado a critério do Leitor }

                            if COD_SIT = sdRegular then
                            begin
                              // REGISTRO C470: ITENS DO DOCUMENTO FISCAL EMITIDO POR ECF (CÓDIGO 02 e 2D).
                              ListaR05 := TRegistroRController.TabelaR05(TR04VO(ListaR04.Items[l]).Id);
                              if assigned(ListaR05) then
                              begin
                                for m := 0 to ListaR05.Count - 1 do
                                begin
                                  with RegistroC470New do
                                  begin
                                    COD_MOD := '2D';
                                    COD_ITEM := IntToStr(TR05VO(ListaR05.Items[m]).IdProduto);
                                    QTD := TR05VO(ListaR05.Items[m]).Quantidade;
                                    Produto := TProdutoController.ConsultaId(TR05VO(ListaR05.Items[m]).IdProduto);
                                    UNID := IntToStr(Produto.IdUnidade);
                                    VL_ITEM := TR05VO(ListaR05.Items[m]).TotalItem;
                                    CST_ICMS := TR05VO(ListaR05.Items[m]).CST;
                                    CFOP := IntToStr(TR05VO(ListaR05.Items[m]).CFOP);
                                    ALIQ_ICMS := TR05VO(ListaR05.Items[m]).AliquotaICMS;
                                    VL_PIS := TR05VO(ListaR05.Items[m]).PIS;
                                    VL_COFINS := TR05VO(ListaR05.Items[m]).COFINS;
                                  end; // with RegistroC470New do
                                end; // for m := 0 to ListaR05.Count - 1 do
                              end; // if Assigned(ListaR05) then
                            end; // if COD_SIT = sdRegular then
                          end; // with RegistroC460New do
                        end; // for l := 0 to ListaR04.Count - 1 do
                      end; // if Assigned(ListaR04) then
                    end; // if PerfilApresentacao = 0 then

                    // REGISTRO C490: REGISTRO ANALÍTICO DO MOVIMENTO DIÁRIO (CÓDIGO 02, 2D e 60).
                    ListaC490 := TabelaC490;
                    if assigned(ListaC490) then
                    begin
                      for g := 0 to ListaC490.Count - 1 do
                      begin
                        with RegistroC490New do
                        begin
                          CST_ICMS := TViewSpedC490VO(ListaC490.Items[g]).CST;
                          CFOP := IntToStr(TViewSpedC490VO(ListaC490.Items[g]).CFOP);
                          ALIQ_ICMS := TViewSpedC490VO(ListaC490.Items[g]).TaxaICMS;
                          VL_OPR := TViewSpedC490VO(ListaC490.Items[g]).SomaItem;
                          VL_BC_ICMS := TViewSpedC490VO(ListaC490.Items[g]).SomaBaseICMS;
                          VL_ICMS := TViewSpedC490VO(ListaC490.Items[g]).SomaICMS;
                        end; // with RegistroC490New do
                      end; // for g := 0 to ListaC490.Count - 1 do
                    end; // if Assigned(ListaC490) then

                    // REGISTRO C495: RESUMO MENSAL DE ITENS DO ECF POR ESTABELECIMENTO (CÓDIGO 02 e 2D).
                    { Implementado a critério do Leitor }

                  end; // with RegistroC405New do
                end; // for j := 0 to ListaR02.Count - 1 do
              end; // if Assigned(ListaR02) then
            end; // with RegistroC400New do
          end; // for i := 0 to ListaImpressora.Count - 1 do
        end; // if Assigned(ListaImpressora) then


        // REGISTRO C500: NOTA FISCAL/CONTA DE ENERGIA ELÉTRICA (CÓDIGO 06), NOTA FISCAL/CONTA DE FORNECIMENTO D'ÁGUA CANALIZADA (CÓDIGO 29) E NOTA FISCAL CONSUMO FORNECIMENTO DE GÁS (CÓDIGO 28).
        // REGISTRO C510: ITENS DO DOCUMENTO NOTA FISCAL/CONTA ENERGIA ELÉTRICA (CÓDIGO 06), NOTA FISCAL/CONTA DE FORNECIMENTO D'ÁGUA CANALIZADA (CÓDIGO 29) E NOTA FISCAL/CONTA DE FORNECIMENTO DE GÁS (CÓDIGO 28).
        // REGISTRO C590: REGISTRO ANALÍTICO DO DOCUMENTO - NOTA FISCAL/CONTA DE ENERGIA ELÉTRICA (CÓDIGO 06), NOTA FISCAL/CONTA DE FORNECIMENTO D'ÁGUA CANALIZADA (CÓDIGO 29) E NOTA FISCAL CONSUMO FORNECIMENTO DE GÁS (CÓDIGO 28).
        // REGISTRO C600: CONSOLIDAÇÃO DIÁRIA DE NOTAS FISCAIS/CONTAS DE ENERGIA ELÉTRICA (CÓDIGO 06), NOTA FISCAL/CONTA DE FORNECIMENTO D'ÁGUA CANALIZADA (CÓDIGO 29) E NOTA FISCAL/CONTA DE FORNECIMENTO DE GÁS (CÓDIGO 28) (EMPRESAS NÃO OBRIGADAS AO CONVÊNIO ICMS 115/03).
        // REGISTRO C601: DOCUMENTOS CANCELADOS - CONSOLIDAÇÃO DIÁRIA DE NOTAS FISCAIS/CONTAS DE ENERGIA ELÉTRICA (CÓDIGO 06), NOTA FISCAL/CONTA DE FORNECIMENTO D'ÁGUA CANALIZADA (CÓDIGO 29) E NOTA FISCAL/CONTA DE FORNECIMENTO DE GÁS (CÓDIGO 28)
        // REGISTRO C610: ITENS DO DOCUMENTO CONSOLIDADO (CÓDIGO 06), NOTA FISCAL/CONTA DE FORNECIMENTO D'ÁGUA CANALIZADA (CÓDIGO 29) E NOTA FISCAL/CONTA DE FORNECIMENTO DE GÁS (CÓDIGO 28) (EMPRESAS NÃO OBRIGADAS AO CONVÊNIO ICMS 115/03).
        // REGISTRO C690: REGISTRO ANALÍTICO DOS DOCUMENTOS (NOTAS FISCAIS/CONTAS DE ENERGIA ELÉTRICA (CÓDIGO 06), NOTA FISCAL/CONTA DE FORNECIMENTO D’ÁGUA CANALIZADA (CÓDIGO 29) E NOTA FISCAL/CONTA DE FORNECIMENTO DE GÁS (CÓDIGO 28)
        // REGISTRO C700: CONSOLIDAÇÃO DOS DOCUMENTOS NF/CONTA ENERGIA ELÉTRICA (CÓD 06), EMITIDAS EM VIA ÚNICA (EMPRESAS OBRIGADAS À ENTREGA DO ARQUIVO PREVISTO NO CONVÊNIO ICMS 115/03) E NOTA FISCAL/CONTA DE FORNECIMENTO DE GÁS CANALIZADO (CÓDIGO 28)
        // REGISTRO C790: REGISTRO ANALÍTICO DOS DOCUMENTOS (CÓDIGOS 06 e 28).
        // REGISTRO C791: REGISTRO DE INFORMAÇÕES DE ST POR UF (COD 06)
        // REGISTRO C800: CUPOM FISCAL ELETRÔNICO (CÓDIGO 59)
        // REGISTRO C850: REGISTRO ANALÍTICO DO CF-E (CODIGO 59)
        // REGISTRO C860: IDENTIFICAÇÃO DO EQUIPAMENTO SAT-CF-E
        // REGISTRO C890: RESUMO DIÁRIO DO CF-E (CÓDIGO 59) POR EQUIPAMENTO SATCF-E
        { Implementados a critério do Leitor }


      end; // with RegistroC001New do
    end; // with FDataModule.ACBrSpedFiscal.Bloco_C do
  finally
    {
    ListaImpressora.Free;
    ListaNF2Cabecalho.Free;
    ListaNF2CabecalhoCanceladas.Free;
    ListaNFeCabecalho.Free;
    ListaNFeDetalhe.Free;
    ListaNFeAnalitico.Free;
    ListaCupomNFe.Free;
    ListaC300.Free;
    ListaC390.Free;
    ListaC321.Free;
    ListaC370.Free;
    ListaC425.Free;
    ListaC490.Free;
    ListaR02.Free;
    ListaR03.Free;
    ListaR04.Free;
    ListaR05.Free;
    }
  end;
end;
{$ENDREGION}

{$REGION 'BLOCO E: APURAÇÃO DO ICMS E DO IPI'}
class procedure TSpedFiscalController.GerarBlocoE;
var
  i: Integer;
  ApuracaoIcms: TFiscalApuracaoIcmsVO;
begin
  with FDataModule.ACBrSpedFiscal.Bloco_E do
  begin
    // REGISTRO E001: ABERTURA DO BLOCO E
    with RegistroE001New do
    begin
      IND_MOV := imComDados;

      // REGISTRO E100: PERÍODO DA APURAÇÃO DO ICMS.
      with RegistroE100New do
      begin
        DT_INI := TextoParaData(DataInicial);
        DT_FIN := TextoParaData(DataFinal);
      end;
    end; // with RegistroE100New do

    // REGISTRO E110: APURAÇÃO DO ICMS – OPERAÇÕES PRÓPRIAS.
    ApuracaoIcms := TabelaE110;
    if assigned(ApuracaoIcms) then
    begin
      with RegistroE110New do
      begin
        VL_TOT_DEBITOS := ApuracaoIcms.ValorTotalDebito;
        VL_AJ_DEBITOS := ApuracaoIcms.ValorAjusteDebito;
        VL_TOT_AJ_DEBITOS := ApuracaoIcms.ValorTotalAjusteDebito;
        VL_ESTORNOS_CRED := ApuracaoIcms.ValorEstornoCredito;
        VL_TOT_CREDITOS := ApuracaoIcms.ValorTotalCredito;
        VL_AJ_CREDITOS := ApuracaoIcms.ValorAjusteCredito;
        VL_TOT_AJ_CREDITOS := ApuracaoIcms.ValorTotalAjusteCredito;
        VL_ESTORNOS_DEB := ApuracaoIcms.ValorEstornoDebito;
        VL_SLD_CREDOR_ANT := ApuracaoIcms.ValorSaldoCredorAnterior;
        VL_SLD_APURADO := ApuracaoIcms.ValorSaldoApurado;
        VL_TOT_DED := ApuracaoIcms.ValorTotalDeducao;
        VL_ICMS_RECOLHER := ApuracaoIcms.ValorIcmsRecolher;
        VL_SLD_CREDOR_TRANSPORTAR := ApuracaoIcms.ValorSaldoCredorTransp;
        DEB_ESP := ApuracaoIcms.ValorDebitoEspecial;

        with RegistroE116New do
        begin
          COD_OR := '000';
          VL_OR := ApuracaoIcms.ValorIcmsRecolher;
          DT_VCTO := TextoParaData(DataFinal);
          COD_REC := '1';
          NUM_PROC := '';
          IND_PROC := opNenhum;
          PROC := '';
          TXT_COMPL := '';
          MES_REF := '';
        end; // with RegistroE116New do
      end; // with RegistroE110New do
    end; // if Assigned(ListaE110) then
  end; // with FDataModule.ACBrSpedFiscal.Bloco_E do
end; // with FDataModule.ACBrSpedFiscal.Bloco_E do
{$ENDREGION}

{$REGION 'BLOCO H: INVENTÁRIO FÍSICO'}
class procedure TSpedFiscalController.GerarBlocoH;
var
  ListaProduto: ProdutoController.TListaProdutoVO;
  i: Integer;
  TotalGeral: Extended;
begin
  try
    TotalGeral := 0;
    with FDataModule.ACBrSpedFiscal.Bloco_H do
    begin
      // REGISTRO H001: ABERTURA DO BLOCO H
      with RegistroH001New do
      begin
        if Inventario = 0 then
          IND_MOV := imSemDados
        else
          IND_MOV := imComDados;

        ListaProduto := TProdutoController.TabelaProduto;
        for i := 0 to ListaProduto.Count - 1 do
        begin
          TotalGeral := TotalGeral + TProdutoVO(ListaProduto.Items[i]).QtdeEstoque * TProdutoVO(ListaProduto.Items[i]).ValorVenda;
        end;

        // REGISTRO H005: TOTAIS DO INVENTÁRIO
        with RegistroH005New do
        begin
          DT_INV := TextoParaData(DataFinal);
          VL_INV := TotalGeral;
          MOT_INV := TACBrMotivoInventario(Inventario);

          // REGISTRO H010: INVENTÁRIO.
          for i := 0 to ListaProduto.Count - 1 do
          begin
            with RegistroH010New do
            begin
              COD_ITEM := IntToStr(TProdutoVO(ListaProduto.Items[i]).Id);
              UNID := IntToStr(TProdutoVO(ListaProduto.Items[i]).IdUnidade);
              QTD := TProdutoVO(ListaProduto.Items[i]).QtdeEstoque;
              VL_UNIT := TProdutoVO(ListaProduto.Items[i]).ValorVenda;
              VL_ITEM := QTD * VL_UNIT;
              IND_PROP := TACBrPosseItem(0);
            end; // with RegistroH010New do
          end; // for i := 0 to ListaProduto.Count - 1 do

        end; // with RegistroH005New do

        // REGISTRO H020: Informação complementar do Inventário.
        { Implementado a critério do Participante do T2Ti ERP }

      end; //with RegistroH001New do

    end;
  finally
    ListaProduto.Free;
  end;
end;
{$ENDREGION}

{$REGION 'BLOCO 1: OUTRAS INFORMAÇÕES'}
class procedure TSpedFiscalController.GerarBloco1;
var
  i: Integer;
begin
  try
   with FDataModule.ACBrSpedFiscal.Bloco_1 do
    begin
      // REGISTRO 1001: ABERTURA DO BLOCO 1
      with Registro1001New do
      begin
        IND_MOV := imComDados;

        // REGISTRO 1010: OBRIGATORIEDADE DE REGISTROS DO BLOCO 1
        with Registro1010New do
        begin
          IND_EXP := 'N';        //1100
          IND_CCRF := 'N';       //1200
          IND_COMB := 'N';       //1300
          IND_USINA := 'N';      //1390
          IND_VA := 'N';         //1400
          IND_EE := 'N';         //1500
          IND_CART := 'N';       //1600
          IND_FORM := 'N';       //1700
          IND_AER := 'N';        //1800
        end; // with Registro1010New do
      end; //with Registro1001New do
    end;
  finally
  end;
end;
{$ENDREGION}

{$REGION 'Gerar Arquivo'}
class procedure TSpedFiscalController.GerarArquivoSpedFiscal(pDataIni: String; pDataFim: String; pVersao: Integer; pFinalidade: Integer; pPerfil: Integer; pEmpresa: Integer; pInventario: Integer; pContador: Integer);
var
   Mensagem, Arquivo: String;
begin
  VersaoLeiaute := pVersao;
  FinalidadeArquivo := pFinalidade;
  PerfilApresentacao := pPerfil;
  IdEmpresa := pEmpresa;
  Inventario := pInventario;
  IdContador := pContador;
  DataInicial := pDataIni;
  DataFinal := pDataFim;

  with FDataModule.ACBrSpedFiscal do
  begin
    DT_INI := TextoParaData(DataInicial);
    DT_FIN := TextoParaData(DataFinal);
  end;

  GerarBloco0;
  GerarBlocoC;
  // BLOCO D: DOCUMENTOS FISCAIS II - SERVIÇOS (ICMS).
  // Bloco de registros dos dados relativos à emissão ou ao recebimento de documentos fiscais que acobertam as prestações de serviços de comunicação, transporte intermunicipal e interestadual.
  { Implementado a critério do Leitor }
  GerarBlocoE;
  // BLOCO G – CONTROLE DO CRÉDITO DE ICMS DO ATIVO PERMANENTE CIAP
  { Implementado a critério do Leitor }
  if Inventario > 0 then
    GerarBlocoH;
  GerarBloco1;

  Arquivo := 'SpedFiscal.txt';
  FDataModule.ACBrSpedFiscal.Path := ExtractFilePath(Application.ExeName);
  FDataModule.ACBrSpedFiscal.Arquivo := Arquivo;
  FDataModule.ACBrSpedFiscal.SaveFileTXT;
end;
{$ENDREGION}

{$EndRegion}

end.
