{*******************************************************************************
Title: AlbertEije ERP
Description:  VO  relacionado � tabela [VIEW_SPED_C300]
                                                                                
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
unit ViewSpedC300VO;

{$mode objfpc}{$H+}

interface

type
  TViewSpedC300VO = class
  private
    FSERIE: String;
    FSUBSERIE: String;
    FDATA_EMISSAO: TDateTime;
    FSOMA_TOTAL_NF: Extended;
    FSOMA_PIS: Extended;
    FSOMA_COFINS: Extended;

  public 
    property Serie: String  read FSERIE write FSERIE;
    property Subserie: String  read FSUBSERIE write FSUBSERIE;
    property DataEmissao: TDateTime  read FDATA_EMISSAO write FDATA_EMISSAO;
    property SomaTotalNf: Extended  read FSOMA_TOTAL_NF write FSOMA_TOTAL_NF;
    property SomaPis: Extended  read FSOMA_PIS write FSOMA_PIS;
    property SomaCofins: Extended  read FSOMA_COFINS write FSOMA_COFINS;

  end;

implementation



end.
