{*******************************************************************************
Title: AlbertEije ERP
Description:  VO  relacionado � tabela [VIEW_SPED_NFE_EMITENTE] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2010 AlbertEije.COM
                                                                                
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
                                                                                
@author Albert Eije (alberteije@gmail.com)
@version 1.0                                                                    
*******************************************************************************}
unit ViewSpedNfeEmitenteVO;

{$mode objfpc}{$H+}

interface

type
  TViewSpedNfeEmitenteVO = class
  private
    FID: Integer;
    FRAZAO_SOCIAL: String;
    FCPF_CNPJ: String;
    FINSCRICAO_ESTADUAL: String;
    FCODIGO_MUNICIPIO: Integer;
    FSUFRAMA: String;
    FLOGRADOURO: String;
    FNUMERO: String;
    FCOMPLEMENTO: String;
    FBAIRRO: String;

  public 
    property Id: Integer  read FID write FID;
    property RazaoSocial: String  read FRAZAO_SOCIAL write FRAZAO_SOCIAL;
    property CpfCnpj: String  read FCPF_CNPJ write FCPF_CNPJ;
    property InscricaoEstadual: String  read FINSCRICAO_ESTADUAL write FINSCRICAO_ESTADUAL;
    property CodigoMunicipio: Integer  read FCODIGO_MUNICIPIO write FCODIGO_MUNICIPIO;
    property Suframa: String  read FSUFRAMA write FSUFRAMA;
    property Logradouro: String  read FLOGRADOURO write FLOGRADOURO;
    property Numero: String  read FNUMERO write FNUMERO;
    property Complemento: String  read FCOMPLEMENTO write FCOMPLEMENTO;
    property Bairro: String  read FBAIRRO write FBAIRRO;

  end;

implementation



end.
