{*******************************************************************************
Title: AlbertEije ERP
Description: Classe de controle do contador

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
unit ContadorController;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ContadorVO, ZDataset;

type
  TContadorController = class
  protected
  public
    class function PegaContador: TContadorVO;
  end;

implementation

uses UDataModule, Biblioteca;

var
  ConsultaSQL: String;
  Query: TZQuery;

class function TContadorController.PegaContador: TContadorVO;
var
  Contador: TContadorVO;
begin
  ConsultaSQL := 'select * from VIEW_PESSOA_CONTADOR';

  Contador := TContadorVO.Create;

  try
    try
      Query := TZQuery.Create(nil);
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      Contador.Id := Query.FieldByName('ID').AsInteger;
      Contador.CpfCnpj := Query.FieldByName('CPF_CNPJ').AsString;
      Contador.Nome := Query.FieldByName('NOME').AsString;
      Contador.InscricaoCrc := Query.FieldByName('INSCRICAO_CRC').AsString;
      Contador.Fone := Query.FieldByName('FONE').AsString;
      Contador.Fax := Query.FieldByName('FAX').AsString;
      Contador.Logradouro := Query.FieldByName('LOGRADOURO').AsString;
      Contador.Numero := Query.FieldByName('NUMERO').AsString;
      Contador.Complemento := Query.FieldByName('COMPLEMENTO').AsString;
      Contador.Bairro := Query.FieldByName('BAIRRO').AsString;
      Contador.Cidade := Query.FieldByName('CIDADE').AsString;
      Contador.CEP := Query.FieldByName('CEP').AsString;
      Contador.MunicipioIbge := Query.FieldByName('MUNICIPIO_IBGE').AsInteger;
      Contador.UF := Query.FieldByName('UF').AsString;
      Contador.Email := Query.FieldByName('EMAIL').AsString;
      result := Contador;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;

end.
