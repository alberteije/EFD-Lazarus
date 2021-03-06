{*******************************************************************************
Title: AlbertEije ERP
Description: VO relacionado à tabela PRODUTO

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
unit ProdutoVO;

{$mode objfpc}{$H+}

interface

type
  TProdutoVO = class
  private
    FID: Integer;
    FID_UNIDADE_PRODUTO: Integer;
    FGTIN: String;
    FCODIGO_INTERNO: String;
    FNOME: String;
    FDESCRICAO: String;
    FDESCRICAO_PDV: String;
    FVALOR_VENDA: Extended;
    FQTD_ESTOQUE: Extended;
    FQTD_ESTOQUE_ANTERIOR: Extended;
    FESTOQUE_MIN: Extended;
    FESTOQUE_MAX: Extended;
    FIAT: String;
    FIPPT: String;
    FNCM: String;
    FTIPO_ITEM_SPED: String;
    FDATA_ESTOQUE: TDateTime;
    FTAXA_IPI: Extended;
    FTAXA_ISSQN: Extended;
    FTAXA_PIS: Extended;
    FTAXA_COFINS: Extended;
    FTAXA_ICMS: Extended;
    FCST: String;
    FCSOSN: String;
    FTOTALIZADOR_PARCIAL: String;
    FECF_ICMS_ST: String;
    FCODIGO_BALANCA: Integer;
    FPAF_P_ST : String;
    FHASH_TRIPA: String;
    FHASH_INCREMENTO: Integer;

    FUnidadeProduto: String;
    FPodeFracionarUnidade: String;

  published
    property Id: Integer read FID write FID;
    property IdUnidade: Integer read FID_UNIDADE_PRODUTO write FID_UNIDADE_PRODUTO;
    property GTIN: String read FGTIN write FGTIN;
    property CodigoInterno: String read FCODIGO_INTERNO write FCODIGO_INTERNO;
    property Nome: String read FNOME write FNOME;
    property Descricao: String read FDESCRICAO write FDESCRICAO;
    property DescricaoPDV: String read FDESCRICAO_PDV write FDESCRICAO_PDV;
    property ValorVenda: Extended read FVALOR_VENDA write FVALOR_VENDA;
    property QtdeEstoque: Extended read FQTD_ESTOQUE write FQTD_ESTOQUE;
    property QtdeEstoqueAnterior: Extended read FQTD_ESTOQUE_ANTERIOR write FQTD_ESTOQUE_ANTERIOR;
    property EstoqueMinimo: Extended read FESTOQUE_MIN write FESTOQUE_MIN;
    property EstoqueMaximo: Extended read FESTOQUE_MAX write FESTOQUE_MAX;
    property IAT: String read FIAT write FIAT;
    property IPPT: String read FIPPT write FIPPT;
    property NCM: String read FNCM write FNCM;
    property TipoItemSped: String read FTIPO_ITEM_SPED write FTIPO_ITEM_SPED;
    property DataEstoque: TDateTime read FDATA_ESTOQUE write FDATA_ESTOQUE;
    property AliquotaIPI: Extended read FTAXA_IPI write FTAXA_IPI;
    property AliquotaISSQN: Extended read FTAXA_ISSQN write FTAXA_ISSQN;
    property AliquotaPIS: Extended read FTAXA_PIS write FTAXA_PIS;
    property AliquotaCOFINS: Extended read FTAXA_COFINS write FTAXA_COFINS;
    property AliquotaICMS: Extended read FTAXA_ICMS write FTAXA_ICMS;
    property Cst: String read FCST write FCST;
    property Csosn: String read FCSOSN write FCSOSN;
    property TotalizadorParcial: String read FTOTALIZADOR_PARCIAL write FTOTALIZADOR_PARCIAL;
    property ECFICMS: String read FECF_ICMS_ST write FECF_ICMS_ST;
    property CodigoBalanca: Integer read FCODIGO_BALANCA write FCODIGO_BALANCA;
    property PafProdutoST: String read FPAF_P_ST write FPAF_P_ST;
    property HashTripa: String read FHASH_TRIPA write FHASH_TRIPA;
    property HashIncremento: Integer read FHASH_INCREMENTO write FHASH_INCREMENTO;

    property UnidadeProduto: String read FUnidadeProduto write FUnidadeProduto;
    property PodeFracionarUnidade: String read FPodeFracionarUnidade write FPodeFracionarUnidade;
  end;

implementation

end.
