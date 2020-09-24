{*******************************************************************************
Title: AlbertEije ERP
Description:  VO  relacionado � tabela [NFE_TRANSPORTE]
                                                                                
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
unit NfeTransporteVO;

{$mode objfpc}{$H+}

interface

type
  TNfeTransporteVO = class
  private
    FID: Integer;
    FID_TRANSPORTADORA: Integer;
    FID_NFE_CABECALHO: Integer;
    FMODALIDADE_FRETE: String;
    FCPF_CNPJ: String;
    FNOME: String;
    FINSCRICAO_ESTADUAL: String;
    FENDERECO: String;
    FNOME_MUNICIPIO: String;
    FUF: String;
    FVALOR_SERVICO: Extended;
    FVALOR_BC_RETENCAO_ICMS: Extended;
    FALIQUOTA_RETENCAO_ICMS: Extended;
    FVALOR_ICMS_RETIDO: Extended;
    FCFOP: Integer;
    FMUNICIPIO: Integer;
    FPLACA_VEICULO: String;
    FUF_VEICULO: String;
    FRNTC_VEICULO: String;
    FVAGAO: String;
    FBALSA: String;

  public
    property Id: Integer  read FID write FID;
    property IdTransportadora: Integer  read FID_TRANSPORTADORA write FID_TRANSPORTADORA;
    property IdNfeCabecalho: Integer  read FID_NFE_CABECALHO write FID_NFE_CABECALHO;
    property ModalidadeFrete: String  read FMODALIDADE_FRETE write FMODALIDADE_FRETE;
    property CpfCnpj: String  read FCPF_CNPJ write FCPF_CNPJ;
    property Nome: String  read FNOME write FNOME;
    property InscricaoEstadual: String  read FINSCRICAO_ESTADUAL write FINSCRICAO_ESTADUAL;
    property Endereco: String  read FENDERECO write FENDERECO;
    property NomeMunicipio: String  read FNOME_MUNICIPIO write FNOME_MUNICIPIO;
    property Uf: String  read FUF write FUF;
    property ValorServico: Extended  read FVALOR_SERVICO write FVALOR_SERVICO;
    property ValorBcRetencaoIcms: Extended  read FVALOR_BC_RETENCAO_ICMS write FVALOR_BC_RETENCAO_ICMS;
    property AliquotaRetencaoIcms: Extended  read FALIQUOTA_RETENCAO_ICMS write FALIQUOTA_RETENCAO_ICMS;
    property ValorIcmsRetido: Extended  read FVALOR_ICMS_RETIDO write FVALOR_ICMS_RETIDO;
    property Cfop: Integer  read FCFOP write FCFOP;
    property Municipio: Integer  read FMUNICIPIO write FMUNICIPIO;
    property PlacaVeiculo: String  read FPLACA_VEICULO write FPLACA_VEICULO;
    property UfVeiculo: String  read FUF_VEICULO write FUF_VEICULO;
    property RntcVeiculo: String  read FRNTC_VEICULO write FRNTC_VEICULO;
    property Vagao: String  read FVAGAO write FVAGAO;
    property Balsa: String  read FBALSA write FBALSA;

  end;

implementation

end.
