{*******************************************************************************
Title: AlbertEije ERP
Description: Classe de controle da empresa

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
unit EmpresaController;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, EmpresaVO, ZDataset;

type
  TEmpresaController = class
  protected
  public
    class function PegaEmpresa(Id:Integer): TEmpresaVO;
  end;

implementation

uses UDataModule, Biblioteca;

var
  ConsultaSQL: String;
  Query: TZQuery;

class function TEmpresaController.PegaEmpresa(Id:Integer): TEmpresaVO;
var
  Empresa: TEmpresaVO;
begin
  ConsultaSQL := 'select E.*, EN.LOGRADOURO, EN.NUMERO, EN.COMPLEMENTO, EN.BAIRRO, EN.CIDADE, EN.CEP, EN.UF, EN.FONE, EN.FAX ' +
                 ' from EMPRESA E, ENDERECO EN ' +
                 ' where EN.ID_EMPRESA=E.ID and EN.PRINCIPAL = "S" and E.ID=' + IntToStr(Id);

  Empresa := TEmpresaVO.Create;

  try
    try
      Query := TZQuery.Create(nil);
      Query.Connection := FDataModule.Conexao;
      Query.sql.Text := ConsultaSQL;
      Query.Open;

      Empresa.Id                     := Query.FieldByName('ID').AsInteger;
      Empresa.IdMatriz               := Query.FieldByName('ID_EMPRESA').AsInteger;
      Empresa.RazaoSocial            := Query.FieldByName('RAZAO_SOCIAL').AsString;
      Empresa.NomeFantasia           := Query.FieldByName('NOME_FANTASIA').AsString;
      Empresa.Cnpj                   := Query.FieldByName('CNPJ').AsString;
      Empresa.InscricaoEstadual      := Query.FieldByName('INSCRICAO_ESTADUAL').AsString;
      Empresa.InscricaoEstadualSt    := Query.FieldByName('INSCRICAO_ESTADUAL_ST').AsString;
      Empresa.InscricaoMunicipal     := Query.FieldByName('INSCRICAO_MUNICIPAL').AsString;
      Empresa.InscricaoJuntaComercial:= Query.FieldByName('INSCRICAO_JUNTA_COMERCIAL').AsString;
      Empresa.DataInscJuntaComercial := Query.FieldByName('DATA_INSC_JUNTA_COMERCIAL').AsDateTime;
      Empresa.DataCadastro           := Query.FieldByName('DATA_CADASTRO').AsDateTime;
      Empresa.DataInicioAtividades   := Query.FieldByName('DATA_INICIO_ATIVIDADES').AsDateTime;
      Empresa.Suframa                := Query.FieldByName('SUFRAMA').AsString;
      Empresa.Email                  := Query.FieldByName('EMAIL').AsString;
      Empresa.ImagemLogotipo         := Query.FieldByName('IMAGEM_LOGOTIPO').AsString;
      Empresa.Crt                    := Query.FieldByName('CRT').AsString;
      Empresa.TipoRegime             := Query.FieldByName('TIPO_REGIME').AsString;
      Empresa.AliquotaPis            := Query.FieldByName('ALIQUOTA_PIS').AsFloat;
      Empresa.AliquotaCofins         := Query.FieldByName('ALIQUOTA_COFINS').AsFloat;
      Empresa.Logradouro             := Query.FieldByName('LOGRADOURO').AsString;
      Empresa.Numero                 := Query.FieldByName('NUMERO').AsString;
      Empresa.Complemento            := Query.FieldByName('COMPLEMENTO').AsString;
      Empresa.Cep                    := Query.FieldByName('CEP').AsString;
      Empresa.Bairro                 := Query.FieldByName('BAIRRO').AsString;
      Empresa.Cidade                 := Query.FieldByName('CIDADE').AsString;
      Empresa.Uf                     := Query.FieldByName('UF').AsString;
      Empresa.Fone                   := Query.FieldByName('FONE').AsString;
      Empresa.Fax                    := Query.FieldByName('FAX').AsString;
      Empresa.Contato                := Query.FieldByName('CONTATO').AsString;
      Empresa.CodigoIbgeCidade       := Query.FieldByName('CODIGO_IBGE_CIDADE').AsInteger;
      Empresa.CodigoIbgeUf           := Query.FieldByName('CODIGO_IBGE_UF').AsInteger;

      result := Empresa;
    except
      result := nil;
    end;
  finally
    Query.Free;
  end;
end;


end.
