{*******************************************************************************
Title: AlbertEije ERP
Description: Classe de controle da NF2

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
unit NotaFiscalController;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fgl, DB, ZDataset,
  NotaFiscalDetalheVO, NotaFiscalCabecalhoVO, ProdutoVO, NfeCabecalhoLimpaVO,
  NfeTransporteVO, NfeCupomFiscalReferenciadoVO, ViewSpedNfeDetalheVO;

type
  TListaNotaFiscalDetalheVO = specialize TFPGObjectList<TNotaFiscalDetalheVO>;
  TListaNotaFiscalCabecalhoVO = specialize TFPGObjectList<TNotaFiscalCabecalhoVO>;
  TListaNfeCabecalhoLimpaVO = specialize TFPGObjectList<TNfeCabecalhoLimpaVO>;
  TListaNfeDetalheVO = specialize TFPGObjectList<TViewSpedNfeDetalheVO>;
  TListaCupomNFeVO = specialize TFPGObjectList<TNfeCupomFiscalReferenciadoVO>;

  { TNotaFiscalController }

  TNotaFiscalController = class
  private
  protected
  public
    class function ConsultaNFCabecalhoSPED(DataInicio:String; DataFim:String; Cancelada: String): TListaNotaFiscalCabecalhoVO;
    class function ConsultaNFDetalheSPED(Id: Integer): TListaNotaFiscalDetalheVO;
    class function ConsultaNFeCabecalhoSPED(DataInicio:String; DataFim:String): TListaNfeCabecalhoLimpaVO;
    class function ConsultaNFeTransporte(IdNfeCabecalho: Integer): TNfeTransporteVO;
    class function ConsultaNFeCupom(IdNfeCabecalho: Integer): TListaCupomNFeVO;
    class function ConsultaNFeDetalhe(IdNfeCabecalho: Integer): TListaNfeDetalheVO;
  end;

implementation

uses UDataModule, ProdutoController, Biblioteca;

var
  ConsultaSQL: String;
  Query: TZQuery;

class function TNotaFiscalController.ConsultaNFCabecalhoSPED(
  DataInicio: String; DataFim: String; Cancelada: String
  ): TListaNotaFiscalCabecalhoVO;
var
  ListaNFCabecalho: TListaNotaFiscalCabecalhoVO;
  NFCabecalho: TNotaFiscalCabecalhoVO;
begin
  ConsultaSQL := 'select * from ECF_NOTA_FISCAL_CABECALHO where ' +
                 ' CANCELADA = ' + QuotedStr(Cancelada) +
                 ' and (DATA_EMISSAO between ' +
                 QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim) + ')';;
  try
    try
      ListaNFCabecalho := TListaNotaFiscalCabecalhoVO.Create;

      Query := TZQuery.Create(nil);
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        NFCabecalho := TNotaFiscalCabecalhoVO.Create;
        NFCabecalho.Id := Query.FieldByName('ID').AsInteger;
        NFCabecalho.IdEcfFuncionario := Query.FieldByName('ID_ECF_FUNCIONARIO').AsInteger;
        NFCabecalho.IdCliente := Query.FieldByName('ID_CLIENTE').AsInteger;
        NFCabecalho.CFOP := Query.FieldByName('CFOP').AsInteger;
        NFCabecalho.Numero := Query.FieldByName('NUMERO').AsString;
        NFCabecalho.NumOrdemInicial := Query.FieldByName('MINIMO').AsInteger;
        NFCabecalho.NumOrdemFinal := Query.FieldByName('MAXIMO').AsInteger;
        NFCabecalho.DataEmissao := Query.FieldByName('DATA_EMISSAO').AsDateTime;
        NFCabecalho.HoraEmissao := Query.FieldByName('HORA_EMISSAO').AsString;
        NFCabecalho.Serie := Query.FieldByName('SERIE').AsString;
        NFCabecalho.SubSerie := Query.FieldByName('SUBSERIE').AsString;
        NFCabecalho.TotalProdutos := Query.FieldByName('TOTAL_PRODUTOS').AsFloat;
        NFCabecalho.TotalNF := Query.FieldByName('TOTAL_NF').AsFloat;
        NFCabecalho.BaseICMS := Query.FieldByName('BASE_ICMS').AsFloat;
        NFCabecalho.ICMS := Query.FieldByName('ICMS').AsFloat;
        NFCabecalho.ICMSOutras := Query.FieldByName('ICMS_OUTRAS').AsFloat;
        NFCabecalho.ISSQN := Query.FieldByName('ISSQN').AsFloat;
        NFCabecalho.PIS := Query.FieldByName('PIS').AsFloat;
        NFCabecalho.COFINS := Query.FieldByName('COFINS').AsFloat;
        NFCabecalho.IPI := Query.FieldByName('IPI').AsFloat;
        NFCabecalho.TaxaAcrescimo := Query.FieldByName('TAXA_ACRESCIMO').AsFloat;
        NFCabecalho.Acrescimo := Query.FieldByName('ACRESCIMO').AsFloat;
        NFCabecalho.AcrescimoItens := Query.FieldByName('ACRESCIMO_ITENS').AsFloat;
        NFCabecalho.TaxaDesconto := Query.FieldByName('TAXA_DESCONTO').AsFloat;
        NFCabecalho.Desconto := Query.FieldByName('DESCONTO').AsFloat;
        NFCabecalho.DescontoItens := Query.FieldByName('DESCONTO_ITENS').AsFloat;
        NFCabecalho.Cancelada := Query.FieldByName('CANCELADA').AsString;
        NFCabecalho.CpfCnpjCliente := Query.FieldByName('CPF_CNPJ').AsString;
        ListaNFCabecalho.Add(NFCabecalho);
        Query.next;
      end;
      result := ListaNFCabecalho;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TNotaFiscalController.ConsultaNFDetalheSPED(Id: Integer): TListaNotaFiscalDetalheVO;
var
  ListaNFDetalhe: TListaNotaFiscalDetalheVO;
  NFDetalhe: TNotaFiscalDetalheVO;
  TotalRegistros: Integer;
  Produto: TProdutoVO;
begin
  ConsultaSQL := 'select count(*) AS TOTAL from NOTA_FISCAL_DETALHE where ID='+IntToStr(Id);
  try
    try
      Query := TZQuery.Create(nil);
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

      if TotalRegistros > 0 then
      begin
        ListaNFDetalhe := TListaNotaFiscalDetalheVO.Create;

        ConsultaSQL := 'select * from NOTA_FISCAL_DETALHE where ID='+IntToStr(Id);
        Query.sql.Text := ConsultaSQL;
        Query.Open;
        Query.First;
        while not Query.Eof do
        begin
          Produto := TProdutoController.ConsultaId(Query.FieldByName('ID_PRODUTO').AsInteger);
          NFDetalhe := TNotaFiscalDetalheVO.Create;
          NFDetalhe.Id := Query.FieldByName('ID').AsInteger;
          NFDetalhe.IdNFCabecalho := Query.FieldByName('ID_NF_CABECALHO').AsInteger;
          NFDetalhe.IdProduto := Query.FieldByName('ID_PRODUTO').AsInteger;
          NFDetalhe.CFOP := Query.FieldByName('CFOP').AsInteger;
          NFDetalhe.Item := Query.FieldByName('ITEM').AsInteger;
          NFDetalhe.Quantidade := Query.FieldByName('QUANTIDADE').AsFloat;
          NFDetalhe.ValorUnitario := Query.FieldByName('VALOR_UNITARIO').AsFloat;
          NFDetalhe.ValorTotal := Query.FieldByName('VALOR_TOTAL').AsFloat;
          NFDetalhe.BaseICMS := Query.FieldByName('BASE_ICMS').AsFloat;
          NFDetalhe.TaxaICMS := Query.FieldByName('TAXA_ICMS').AsFloat;
          NFDetalhe.ICMS := Query.FieldByName('ICMS').AsFloat;
          NFDetalhe.ICMSOutras := Query.FieldByName('ICMS_OUTRAS').AsFloat;
          NFDetalhe.ICMSIsento := Query.FieldByName('ICMS_ISENTO').AsFloat;
          NFDetalhe.TaxaDesconto := Query.FieldByName('TAXA_DESCONTO').AsFloat;
          NFDetalhe.Desconto := Query.FieldByName('DESCONTO').AsFloat;
          NFDetalhe.TaxaISSQN := Query.FieldByName('TAXA_ISSQN').AsFloat;
          NFDetalhe.ISSQN := Query.FieldByName('ISSQN').AsFloat;
          NFDetalhe.TaxaPIS := Query.FieldByName('TAXA_PIS').AsFloat;
          NFDetalhe.PIS := Query.FieldByName('PIS').AsFloat;
          NFDetalhe.TaxaCOFINS := Query.FieldByName('TAXA_COFINS').AsFloat;
          NFDetalhe.COFINS := Query.FieldByName('COFINS').AsFloat;
          NFDetalhe.TaxaAcrescimo := Query.FieldByName('TAXA_ACRESCIMO').AsFloat;
          NFDetalhe.Acrescimo := Query.FieldByName('ACRESCIMO').AsFloat;
          NFDetalhe.TaxaIPI := Query.FieldByName('TAXA_IPI').AsFloat;
          NFDetalhe.IPI := Query.FieldByName('IPI').AsFloat;
          NFDetalhe.Cancelado := Query.FieldByName('CANCELADO').AsString;
          NFDetalhe.Cst := Query.FieldByName('CST').AsString;
          NFDetalhe.MovimentaEstoque := Query.FieldByName('MOVIMENTA_ESTOQUE').AsString;
          NFDetalhe.DescricaoUnidade := Produto.UnidadeProduto;
          ListaNFDetalhe.Add(NFDetalhe);
          Query.next;
        end;
        result := ListaNFDetalhe;
      end
      // caso não exista a relacao, retorna um ponteiro nulo
      else
        result := nil;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TNotaFiscalController.ConsultaNFeCabecalhoSPED(DataInicio: String; DataFim: String): TListaNfeCabecalhoLimpaVO;
var
  ListaNFeCabecalho: TListaNfeCabecalhoLimpaVO;
  NFeCabecalho: TNfeCabecalhoLimpaVO;
begin
  ConsultaSQL := 'select * from NFE_CABECALHO where ' +
                 ' (DATA_EMISSAO between ' +
                 QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim) + ')';;
  try
    try
      ListaNFeCabecalho := TListaNfeCabecalhoLimpaVO.Create;

      Query := TZQuery.Create(nil);
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        NFeCabecalho := TNfeCabecalhoLimpaVO.Create;

        NFeCabecalho.Id := Query.FieldByName('ID').AsInteger;
        NFeCabecalho.IdTributOperacaoFiscal := Query.FieldByName('ID_TRIBUT_OPERACAO_FISCAL').AsInteger;
        NFeCabecalho.IdVendaCabecalho := Query.FieldByName('ID_VENDA_CABECALHO').AsInteger;
        NFeCabecalho.IdEmpresa := Query.FieldByName('ID_EMPRESA').AsInteger;
        NFeCabecalho.IdFornecedor := Query.FieldByName('ID_FORNECEDOR').AsInteger;
        NFeCabecalho.IdCliente := Query.FieldByName('ID_CLIENTE').AsInteger;
        NFeCabecalho.UfEmitente := Query.FieldByName('UF_EMITENTE').AsInteger;
        NFeCabecalho.CodigoNumerico := Query.FieldByName('CODIGO_NUMERICO').AsString;
        NFeCabecalho.NaturezaOperacao := Query.FieldByName('NATUREZA_OPERACAO').AsString;
        NFeCabecalho.IndicadorFormaPagamento := Query.FieldByName('INDICADOR_FORMA_PAGAMENTO').AsString;
        NFeCabecalho.CodigoModelo := Query.FieldByName('CODIGO_MODELO').AsString;
        NFeCabecalho.Serie := Query.FieldByName('SERIE').AsString;
        NFeCabecalho.Numero := Query.FieldByName('NUMERO').AsString;
        NFeCabecalho.DataEmissao := Query.FieldByName('DATA_EMISSAO').AsDateTime;
        NFeCabecalho.DataEntradaSaida := Query.FieldByName('DATA_ENTRADA_SAIDA').AsDateTime;
        NFeCabecalho.HoraEntradaSaida := Query.FieldByName('HORA_ENTRADA_SAIDA').AsString;
        NFeCabecalho.TipoOperacao := Query.FieldByName('TIPO_OPERACAO').AsString;
        NFeCabecalho.CodigoMunicipio := Query.FieldByName('CODIGO_MUNICIPIO').AsInteger;
        NFeCabecalho.FormatoImpressaoDanfe := Query.FieldByName('FORMATO_IMPRESSAO_DANFE').AsString;
        NFeCabecalho.TipoEmissao := Query.FieldByName('TIPO_EMISSAO').AsString;
        NFeCabecalho.ChaveAcesso := Query.FieldByName('CHAVE_ACESSO').AsString;
        NFeCabecalho.DigitoChaveAcesso := Query.FieldByName('DIGITO_CHAVE_ACESSO').AsString;
        NFeCabecalho.Ambiente := Query.FieldByName('AMBIENTE').AsString;
        NFeCabecalho.FinalidadeEmissao := Query.FieldByName('FINALIDADE_EMISSAO').AsString;
        NFeCabecalho.ProcessoEmissao := Query.FieldByName('PROCESSO_EMISSAO').AsString;
        NFeCabecalho.VersaoProcessoEmissao := Query.FieldByName('VERSAO_PROCESSO_EMISSAO').AsString;
        NFeCabecalho.DataEntradaContingencia := Query.FieldByName('DATA_ENTRADA_CONTINGENCIA').AsDateTime;
        NFeCabecalho.JustificativaContingencia := Query.FieldByName('JUSTIFICATIVA_CONTINGENCIA').AsString;
        NFeCabecalho.BaseCalculoIcms := Query.FieldByName('BASE_CALCULO_ICMS').AsFloat;
        NFeCabecalho.ValorIcms := Query.FieldByName('VALOR_ICMS').AsFloat;
        NFeCabecalho.BaseCalculoIcmsSt := Query.FieldByName('BASE_CALCULO_ICMS_ST').AsFloat;
        NFeCabecalho.ValorIcmsSt := Query.FieldByName('VALOR_ICMS_ST').AsFloat;
        NFeCabecalho.ValorTotalProdutos := Query.FieldByName('VALOR_TOTAL_PRODUTOS').AsFloat;
        NFeCabecalho.ValorFrete := Query.FieldByName('VALOR_FRETE').AsFloat;
        NFeCabecalho.ValorSeguro := Query.FieldByName('VALOR_SEGURO').AsFloat;
        NFeCabecalho.ValorDesconto := Query.FieldByName('VALOR_DESCONTO').AsFloat;
        NFeCabecalho.ValorImpostoImportacao := Query.FieldByName('VALOR_IMPOSTO_IMPORTACAO').AsFloat;
        NFeCabecalho.ValorIpi := Query.FieldByName('VALOR_IPI').AsFloat;
        NFeCabecalho.ValorPis := Query.FieldByName('VALOR_PIS').AsFloat;
        NFeCabecalho.ValorCofins := Query.FieldByName('VALOR_COFINS').AsFloat;
        NFeCabecalho.ValorDespesasAcessorias := Query.FieldByName('VALOR_DESPESAS_ACESSORIAS').AsFloat;
        NFeCabecalho.ValorTotal := Query.FieldByName('VALOR_TOTAL').AsFloat;
        NFeCabecalho.ValorServicos := Query.FieldByName('VALOR_SERVICOS').AsFloat;
        NFeCabecalho.BaseCalculoIssqn := Query.FieldByName('BASE_CALCULO_ISSQN').AsFloat;
        NFeCabecalho.ValorIssqn := Query.FieldByName('VALOR_ISSQN').AsFloat;
        NFeCabecalho.ValorPisIssqn := Query.FieldByName('VALOR_PIS_ISSQN').AsFloat;
        NFeCabecalho.ValorCofinsIssqn := Query.FieldByName('VALOR_COFINS_ISSQN').AsFloat;
        NFeCabecalho.ValorRetidoPis := Query.FieldByName('VALOR_RETIDO_PIS').AsFloat;
        NFeCabecalho.ValorRetidoCofins := Query.FieldByName('VALOR_RETIDO_COFINS').AsFloat;
        NFeCabecalho.ValorRetidoCsll := Query.FieldByName('VALOR_RETIDO_CSLL').AsFloat;
        NFeCabecalho.BaseCalculoIrrf := Query.FieldByName('BASE_CALCULO_IRRF').AsFloat;
        NFeCabecalho.ValorRetidoIrrf := Query.FieldByName('VALOR_RETIDO_IRRF').AsFloat;
        NFeCabecalho.BaseCalculoPrevidencia := Query.FieldByName('BASE_CALCULO_PREVIDENCIA').AsFloat;
        NFeCabecalho.ValorRetidoPrevidencia := Query.FieldByName('VALOR_RETIDO_PREVIDENCIA').AsFloat;
        NFeCabecalho.ComexUfEmbarque := Query.FieldByName('COMEX_UF_EMBARQUE').AsString;
        NFeCabecalho.ComexLocalEmbarque := Query.FieldByName('COMEX_LOCAL_EMBARQUE').AsString;
        NFeCabecalho.CompraNotaEmpenho := Query.FieldByName('COMPRA_NOTA_EMPENHO').AsString;
        NFeCabecalho.CompraPedido := Query.FieldByName('COMPRA_PEDIDO').AsString;
        NFeCabecalho.CompraContrato := Query.FieldByName('COMPRA_CONTRATO').AsString;
        NFeCabecalho.InformacoesAddFisco := Query.FieldByName('INFORMACOES_ADD_FISCO').AsString;
        NFeCabecalho.InformacoesAddContribuinte := Query.FieldByName('INFORMACOES_ADD_CONTRIBUINTE').AsString;
        NFeCabecalho.StatusNota := Query.FieldByName('STATUS_NOTA').AsString;

        ListaNFeCabecalho.Add(NFeCabecalho);

        Query.next;
      end;
      result := ListaNFeCabecalho;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TNotaFiscalController.ConsultaNFeTransporte(IdNfeCabecalho: Integer): TNfeTransporteVO;
begin
  ConsultaSQL := 'select * from NFE_TRANSPORTE where ' +
                 ' ID_NFE_CABECALHO = ' + IntToStr(IdNfeCabecalho);
  try
    try
      Result := TNfeTransporteVO.Create;

      Query := TZQuery.Create(nil);
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      if not Query.IsEmpty then
      begin

        Result.Id := Query.FieldByName('ID').AsInteger;
        Result.IdTransportadora := Query.FieldByName('ID_TRANSPORTADORA').AsInteger;
        Result.IdNfeCabecalho := Query.FieldByName('ID_NFE_CABECALHO').AsInteger;
        Result.ModalidadeFrete := Query.FieldByName('MODALIDADE_FRETE').AsString;
        Result.CpfCnpj := Query.FieldByName('CPF_CNPJ').AsString;
        Result.Nome := Query.FieldByName('NOME').AsString;
        Result.InscricaoEstadual := Query.FieldByName('INSCRICAO_ESTADUAL').AsString;
        Result.Endereco := Query.FieldByName('ENDERECO').AsString;
        Result.NomeMunicipio := Query.FieldByName('NOME_MUNICIPIO').AsString;
        Result.Uf := Query.FieldByName('UF').AsString;
        Result.ValorServico := Query.FieldByName('VALOR_SERVICO').AsFloat;
        Result.ValorBcRetencaoIcms := Query.FieldByName('VALOR_BC_RETENCAO_ICMS').AsFloat;
        Result.AliquotaRetencaoIcms := Query.FieldByName('ALIQUOTA_RETENCAO_ICMS').AsFloat;
        Result.ValorIcmsRetido := Query.FieldByName('VALOR_ICMS_RETIDO').AsFloat;
        Result.Cfop := Query.FieldByName('CFOP').AsInteger;
        Result.Municipio := Query.FieldByName('MUNICIPIO').AsInteger;
        Result.PlacaVeiculo := Query.FieldByName('PLACA_VEICULO').AsString;
        Result.UfVeiculo := Query.FieldByName('UF_VEICULO').AsString;
        Result.RntcVeiculo := Query.FieldByName('RNTC_VEICULO').AsString;
        Result.Vagao := Query.FieldByName('VAGAO').AsString;
        Result.Balsa := Query.FieldByName('BALSA').AsString;

      end
      else
        Result := Nil;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TNotaFiscalController.ConsultaNFeCupom(IdNfeCabecalho: Integer): TListaCupomNFeVO;
var
  Cupom: TNfeCupomFiscalReferenciadoVO;
begin
  ConsultaSQL := 'select * from NFE_CUPOM_FISCAL_REFERENCIADO where ' +
                 ' ID_NFE_CABECALHO = ' + IntToStr(IdNfeCabecalho);
  try
    try
      Result := TListaCupomNFeVO.Create;

      Query := TZQuery.Create(nil);
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        Cupom := TNfeCupomFiscalReferenciadoVO.Create;

        Cupom.Id := Query.FieldByName('ID').AsInteger;
        Cupom.IdNfeCabecalho := Query.FieldByName('ID_NFE_CABECALHO').AsInteger;
        Cupom.ModeloDocumentoFiscal := Query.FieldByName('MODELO_DOCUMENTO_FISCAL').AsString;
        Cupom.NumeroOrdemEcf := Query.FieldByName('NUMERO_ORDEM_ECF').AsInteger;
        Cupom.Coo := Query.FieldByName('COO').AsInteger;
        Cupom.DataEmissaoCupom := Query.FieldByName('DATA_EMISSAO_CUPOM').AsDateTime;
        Cupom.NumeroCaixa := Query.FieldByName('NUMERO_CAIXA').AsInteger;
        Cupom.NumeroSerieEcf := Query.FieldByName('NUMERO_SERIE_ECF').AsString;

        Result.Add(Cupom);

        Query.next;
      end;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TNotaFiscalController.ConsultaNFeDetalhe(IdNfeCabecalho: Integer): TListaNfeDetalheVO;
var
  NfeDetalhe: TViewSpedNfeDetalheVO;
begin
  ConsultaSQL := 'select * from NFE_DETALHE where ' +
                 ' ID_NFE_CABECALHO = ' + IntToStr(IdNfeCabecalho);
  try
    try
      Result := TListaNfeDetalheVO.Create;

      Query := TZQuery.Create(nil);
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        NfeDetalhe := TViewSpedNfeDetalheVO.Create;

        NfeDetalhe.Id := Query.FieldByName('ID').AsInteger;
        NfeDetalhe.IdProduto := Query.FieldByName('ID_PRODUTO').AsInteger;
        NfeDetalhe.IdNfeCabecalho := Query.FieldByName('ID_NFE_CABECALHO').AsInteger;
        NfeDetalhe.NumeroItem := Query.FieldByName('NUMERO_ITEM').AsInteger;
        NfeDetalhe.CodigoProduto := Query.FieldByName('CODIGO_PRODUTO').AsString;
        NfeDetalhe.Gtin := Query.FieldByName('GTIN').AsString;
        NfeDetalhe.NomeProduto := Query.FieldByName('NOME_PRODUTO').AsString;
        NfeDetalhe.Ncm := Query.FieldByName('NCM').AsString;
        NfeDetalhe.ExTipi := Query.FieldByName('EX_TIPI').AsInteger;
        NfeDetalhe.Cfop := Query.FieldByName('CFOP').AsInteger;
        NfeDetalhe.UnidadeComercial := Query.FieldByName('UNIDADE_COMERCIAL').AsString;
        NfeDetalhe.QuantidadeComercial := Query.FieldByName('QUANTIDADE_COMERCIAL').AsFloat;
        NfeDetalhe.ValorUnitarioComercial := Query.FieldByName('VALOR_UNITARIO_COMERCIAL').AsFloat;
        NfeDetalhe.ValorBrutoProduto := Query.FieldByName('VALOR_BRUTO_PRODUTO').AsFloat;
        NfeDetalhe.GtinUnidadeTributavel := Query.FieldByName('GTIN_UNIDADE_TRIBUTAVEL').AsString;
        NfeDetalhe.UnidadeTributavel := Query.FieldByName('UNIDADE_TRIBUTAVEL').AsString;
        NfeDetalhe.QuantidadeTributavel := Query.FieldByName('QUANTIDADE_TRIBUTAVEL').AsFloat;
        NfeDetalhe.ValorUnitarioTributavel := Query.FieldByName('VALOR_UNITARIO_TRIBUTAVEL').AsFloat;
        NfeDetalhe.ValorFrete := Query.FieldByName('VALOR_FRETE').AsFloat;
        NfeDetalhe.ValorSeguro := Query.FieldByName('VALOR_SEGURO').AsFloat;
        NfeDetalhe.ValorDesconto := Query.FieldByName('VALOR_DESCONTO').AsFloat;
        NfeDetalhe.ValorOutrasDespesas := Query.FieldByName('VALOR_OUTRAS_DESPESAS').AsFloat;
        NfeDetalhe.EntraTotal := Query.FieldByName('ENTRA_TOTAL').AsString;
        NfeDetalhe.ValorSubtotal := Query.FieldByName('VALOR_SUBTOTAL').AsFloat;
        NfeDetalhe.ValorTotal := Query.FieldByName('VALOR_TOTAL').AsFloat;
        NfeDetalhe.NumeroPedidoCompra := Query.FieldByName('NUMERO_PEDIDO_COMPRA').AsString;
        NfeDetalhe.ItemPedidoCompra := Query.FieldByName('ITEM_PEDIDO_COMPRA').AsInteger;
        NfeDetalhe.InformacoesAdicionais := Query.FieldByName('INFORMACOES_ADICIONAIS').AsString;

        Result.Add(NfeDetalhe);

        Query.next;
      end;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

end.
