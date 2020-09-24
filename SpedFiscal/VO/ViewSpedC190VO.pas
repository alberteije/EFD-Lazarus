{*******************************************************************************
Title: AlbertEije ERP
Description:  VO  relacionado à tabela [VIEW_SPED_C190]

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
unit ViewSpedC190VO;

{$mode objfpc}{$H+}

interface

type
  TViewSpedC190VO = class
  private
    FID: Integer;
    FCST_ICMS: String;
    FCFOP: Integer;
    FALIQUOTA_ICMS: Extended;
    FDATA_EMISSAO: TDateTime;
    FSOMA_VALOR_OPERACAO: Extended;
    FSOMA_BASE_CALCULO_ICMS: Extended;
    FSOMA_VALOR_ICMS: Extended;
    FSOMA_BASE_CALCULO_ICMS_ST: Extended;
    FSOMA_VALOR_ICMS_ST: Extended;
    FSOMA_VL_RED_BC: Extended;
    FSOMA_VALOR_IPI: Extended;

  public 
    property Id: Integer  read FID write FID;
    property CstIcms: String  read FCST_ICMS write FCST_ICMS;
    property Cfop: Integer  read FCFOP write FCFOP;
    property AliquotaIcms: Extended  read FALIQUOTA_ICMS write FALIQUOTA_ICMS;
    property DataEmissao: TDateTime  read FDATA_EMISSAO write FDATA_EMISSAO;
    property SomaValorOperacao: Extended  read FSOMA_VALOR_OPERACAO write FSOMA_VALOR_OPERACAO;
    property SomaBaseCalculoIcms: Extended  read FSOMA_BASE_CALCULO_ICMS write FSOMA_BASE_CALCULO_ICMS;
    property SomaValorIcms: Extended  read FSOMA_VALOR_ICMS write FSOMA_VALOR_ICMS;
    property SomaBaseCalculoIcmsSt: Extended  read FSOMA_BASE_CALCULO_ICMS_ST write FSOMA_BASE_CALCULO_ICMS_ST;
    property SomaValorIcmsSt: Extended  read FSOMA_VALOR_ICMS_ST write FSOMA_VALOR_ICMS_ST;
    property SomaVlRedBc: Extended  read FSOMA_VL_RED_BC write FSOMA_VL_RED_BC;
    property SomaValorIpi: Extended  read FSOMA_VALOR_IPI write FSOMA_VALOR_IPI;

  end;

implementation



end.
