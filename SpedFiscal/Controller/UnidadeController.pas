{*******************************************************************************
Title: AlbertEije ERP
Description: Classe de controle da unidade

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
unit UnidadeController;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, UnidadeProdutoVO, fgl, ZDataset, UnidadeConversaoVO;

type
  TListaUnidadeProdutoVO = specialize TFPGObjectList<TUnidadeProdutoVO>;

  { TUnidadeController }

  TUnidadeController = class
  protected
  public
    class function TabelaUnidade: TListaUnidadeProdutoVO;
    class function UnidadeSPED(pDataInicial, pDataFinal: String): TListaUnidadeProdutoVO;
    class function ConsultaIdUnidade(Id: Integer): Boolean;
    class function ConsultaUnidadeConversao(IdProduto: Integer; IdUnidadeProduto: Integer): TUnidadeConversaoVO;

  end;

implementation

uses UDataModule, Biblioteca;

var
  ConsultaSQL: String;
  Query: TZQuery;

class function TUnidadeController.TabelaUnidade: TListaUnidadeProdutoVO;
var
  ListaUnidade: TListaUnidadeProdutoVO;
  Unidade: TUnidadeProdutoVO;
begin
  try
    try
      ConsultaSQL := 'select * from UNIDADE_PRODUTO';
      Query := TZQuery.Create(nil);
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      ListaUnidade := TListaUnidadeProdutoVO.Create;

      Query.First;
      while not Query.Eof do
      begin
        Unidade := TUnidadeProdutoVO.Create;
        Unidade.Id := Query.FieldByName('ID').AsInteger;
        Unidade.Sigla := Query.FieldByName('SIGLA').AsString;
        Unidade.Descricao := Query.FieldByName('DESCRICAO').AsString;
        Unidade.PodeFracionar := Query.FieldByName('PODE_FRACIONAR').AsString;
        ListaUnidade.Add(Unidade);
        Query.next;
      end;
      result := ListaUnidade;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TUnidadeController.UnidadeSPED(pDataInicial, pDataFinal: String): TListaUnidadeProdutoVO;
var
  ListaUnidade: TListaUnidadeProdutoVO;
  Unidade: TUnidadeProdutoVO;
  DataInicio, DataFim : String ;
begin
  try
    try
      DataInicio := QuotedStr(FormatDateTime('yyyy-mm-dd', StrToDate(pDataInicial)));
      DataFim := QuotedStr(FormatDateTime('yyyy-mm-dd', StrToDate(pDataFinal)));

      ConsultaSQL := 'SELECT distinct U.* '+
                     ' FROM UNIDADE_PRODUTO U, PRODUTO P, ECF_VENDA_CABECALHO V, ECF_VENDA_DETALHE D '+
                     ' WHERE V.DATA_VENDA BETWEEN '+DataInicio+' and '+DataFim+
                     ' AND P.ID_UNIDADE_PRODUTO=U.ID '+
                     ' AND V.ID=D.ID_ECF_VENDA_CABECALHO'+
                     ' AND D.ID_ECF_PRODUTO=P.ID';

      Query := TZQuery.Create(nil);
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      ListaUnidade := TListaUnidadeProdutoVO.Create;

      Query.First;
      while not Query.Eof do
      begin
        Unidade := TUnidadeProdutoVO.Create;
        Unidade.Id := Query.FieldByName('ID').AsInteger;
        Unidade.Sigla := Query.FieldByName('SIGLA').AsString;
        Unidade.Descricao := Query.FieldByName('DESCRICAO').AsString;
        Unidade.PodeFracionar := Query.FieldByName('PODE_FRACIONAR').AsString;
        ListaUnidade.Add(Unidade);
        Query.next;
      end;
      result := ListaUnidade;

    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

class function TUnidadeController.ConsultaIdUnidade(Id:Integer):boolean;
begin
  ConsultaSQL := 'select ID from UNIDADE_PRODUTO where (ID = :pID) ';
  try
    try
      Query := TZQuery.Create(nil);
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.ParamByName('pID').AsInteger:=Id;
      Query.Open;
      if not Query.IsEmpty then
        result := true
      else
        result := false;
    except
    end;
  finally
    Query.Free;
  end;
end;

class function TUnidadeController.ConsultaUnidadeConversao(IdProduto: Integer; IdUnidadeProduto: Integer): TUnidadeConversaoVO;
begin
  ConsultaSQL := 'select ID from UNIDADE_CONVERSAO where ' +
  ' ID_PRODUTO=' + IntToStr(IdProduto) + ' and ID_UNIDADE_PRODUTO=' + IntToStr(IdUnidadeProduto);
  try
    try
      Result := TUnidadeConversaoVO.Create;

      Query := TZQuery.Create(nil);
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;
      Query.First;
      while not Query.Eof do
      begin
        Result.Id := Query.FieldByName('ID').AsInteger;
        Result.IdProduto := Query.FieldByName('ID_PRODUTO').AsInteger;
        Result.IdUnidadeProduto := Query.FieldByName('ID_UNIDADE_PRODUTO').AsInteger;
        Result.Sigla := Query.FieldByName('SIGLA').AsString;
        Result.Descricao := Query.FieldByName('DESCRICAO').AsString;
        Result.FatorConversao := Query.FieldByName('FATOR_CONVERSAO').AsFloat;
        Query.next;
      end;

    except
      Result := Nil;
    end;
  finally
    Query.Free;
  end;
end;

end.
