{ *******************************************************************************
  Title: AlbertEije ERP
  Description: DataModule

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
  ******************************************************************************* }
unit UDataModule;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Forms, FMTBcd, DB, memds, Classes, StdCtrls, Controls, Windows,
  Dialogs, ZConnection, ACBrSpedFiscal, Inifiles;

type

  { TFDataModule }

  TFDataModule = class(TDataModule)
    ACBrSPEDFiscal: TACBrSPEDFiscal;
    Conexao: TZConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    RemoteAppPath, Banco: String;
    EmpresaID: Integer;
  end;

var
  FDataModule: TFDataModule;

implementation

uses Biblioteca;
{$R *.lfm}

procedure TFDataModule.DataModuleCreate(Sender: TObject);
var
  ini: TIniFile;
begin
  Conexao.Connected := False;

  try
    ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Conexao.ini');
    Banco := UpperCase(ini.ReadString('SGBD', 'BD', ''));
    EmpresaID := ini.ReadInteger('SGBD', 'EMPRESA', 1);

    if Banco = 'MYSQL' then
      Conexao.Protocol := 'mysql'
    else if Banco = 'FIREBIRD' then
      Conexao.Protocol := 'firebird-2.1';

    Conexao.HostName := ini.ReadString('SGBD', 'BDHostName', '');
    Conexao.Database := ini.ReadString('SGBD', 'BDDatabase', '');
    Conexao.User := ini.ReadString('SGBD', 'BDUser', '');
    Conexao.Password := ini.ReadString('SGBD', 'BDPassword', '');

  finally
    FreeAndNil(ini);
  end;

  try
    Conexao.Connected := True;
  except
    ShowMessage('Erro ao conectar.')
  end;
end;

end.
