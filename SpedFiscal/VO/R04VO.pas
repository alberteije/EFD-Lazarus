{*******************************************************************************
Title: AlbertEije ERP
Description: VO transiente. Montará os dados necessários para o registro R04.

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
unit R04VO;

{$mode objfpc}{$H+}

interface

type
  TR04VO = class
  private

    FId: Integer;
    FIdOperador: Integer;
    FSERIE_ECF: String;
    FCCF: Integer;
    FCOO: Integer;
    FDATA_VENDA: TDateTime;
    FDataEmissao: TDateTime;
    FSubTotal: Extended;
    FDesconto: Extended;
    FIndicadorDesconto: String;
    FAcrescimo: Extended;
    FIndicadorAcrescimo: String;
    FValorLiquido: Extended;
   // FCancelado: String;
    FCancelamentoAcrescimo: Extended;
    FOrdemDescontoAcrescimo: String;
    FCliente: String;
    FCPFCNPJ: String;
    FHASH_TRIPA: String;
    FHASH_INCREMENTO: Integer;
    FCUPOM_CANCELADO: String;
    FSTATUS_VENDA: String;

    //Utilizados pelo Sped Fiscal
    FPIS: Extended;
    FCOFINS: Extended;

  published

    property Id: Integer read FID write FID;
    property IdOperador: Integer read FIdOperador write FIdOperador;
    property SerieEcf: String  read FSERIE_ECF write FSERIE_ECF;
    property CCF: Integer read FCCF write FCCF;
    property COO: Integer read FCOO write FCOO;
    property DataVenda: TDateTime read FDATA_VENDA write FDATA_VENDA;
    property DataEmissao: TDateTime read FDataEmissao write FDataEmissao;
    property SubTotal: Extended read FSubTotal write FSubTotal;
    property Desconto: Extended read FDesconto write FDesconto;
    property IndicadorDesconto: String read FIndicadorDesconto write FIndicadorDesconto;
    property Acrescimo: Extended read FAcrescimo write FAcrescimo;
    property IndicadorAcrescimo: String read FIndicadorAcrescimo write FIndicadorAcrescimo;
    property ValorLiquido: Extended read FValorLiquido write FValorLiquido;
    property Cancelado: String read FCUPOM_CANCELADO write FCUPOM_CANCELADO;
    property CancelamentoAcrescimo: Extended read FCancelamentoAcrescimo write FCancelamentoAcrescimo;
    property OrdemDescontoAcrescimo: String read FOrdemDescontoAcrescimo write FOrdemDescontoAcrescimo;
    property Cliente: String read FCliente write FCliente;
    property CPFCNPJ: String read FCPFCNPJ write FCPFCNPJ;
    property HashTripa: String read FHASH_TRIPA write FHASH_TRIPA;
    property HashIncremento: Integer read FHASH_INCREMENTO write FHASH_INCREMENTO;
    property StatusVenda: String read FSTATUS_VENDA write FSTATUS_VENDA;

    //Utilizados pelo Sped Fiscal
    property PIS: Extended read FPIS write FPIS;
    property COFINS: Extended read FCOFINS write FCOFINS;

end;

implementation

end.
