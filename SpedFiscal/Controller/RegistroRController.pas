{*******************************************************************************
Title: AlbertEije ERP
Description: Classe de controle dos registros R

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

{*******************************************************************************
Observações importantes

Registro tipo R01 - Identificação do ECF, do Usuário, do PAF-ECF e da Empresa Desenvolvedora e Dados do Arquivo;
Registro tipo R02 - Relação de Reduções Z;
Registro tipo R03 - Detalhe da Redução Z;
Registro tipo R04 - Cupom Fiscal, Nota Fiscal de Venda a Consumidor ou Bilhete de Passagem;
Registro tipo R05 - Detalhe do Cupom Fiscal, da Nota Fiscal de Venda a Consumidor ou do Bilhete de Passagem;
Registro tipo R06 - Demais documentos emitidos pelo ECF;
Registro tipo R07 - Detalhe do Cupom Fiscal e do Documento Não Fiscal - Meio de Pagamento;
*******************************************************************************}

unit RegistroRController;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, R02VO, R03VO, R04VO, R05VO,
  fgl, Biblioteca, Constantes, Forms, ZDataset, md5;

type
  TListaR02VO = specialize TFPGObjectList<TR02VO>;
  TListaR03VO = specialize TFPGObjectList<TR03VO>;
  TListaR04VO = specialize TFPGObjectList<TR04VO>;
  TListaR05VO = specialize TFPGObjectList<TR05VO>;
  TRegistroRController = class
  protected
  public
    class function TabelaR02(DataInicio: String; DataFim: String; IdImpressora: Integer): TListaR02VO;
    class function TabelaR02Id(Id: Integer): TListaR02VO;
    class function TabelaR03(Id: Integer): TListaR03VO;
    class function TabelaR04(pDataInicio: TDateTime; pDataFim: TDateTime): TListaR04VO;
    class function TabelaR05(Id: Integer): TListaR05VO;
    class function TotalR02(DataInicio: String; DataFim: String): Integer;
  end;

implementation

uses UDataModule, ImpressoraVO, ImpressoraController;

var
  ConsultaSQL: String;
  Query: TZQuery;


class function TRegistroRController.TabelaR02(DataInicio: String; DataFim: String; IdImpressora: Integer): TListaR02VO;
var
  ListaR02: TListaR02VO;
  R02: TR02VO;
  TotalRegistros: Integer;
begin
  ConsultaSQL := 'select count(*) as TOTAL from ECF_R02 where ' +
    'ID_IMPRESSORA=' + IntToStr(idImpressora) +
    ' and  DATA_MOVIMENTO between ' +
    QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim);
  try
    try
      Query := TZQuery.Create(nil);
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;
      if TotalRegistros > 0 then
      begin
        ListaR02 := TListaR02VO.Create;
        ConsultaSQL := 'select * from ECF_R02 where ' +
        'ID_IMPRESSORA=' + IntToStr(idImpressora) +
        ' and (DATA_MOVIMENTO between ' +
        QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim) + ')';
        Query.sql.Text := ConsultaSQL;
        Query.Open;
        Query.First;
        while not Query.Eof do
        begin
          R02 := TR02VO.Create;
          R02.Id := Query.FieldByName('ID').AsInteger;
          R02.IdOperador := Query.FieldByName('ID_OPERADOR').AsInteger;
          R02.IdImpressora := Query.FieldByName('ID_IMPRESSORA').AsInteger;
          R02.IdCaixa := Query.FieldByName('ID_ECF_CAIXA').AsInteger;
          R02.SerieEcf := Query.FieldByName('SERIE_ECF').AsString;
          R02.CRZ := Query.FieldByName('CRZ').AsInteger;
          R02.COO := Query.FieldByName('COO').AsInteger;
          R02.CRO := Query.FieldByName('CRO').AsInteger;
          R02.DataMovimento := Query.FieldByName('DATA_MOVIMENTO').AsDateTime;
          R02.DataEmissao := Query.FieldByName('DATA_EMISSAO').AsDateTime;
          R02.HoraEmissao := Query.FieldByName('HORA_EMISSAO').AsString;
          R02.VendaBruta := Query.FieldByName('VENDA_BRUTA').AsFloat;
          R02.GrandeTotal := Query.FieldByName('GRANDE_TOTAL').AsFloat;
          R02.HashTripa := Query.FieldByName('HASH_TRIPA').AsString;
          R02.HashIncremento := Query.FieldByName('HASH_INCREMENTO').AsInteger;
          ListaR02.Add(R02);
          Query.next;
        end;
        result := ListaR02;
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

class function TRegistroRController.TabelaR02Id(Id: Integer): TListaR02VO;
var
  ListaR02: TListaR02VO;
  R02: TR02VO;
  TotalRegistros: Integer;
begin
  ConsultaSQL := 'select count(*) as TOTAL from ECF_R02 where ID_IMPRESSORA=' + IntToStr(Id);
  try
    try
      Query := TZQuery.Create(nil);
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;
      if TotalRegistros > 0 then
      begin
        ListaR02 := TListaR02VO.Create;

        ConsultaSQL := 'select * from ECF_R02 where ID_IMPRESSORA=' + IntToStr(Id);
        Query.sql.Text := ConsultaSQL;
        Query.Open;
        Query.First;
        while not Query.Eof do
        begin
          R02 := TR02VO.Create;
          R02.Id := Query.FieldByName('ID').AsInteger;
          R02.IdOperador := Query.FieldByName('ID_OPERADOR').AsInteger;
          R02.IdImpressora := Query.FieldByName('ID_IMPRESSORA').AsInteger;
          R02.IdCaixa := Query.FieldByName('ID_ECF_CAIXA').AsInteger;
          R02.CRZ := Query.FieldByName('CRZ').AsInteger;
          R02.COO := Query.FieldByName('COO').AsInteger;
          R02.CRO := Query.FieldByName('CRO').AsInteger;
          R02.DataMovimento := Query.FieldByName('DATA_MOVIMENTO').AsDateTime;
          R02.DataEmissao := Query.FieldByName('DATA_EMISSAO').AsDateTime;
          R02.HoraEmissao := Query.FieldByName('HORA_EMISSAO').AsString;
          R02.VendaBruta := Query.FieldByName('VENDA_BRUTA').AsFloat;
          R02.GrandeTotal := Query.FieldByName('GRANDE_TOTAL').AsFloat;
          R02.HashTripa := Query.FieldByName('HASH_TRIPA').AsString;
          R02.HashIncremento := Query.FieldByName('HASH_INCREMENTO').AsInteger;
          ListaR02.Add(R02);
          Query.next;
        end;
        result := ListaR02;
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

class function TRegistroRController.TabelaR03(Id: Integer): TListaR03VO;
var
  ListaR03: TListaR03VO;
  R03: TR03VO;
  TotalRegistros: Integer;
begin
  ConsultaSQL := 'select count(*) AS TOTAL from ECF_R03 where ID_R02='+IntToStr(Id);
  try
    try
      Query := TZQuery.Create(nil);
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

      if TotalRegistros > 0 then
      begin
        ListaR03 := TListaR03VO.Create;

        ConsultaSQL := 'select * from ECF_R03 where ID_R02='+IntToStr(Id);

        Query.sql.Text := ConsultaSQL;
        Query.Open;
        Query.First;
        while not Query.Eof do
        begin
          R03 := TR03VO.Create;
          R03.Id := Query.FieldByName('ID').AsInteger;
          R03.IdR02 := Query.FieldByName('ID_R02').AsInteger;
          R03.SerieEcf := Query.FieldByName('SERIE_ECF').AsString;
          R03.TotalizadorParcial := Query.FieldByName('TOTALIZADOR_PARCIAL').AsString;
          R03.ValorAcumulado := Query.FieldByName('VALOR_ACUMULADO').AsFloat;
          R03.CRZ := Query.FieldByName('CRZ').AsInteger;
          R03.HashTripa := Query.FieldByName('HASH_TRIPA').AsString;
          R03.HashIncremento := Query.FieldByName('HASH_INCREMENTO').AsInteger;
          ListaR03.Add(R03);
          Query.next;
        end;
        result := ListaR03;
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

class function TRegistroRController.TabelaR04(pDataInicio: TDateTime; pDataFim:TDateTime): TListaR04VO;
var
  ListaR04: TListaR04VO;
  R04: TR04VO;
  TotalRegistros: Integer;
  DataInicio, DataFim: String;
begin
  DataInicio := FormatDateTime('yyyy-mm-dd', StrToDate(DataInicio));
  DataFim := FormatDateTime('yyyy-mm-dd', StrToDate(DataFim));

  ConsultaSQL :=
    'select count(*) as TOTAL ' +
    'from ECF_VENDA_CABECALHO '+
    ' where (DATA_VENDA between ' +
    QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim) + ')';
  try
    try
      Query := TZQuery.Create(nil);
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

      if TotalRegistros > 0 then
      begin
        ListaR04 := TListaR04VO.Create;

        ConsultaSQL :=
          'select * from ECF_VENDA_CABECALHO ' +
          ' where (DATA_VENDA between ' +
          QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim) + ')';

        Query.sql.Text := ConsultaSQL;
        Query.Open;
        Query.First;
        while not Query.Eof do
        begin
          R04 := TR04VO.Create;
          R04.Id := Query.FieldByName('ID').AsInteger;
          R04.IdOperador := Query.FieldByName('ID_ECF_FUNCIONARIO').AsInteger;
          R04.SerieEcf := Query.FieldByName('SERIE_ECF').AsString;
          R04.CCF := Query.FieldByName('CCF').AsInteger;
          R04.COO := Query.FieldByName('COO').AsInteger;
          R04.DataEmissao := Query.FieldByName('DATA_VENDA').AsDateTime;
          R04.DataVenda := Query.FieldByName('DATA_VENDA').AsDateTime;
          R04.SubTotal := Query.FieldByName('VALOR_VENDA').AsFloat;
          R04.Desconto := Query.FieldByName('DESCONTO').AsFloat;
          R04.IndicadorDesconto := 'V';
          R04.Acrescimo := Query.FieldByName('ACRESCIMO').AsFloat;
          R04.IndicadorAcrescimo := 'V';
          R04.ValorLiquido := Query.FieldByName('VALOR_FINAL').AsFloat;
          R04.PIS := Query.FieldByName('PIS').AsFloat;
          R04.COFINS := Query.FieldByName('COFINS').AsFloat;
          R04.Cancelado := Query.FieldByName('CUPOM_CANCELADO').AsString;
          R04.CancelamentoAcrescimo := 0;
          R04.OrdemDescontoAcrescimo := 'D';
          R04.Cliente := Query.FieldByName('NOME_CLIENTE').AsString;
          R04.CPFCNPJ := Query.FieldByName('CPF_CNPJ_CLIENTE').AsString;
          R04.HashTripa := Query.FieldByName('HASH_TRIPA').AsString;
          R04.HashIncremento := Query.FieldByName('HASH_INCREMENTO').AsInteger;
          R04.StatusVenda := Query.FieldByName('STATUS_VENDA').AsString;
          ListaR04.Add(R04);
          Query.next;
        end;
        result := ListaR04;
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

class function TRegistroRController.TabelaR05(Id: Integer): TListaR05VO;
var
  ListaR05: TListaR05VO;
  R05: TR05VO;
  TotalRegistros : Integer;
begin
  ConsultaSQL :=
    'select count(*) as TOTAL '+
    'from ECF_VENDA_DETALHE ' +
    'where ID_ECF_VENDA_CABECALHO=' +IntToStr(Id);

  try
    try
      Query := TZQuery.Create(nil);
      Query.ParamCheck := True;
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

      if TotalRegistros > 0 then
      begin
        ListaR05 := TListaR05VO.Create;

        ConsultaSQL :=
          'select * from ECF_VENDA_DETALHE ' +
          'where ID_ECF_VENDA_CABECALHO=' +IntToStr(Id);

        Query.sql.Text := ConsultaSQL;
        Query.Open;
        Query.First;
        while not Query.Eof do
        begin
          R05 := TR05VO.Create;

          R05.Id := Query.FieldByName('ID').AsInteger;
          R05.Item := Query.FieldByName('ITEM').AsInteger;
          R05.SerieEcf := Query.FieldByName('SERIE_ECF').AsString;
          R05.IdProduto := Query.FieldByName('ID_ECF_PRODUTO').AsInteger;
          R05.GTIN := Query.FieldByName('GTIN').AsString;
          R05.Ccf := Query.FieldByName('CCF').AsInteger;
          R05.Coo := Query.FieldByName('COO').AsInteger;
          R05.DescricaoPDV := Query.FieldByName('DESCRICAO_PDV').AsString;
          R05.Quantidade := TruncaValor(Query.FieldByName('QUANTIDADE').AsFloat,Constantes.TConstantes.DECIMAIS_QUANTIDADE);
          R05.IdUnidade := Query.FieldByName('ID_UNIDADE').AsInteger;
          R05.SiglaUnidade := Query.FieldByName('SIGLA_UNIDADE').AsString;
          R05.ValorUnitario := TruncaValor(Query.FieldByName('VALOR_UNITARIO').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);
          R05.Desconto := TruncaValor(Query.FieldByName('DESCONTO').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);
          R05.Acrescimo := TruncaValor(Query.FieldByName('ACRESCIMO').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);
          R05.TotalItem := TruncaValor(Query.FieldByName('TOTAL_ITEM').AsFloat,Constantes.TConstantes.DECIMAIS_VALOR);
          R05.TotalizadorParcial := Query.FieldByName('TOTALIZADOR_PARCIAL').AsString;
          R05.IndicadorCancelamento := Query.FieldByName('CANCELADO').AsString;
          if R05.IndicadorCancelamento = 'S' then
            R05.QuantidadeCancelada := TruncaValor(Query.FieldByName('QUANTIDADE').AsFloat,Constantes.TConstantes.DECIMAIS_QUANTIDADE)
          else
            R05.QuantidadeCancelada := 0;
          if R05.IndicadorCancelamento = 'S' then
            R05.ValorCancelado := Query.FieldByName('TOTAL_ITEM').AsFloat
          else
            R05.ValorCancelado := 0;
          R05.CancelamentoAcrescimo := 0;
          R05.IAT := Query.FieldByName('IAT').AsString;
          R05.IPPT := Query.FieldByName('IPPT').AsString;
          R05.CasasDecimaisQuantidade := 3;
          R05.CasasDecimaisValor := 2;
          R05.CST := Query.FieldByName('CST').AsString;
          R05.CFOP := Query.FieldByName('CFOP').AsInteger;
          R05.AliquotaICMS := Query.FieldByName('TAXA_ICMS').AsFloat;
          R05.PIS := Query.FieldByName('PIS').AsFloat;
          R05.COFINS := Query.FieldByName('COFINS').AsFloat;
          R05.HashTripa := Query.FieldByName('HASH_TRIPA').AsString;
          R05.HashIncremento := Query.FieldByName('HASH_INCREMENTO').AsInteger;

          ListaR05.Add(R05);
          Query.next;
        end;
        result := ListaR05;
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

class function TRegistroRController.TotalR02(DataInicio:String; DataFim:String): Integer;
var
  TotalRegistros: Integer;
begin
  DataInicio := FormatDateTime('yyyy-mm-dd', StrToDate(DataInicio));
  DataFim := FormatDateTime('yyyy-mm-dd', StrToDate(DataFim));

  ConsultaSQL :=
    'select count(*) as total from r02 ' +
    'where data_movimento between ' +
    QuotedStr(DataInicio) + ' and ' + QuotedStr(DataFim) + ')';
  try
    try
      Query := TZQuery.Create(nil);
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      TotalRegistros := Query.FieldByName('TOTAL').AsInteger;

      result := TotalRegistros;
    except
      result := 0;
    end;
  finally
    Query.Free;
  end;
end;

end.
