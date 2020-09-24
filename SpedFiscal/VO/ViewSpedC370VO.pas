{*******************************************************************************
Title: AlbertEije ERP
Description:  VO  relacionado � tabela [VIEW_SPED_C370]
                                                                                
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
unit ViewSpedC370VO;

{$mode objfpc}{$H+}

interface

type
  TViewSpedC370VO = class
  private
    FID_NF_CABECALHO: Integer;
    FDATA_EMISSAO: TDateTime;
    FID_PRODUTO: Integer;
    FITEM: Integer;
    FID_UNIDADE_PRODUTO: Integer;
    FQUANTIDADE: Extended;
    FVALOR_TOTAL: Extended;
    FCST: String;
    FDESCONTO: Extended;

  public 
    property IdNfCabecalho: Integer  read FID_NF_CABECALHO write FID_NF_CABECALHO;
    property DataEmissao: TDateTime  read FDATA_EMISSAO write FDATA_EMISSAO;
    property IdProduto: Integer  read FID_PRODUTO write FID_PRODUTO;
    property Item: Integer  read FITEM write FITEM;
    property IdUnidadeProduto: Integer  read FID_UNIDADE_PRODUTO write FID_UNIDADE_PRODUTO;
    property Quantidade: Extended  read FQUANTIDADE write FQUANTIDADE;
    property ValorTotal: Extended  read FVALOR_TOTAL write FVALOR_TOTAL;
    property Cst: String  read FCST write FCST;
    property Desconto: Extended  read FDESCONTO write FDESCONTO;

  end;

implementation



end.
