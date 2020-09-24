{*******************************************************************************
Title: AlbertEije ERP
Description: Classe de controle do produto.

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
unit ProdutoController;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ProdutoVO, fgl, md5;

type
  TListaProdutoVO = specialize TFPGObjectList<TProdutoVO>;

  { TProdutoController }

  TProdutoController = class
  protected
  public
    class function ConsultaProdutoSPED(pDataInicial, pDataFinal: String; pPerfilApresentacao: Integer): TListaProdutoVO;
    class function ConsultaId(Id: Integer): TProdutoVO;
    class function TabelaProduto: TListaProdutoVO;
  end;

implementation

uses UDataModule, Biblioteca, ZDataSet;

var
  ConsultaSQL, ClausulaWhere: String;
  Query: TZQuery;

class function TProdutoController.ConsultaProdutoSPED(pDataInicial, pDataFinal: String; pPerfilApresentacao : Integer): TListaProdutoVO;
var
  ListaProduto: TListaProdutoVO;
  Produto: TProdutoVO;
  TotalRegistros, Perfil: Integer;
  DataInicio, DataFim : String ;
begin
  try
    try

     DataInicio := QuotedStr(FormatDateTime('yyyy-mm-dd', StrToDate(pDataInicial)));
     DataFim := QuotedStr(FormatDateTime('yyyy-mm-dd', StrToDate(pDataFinal)));
     Perfil := pPerfilApresentacao;

        ConsultaSQL :=
            ' select count(*) as total '+
            ' from  PRODUTO P, UNIDADE_PRODUTO U, ECF_VENDA_CABECALHO V, ECF_VENDA_DETALHE D'+
            ' where V.DATA_VENDA between '+DataInicio+' and '+DataFim+
            ' and (P.ID_UNIDADE_PRODUTO = U.ID)'+
            ' and (V.ID=D.ID_ECF_VENDA_CABECALHO)'+
            ' and (D.ID_ECF_PRODUTO=P.ID) group by D.ID_ECF_PRODUTO';

        Query := TZQuery.Create(nil);
        Query.Connection := FDataModule.Conexao;
        Query.sql.Text := ConsultaSQL;
        Query.Open;
        TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

    if TotalRegistros > 0 then
    begin
      ListaProduto := TListaProdutoVO.Create;
      case Perfil of
       0 : begin
       // Perfil A
        ClausulaWhere :=
                      ' where v.DATA_VENDA between '+DataInicio+' and '+DataFim+
                      ' and D.CANCELADO <> ' + QuotedStr('S') +
                      ' and (P.ID_UNIDADE_PRODUTO = U.ID)'+
                      ' and (v.id=d.id_ecf_venda_cabecalho)'+
                      ' and (d.id_ecf_produto=p.id)';
       end;
       1 : begin
       // Perfil B
        ClausulaWhere :=
                      ' where v.DATA_VENDA between '+DataInicio+' and '+DataFim+
                      ' and (P.ID_UNIDADE_PRODUTO = U.ID)'+
                      ' and (v.id=d.id_ecf_venda_cabecalho)'+
                      ' and (d.id_ecf_produto=p.id)';
       end;
       2 : begin
       // Perfil C
        ClausulaWhere :=
                      ' where v.DATA_VENDA between '+DataInicio+' and '+DataFim+
                      ' and (P.ID_UNIDADE_PRODUTO = U.ID)'+
                      ' and (v.id=d.id_ecf_venda_cabecalho)'+
                      ' and (d.id_ecf_produto=p.id)';
       end;
      end;

        ConsultaSQL :=
                      'select distinct ' +
                      ' P.ID, ' +
                      ' P.ID_UNIDADE_PRODUTO, ' +
                      ' P.GTIN, ' +
                      ' P.CODIGO_INTERNO, ' +
                      ' P.NOME AS NOME_PRODUTO, ' +
                      ' P.DESCRICAO, ' +
                      ' P.DESCRICAO_PDV, ' +
                      ' P.VALOR_VENDA, ' +
                      ' P.QTD_ESTOQUE, ' +
                      ' P.QTD_ESTOQUE_ANTERIOR, ' +
                      ' P.ESTOQUE_MIN, ' +
                      ' P.ESTOQUE_MAX, ' +
                      ' P.IAT, ' +
                      ' P.IPPT, ' +
                      ' P.NCM, ' +
                      ' P.TIPO_ITEM_SPED, ' +
                      ' P.DATA_ESTOQUE, ' +
                      ' P.TAXA_IPI, ' +
                      ' P.TAXA_ISSQN, ' +
                      ' P.TAXA_PIS, ' +
                      ' P.TAXA_COFINS, ' +
                      ' P.TAXA_ICMS, ' +
                      ' P.CST, ' +
                      ' P.CSOSN, ' +
                      ' P.TOTALIZADOR_PARCIAL, ' +
                      ' P.ECF_ICMS_ST, ' +
                      ' P.CODIGO_BALANCA, ' +
                      ' P.PAF_P_ST, ' +
                      ' P.HASH_TRIPA, ' +
                      ' U.NOME AS NOME_UNIDADE, ' +
                      ' U.PODE_FRACIONAR ' +
                      'from ' +
                      ' PRODUTO P, UNIDADE_PRODUTO U, ECF_VENDA_CABECALHO V, ECF_VENDA_DETALHE D'+
                      ClausulaWhere;

      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;

      while not Query.Eof do
      begin
        Produto := TProdutoVO.Create;
        Produto.Id := Query.FieldByName('ID').AsInteger;
        Produto.IdUnidade := Query.FieldByName('ID_UNIDADE_PRODUTO').AsInteger;
        Produto.GTIN := Query.FieldByName('GTIN').AsString;
        Produto.CodigoInterno := Query.FieldByName('CODIGO_INTERNO').AsString;
        Produto.Nome := Query.FieldByName('NOME_PRODUTO').AsString;
        Produto.Descricao := Query.FieldByName('DESCRICAO').AsString;
        Produto.DescricaoPDV := Query.FieldByName('DESCRICAO_PDV').AsString;
        Produto.ValorVenda := Query.FieldByName('VALOR_VENDA').AsFloat;
        Produto.QtdeEstoque := Query.FieldByName('QTD_ESTOQUE').AsFloat;
        Produto.QtdeEstoqueAnterior := Query.FieldByName('QTD_ESTOQUE_ANTERIOR').AsFloat;
        Produto.EstoqueMinimo := Query.FieldByName('ESTOQUE_MIN').AsFloat;
        Produto.EstoqueMaximo := Query.FieldByName('ESTOQUE_MAX').AsFloat;
        Produto.IAT := Query.FieldByName('IAT').AsString;
        Produto.IPPT := Query.FieldByName('IPPT').AsString;
        Produto.NCM := Query.FieldByName('NCM').AsString;
        Produto.TipoItemSped := Query.FieldByName('TIPO_ITEM_SPED').AsString;
        Produto.DataEstoque := Query.FieldByName('DATA_ESTOQUE').AsDateTime;
        Produto.AliquotaIpi := Query.FieldByName('TAXA_IPI').AsFloat;
        Produto.AliquotaIssqn := Query.FieldByName('TAXA_ISSQN').AsFloat;
        Produto.AliquotaPis := Query.FieldByName('TAXA_PIS').AsFloat;
        Produto.AliquotaCofins := Query.FieldByName('TAXA_COFINS').AsFloat;
        Produto.AliquotaIcms := Query.FieldByName('TAXA_ICMS').AsFloat;
        Produto.Cst := Query.FieldByName('CST').AsString;
        Produto.Csosn := Query.FieldByName('CSOSN').AsString;
        Produto.TotalizadorParcial := Query.FieldByName('TOTALIZADOR_PARCIAL').AsString;
        Produto.ECFICMS := Query.FieldByName('ECF_ICMS_ST').AsString;
        Produto.CodigoBalanca:= Query.FieldByName('CODIGO_BALANCA').AsInteger;
        Produto.PafProdutoSt := Query.FieldByName('PAF_P_ST').AsString;
        Produto.HashTripa := Query.FieldByName('HASH_TRIPA').AsString;
        Produto.UnidadeProduto := Query.FieldByName('NOME_UNIDADE').AsString;
        Produto.PodeFracionarUnidade := Query.FieldByName('PODE_FRACIONAR').AsString;
        ListaProduto.Add(Produto);
        Query.next;
      end;
      result := ListaProduto;
     end
     else
       result := nil;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TProdutoController.ConsultaId(Id: Integer): TProdutoVO;
var
  Produto: TProdutoVO;
begin
  ConsultaSQL :=
                  'select ' +
                  ' P.ID, ' +
                  ' P.ID_UNIDADE_PRODUTO, ' +
                  ' P.GTIN, ' +
                  ' P.CODIGO_INTERNO, ' +
                  ' P.NOME AS NOME_PRODUTO, ' +
                  ' P.DESCRICAO, ' +
                  ' P.DESCRICAO_PDV, ' +
                  ' P.VALOR_VENDA, ' +
                  ' P.QTD_ESTOQUE, ' +
                  ' P.QTD_ESTOQUE_ANTERIOR, ' +
                  ' P.ESTOQUE_MIN, ' +
                  ' P.ESTOQUE_MAX, ' +
                  ' P.IAT, ' +
                  ' P.IPPT, ' +
                  ' P.NCM, ' +
                  ' P.TIPO_ITEM_SPED, ' +
                  ' P.DATA_ESTOQUE, ' +
                  ' P.TAXA_IPI, ' +
                  ' P.TAXA_ISSQN, ' +
                  ' P.TAXA_PIS, ' +
                  ' P.TAXA_COFINS, ' +
                  ' P.TAXA_ICMS, ' +
                  ' P.CST, ' +
                  ' P.CSOSN, ' +
                  ' P.TOTALIZADOR_PARCIAL, ' +
                  ' P.ECF_ICMS_ST, ' +
                  ' P.CODIGO_BALANCA, ' +
                  ' P.PAF_P_ST, ' +
                  ' P.HASH_TRIPA, ' +
                  ' P.HASH_INCREMENTO, ' +
                  ' U.NOME AS NOME_UNIDADE, ' +
                  ' U.PODE_FRACIONAR ' +
                  'from ' +
                  ' PRODUTO P, ' +
                  ' UNIDADE_PRODUTO U ' +
                  'where ' +
                  ' (P.ID = ' + IntToStr(Id) + ') '+
                  ' and (P.ID_UNIDADE_PRODUTO = U.ID) ';
  try
    try
      Query := TZQuery.Create(nil);
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      Produto := TProdutoVO.Create;
      Produto.Id := Query.FieldByName('ID').AsInteger;
      Produto.IdUnidade := Query.FieldByName('ID_UNIDADE_PRODUTO').AsInteger;
      Produto.GTIN := Query.FieldByName('GTIN').AsString;
      Produto.CodigoInterno := Query.FieldByName('CODIGO_INTERNO').AsString;
      Produto.Nome := Query.FieldByName('NOME_PRODUTO').AsString;
      Produto.Descricao := Query.FieldByName('DESCRICAO').AsString;
      Produto.DescricaoPDV := Query.FieldByName('DESCRICAO_PDV').AsString;
      Produto.ValorVenda := Query.FieldByName('VALOR_VENDA').AsFloat;
      Produto.QtdeEstoque := Query.FieldByName('QTD_ESTOQUE').AsFloat;
      Produto.QtdeEstoqueAnterior := Query.FieldByName('QTD_ESTOQUE_ANTERIOR').AsFloat;
      Produto.EstoqueMinimo := Query.FieldByName('ESTOQUE_MIN').AsFloat;
      Produto.EstoqueMaximo := Query.FieldByName('ESTOQUE_MAX').AsFloat;
      Produto.IAT := Query.FieldByName('IAT').AsString;
      Produto.IPPT := Query.FieldByName('IPPT').AsString;
      Produto.NCM := Query.FieldByName('NCM').AsString;
      Produto.TipoItemSped := Query.FieldByName('TIPO_ITEM_SPED').AsString;
      Produto.DataEstoque := Query.FieldByName('DATA_ESTOQUE').AsDateTime;
      Produto.AliquotaIpi := Query.FieldByName('TAXA_IPI').AsFloat;
      Produto.AliquotaIssqn := Query.FieldByName('TAXA_ISSQN').AsFloat;
      Produto.AliquotaPis := Query.FieldByName('TAXA_PIS').AsFloat;
      Produto.AliquotaCofins := Query.FieldByName('TAXA_COFINS').AsFloat;
      Produto.AliquotaIcms := Query.FieldByName('TAXA_ICMS').AsFloat;
      Produto.Cst := Query.FieldByName('CST').AsString;
      Produto.Csosn := Query.FieldByName('CSOSN').AsString;
      Produto.TotalizadorParcial := Query.FieldByName('TOTALIZADOR_PARCIAL').AsString;
      Produto.ECFICMS := Query.FieldByName('ECF_ICMS_ST').AsString;
      Produto.CodigoBalanca:= Query.FieldByName('CODIGO_BALANCA').AsInteger;
      Produto.PafProdutoSt := Query.FieldByName('PAF_P_ST').AsString;
      Produto.HashTripa := Query.FieldByName('HASH_TRIPA').AsString;
      Produto.HashIncremento := Query.FieldByName('HASH_INCREMENTO').AsInteger;
      Produto.UnidadeProduto := Query.FieldByName('NOME_UNIDADE').AsString;
      Produto.PodeFracionarUnidade := Query.FieldByName('PODE_FRACIONAR').AsString;
      result := Produto;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TProdutoController.TabelaProduto: TListaProdutoVO;
var
  Produto: TProdutoVO;
begin
  try
    try
      Result := TListaProdutoVO.Create;

      ConsultaSQL := 'select * from PRODUTO';

      Query := TZQuery.Create(nil);
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      while not Query.Eof do
      begin
        Produto := TProdutoVO.Create;
        Produto.Id := Query.FieldByName('ID').AsInteger;
        Produto.IdUnidade := Query.FieldByName('ID_UNIDADE_PRODUTO').AsInteger;
        Produto.GTIN := Query.FieldByName('GTIN').AsString;
        Produto.CodigoInterno := Query.FieldByName('CODIGO_INTERNO').AsString;
        Produto.Nome := Query.FieldByName('NOME').AsString;
        Produto.Descricao := Query.FieldByName('DESCRICAO').AsString;
        Produto.DescricaoPDV := Query.FieldByName('DESCRICAO_PDV').AsString;
        Produto.ValorVenda := Query.FieldByName('VALOR_VENDA').AsFloat;
        Produto.QtdeEstoque := Query.FieldByName('QUANTIDADE_ESTOQUE').AsFloat;
        Produto.QtdeEstoqueAnterior := Query.FieldByName('QUANTIDADE_ESTOQUE_ANTERIOR').AsFloat;
        Produto.EstoqueMinimo := Query.FieldByName('ESTOQUE_MINIMO').AsFloat;
        Produto.EstoqueMaximo := Query.FieldByName('ESTOQUE_MAXIMO').AsFloat;
        Produto.IAT := Query.FieldByName('IAT').AsString;
        Produto.IPPT := Query.FieldByName('IPPT').AsString;
        Produto.NCM := Query.FieldByName('NCM').AsString;
        Produto.TipoItemSped := Query.FieldByName('TIPO_ITEM_SPED').AsString;
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

end.
