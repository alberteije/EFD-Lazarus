{*******************************************************************************
Title: AlbertEije ERP
Description: Classe de controle da impressora

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
unit ImpressoraController;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ImpressoraVO, fgl, ZDataset;

type
  TListaImpressoraVO = specialize TFPGObjectList<TImpressoraVO>;
  TImpressoraController = class
  protected
  public
    class function TabelaImpressora: TListaImpressoraVO;
  end;

implementation

uses UDataModule, Biblioteca;

var
  ConsultaSQL: String;
  Query: TZQuery;

class function TImpressoraController.TabelaImpressora: TListaImpressoraVO;
var
  ListaImpressora: TListaImpressoraVO;
  Impressora: TImpressoraVO;
begin
  try
    try
      ConsultaSQL := 'select * from ECF_IMPRESSORA';

      Query := TZQuery.Create(nil);
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      ListaImpressora := TListaImpressoraVO.Create;

      Query.First;
      while not Query.Eof do
      begin
        Impressora := TImpressoraVO.Create;
        Impressora.Id := Query.FieldByName('ID').AsInteger;
        Impressora.Numero := Query.FieldByName('NUMERO').AsInteger;
        Impressora.Codigo := Query.FieldByName('CODIGO').AsString;
        Impressora.Serie := Query.FieldByName('SERIE').AsString;
        Impressora.Identificacao := Query.FieldByName('IDENTIFICACAO').AsString;
        Impressora.Mc := Query.FieldByName('MC').AsString;
        Impressora.Md := Query.FieldByName('MD').AsString;
        Impressora.Vr := Query.FieldByName('VR').AsString;
        Impressora.Tipo := Query.FieldByName('TIPO').AsString;
        Impressora.Marca := Query.FieldByName('MARCA').AsString;
        Impressora.Modelo := Query.FieldByName('MODELO').AsString;
        Impressora.ModeloAcbr := Query.FieldByName('MODELO_ACBR').AsString;
        Impressora.ModeloDocumentoFiscal := Query.FieldByName('MODELO_DOCUMENTO_FISCAL').AsString;
        Impressora.Versao := Query.FieldByName('VERSAO').AsString;
        Impressora.Le := Query.FieldByName('LE').AsString;
        Impressora.Lef := Query.FieldByName('LEF').AsString;
        Impressora.MFD := Query.FieldByName('MFD').AsString;
        Impressora.LacreNaMfd := Query.FieldByName('LACRE_NA_MFD').AsString;
        Impressora.Docto := Query.FieldByName('DOCTO').AsString;
        Impressora.NumeroEcf := Query.FieldByName('ECF_IMPRESSORA').AsString;
        Impressora.DataInstalacaoSb := Query.FieldByName('DATA_INSTALACAO_SB').AsDateTime;
        Impressora.HoraInstalacaoSb := Query.FieldByName('HORA_INSTALACAO_SB').AsString;
        ListaImpressora.Add(Impressora);
        Query.next;
      end;
      result := ListaImpressora;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

end.
