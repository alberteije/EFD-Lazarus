{*******************************************************************************
Title: AlbertEije ERP
Description: VO relacionado à tabela EMPRESA

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
unit EmpresaVO;

{$mode objfpc}{$H+}

interface

type
  TEmpresaVO = class
  private
    FID: Integer;
    FID_EMPRESA: Integer;
    FID_SINDICATO_PATRONAL: Integer;
    FID_FPAS: Integer;
    FID_CONTADOR: Integer;
    FRAZAO_SOCIAL: String;
    FNOME_FANTASIA: String;
    FCNPJ: String;
    FINSCRICAO_ESTADUAL: String;
    FINSCRICAO_ESTADUAL_ST: String;
    FINSCRICAO_MUNICIPAL: String;
    FINSCRICAO_JUNTA_COMERCIAL: String;
    FDATA_INSC_JUNTA_COMERCIAL: TDateTime;
    FTIPO: String;
    FDATA_CADASTRO: TDateTime;
    FDATA_INICIO_ATIVIDADES: TDateTime;
    FSUFRAMA: String;
    FEMAIL: String;
    FIMAGEM_LOGOTIPO: String;
    FCRT: String;
    FTIPO_REGIME: String;
    FALIQUOTA_PIS: Extended;
    FCONTATO: String;
    FALIQUOTA_COFINS: Extended;
    FCODIGO_IBGE_CIDADE: Integer;
    FCODIGO_IBGE_UF: Integer;
    FCODIGO_TERCEIROS: Integer;
    FCODIGO_GPS: Integer;
    FALIQUOTA_SAT: Extended;
    FCEI: String;
    FCODIGO_CNAE_PRINCIPAL: String;

    FLOGRADOURO: String;
    FNUMERO: String;
    FCOMPLEMENTO: String;
    FCEP: String;
    FBAIRRO: String;
    FCIDADE: String;
    FUF: String;
    FFONE: String;
    FFAX: String;

  public
    property Id: Integer  read FID write FID;
    property IdMatriz: Integer  read FID_EMPRESA write FID_EMPRESA;
    property IdSindicatoPatronal: Integer  read FID_SINDICATO_PATRONAL write FID_SINDICATO_PATRONAL;
    property IdFpas: Integer  read FID_FPAS write FID_FPAS;
    property IdContador: Integer  read FID_CONTADOR write FID_CONTADOR;
    property RazaoSocial: String  read FRAZAO_SOCIAL write FRAZAO_SOCIAL;
    property NomeFantasia: String  read FNOME_FANTASIA write FNOME_FANTASIA;
    property Cnpj: String  read FCNPJ write FCNPJ;
    property InscricaoEstadual: String  read FINSCRICAO_ESTADUAL write FINSCRICAO_ESTADUAL;
    property InscricaoEstadualSt: String  read FINSCRICAO_ESTADUAL_ST write FINSCRICAO_ESTADUAL_ST;
    property InscricaoMunicipal: String  read FINSCRICAO_MUNICIPAL write FINSCRICAO_MUNICIPAL;
    property InscricaoJuntaComercial: String  read FINSCRICAO_JUNTA_COMERCIAL write FINSCRICAO_JUNTA_COMERCIAL;
    property DataInscJuntaComercial: TDateTime  read FDATA_INSC_JUNTA_COMERCIAL write FDATA_INSC_JUNTA_COMERCIAL;
    property Tipo: String  read FTIPO write FTIPO;
    property DataCadastro: TDateTime  read FDATA_CADASTRO write FDATA_CADASTRO;
    property DataInicioAtividades: TDateTime  read FDATA_INICIO_ATIVIDADES write FDATA_INICIO_ATIVIDADES;
    property Suframa: String  read FSUFRAMA write FSUFRAMA;
    property Email: String  read FEMAIL write FEMAIL;
    property ImagemLogotipo: String  read FIMAGEM_LOGOTIPO write FIMAGEM_LOGOTIPO;
    property Crt: String  read FCRT write FCRT;
    property TipoRegime: String  read FTIPO_REGIME write FTIPO_REGIME;
    property AliquotaPis: Extended  read FALIQUOTA_PIS write FALIQUOTA_PIS;
    property Contato: String  read FCONTATO write FCONTATO;
    property AliquotaCofins: Extended  read FALIQUOTA_COFINS write FALIQUOTA_COFINS;
    property CodigoIbgeCidade: Integer  read FCODIGO_IBGE_CIDADE write FCODIGO_IBGE_CIDADE;
    property CodigoIbgeUf: Integer  read FCODIGO_IBGE_UF write FCODIGO_IBGE_UF;
    property CodigoTerceiros: Integer  read FCODIGO_TERCEIROS write FCODIGO_TERCEIROS;
    property CodigoGps: Integer  read FCODIGO_GPS write FCODIGO_GPS;
    property AliquotaSat: Extended  read FALIQUOTA_SAT write FALIQUOTA_SAT;
    property Cei: String  read FCEI write FCEI;
    property CodigoCnaePrincipal: String  read FCODIGO_CNAE_PRINCIPAL write FCODIGO_CNAE_PRINCIPAL;

    property Logradouro: String  read FLOGRADOURO write FLOGRADOURO;
    property Numero: String  read FNUMERO write FNUMERO;
    property Complemento: String  read FCOMPLEMENTO write FCOMPLEMENTO;
    property Cep: String  read FCEP write FCEP;
    property Bairro: String  read FBAIRRO write FBAIRRO;
    property Cidade: String  read FCIDADE write FCIDADE;
    property Uf: String  read FUF write FUF;
    property Fone: String  read FFONE write FFONE;
    property Fax: String  read FFAX write FFAX;
  end;


implementation

end.
