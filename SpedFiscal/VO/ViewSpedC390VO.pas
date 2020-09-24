{*******************************************************************************
Title: AlbertEije ERP
Description:  VO  relacionado � tabela [VIEW_SPED_C390]
                                                                                
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
unit ViewSpedC390VO;

{$mode objfpc}{$H+}

interface

type
  TViewSpedC390VO = class
  private
    FCST: String;
    FCFOP: Integer;
    FTAXA_ICMS: Extended;
    FDATA_EMISSAO: TDateTime;
    FSOMA_ITEM: Extended;
    FSOMA_BASE_ICMS: Extended;
    FSOMA_ICMS: Extended;
    FSOMA_ICMS_OUTRAS: Extended;

  public 
    property Cst: String  read FCST write FCST;
    property Cfop: Integer  read FCFOP write FCFOP;
    property TaxaIcms: Extended  read FTAXA_ICMS write FTAXA_ICMS;
    property DataEmissao: TDateTime  read FDATA_EMISSAO write FDATA_EMISSAO;
    property SomaItem: Extended  read FSOMA_ITEM write FSOMA_ITEM;
    property SomaBaseIcms: Extended  read FSOMA_BASE_ICMS write FSOMA_BASE_ICMS;
    property SomaIcms: Extended  read FSOMA_ICMS write FSOMA_ICMS;
    property SomaIcmsOutras: Extended  read FSOMA_ICMS_OUTRAS write FSOMA_ICMS_OUTRAS;

  end;

implementation



end.
