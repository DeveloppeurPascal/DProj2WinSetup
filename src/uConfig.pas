/// <summary>
/// ***************************************************************************
///
/// DProj to Windows setup (DProj2WinSetup)
///
/// Copyright 2024 Patrick Prémartin under AGPL 3.0 license.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
/// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
/// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
/// DEALINGS IN THE SOFTWARE.
///
/// ***************************************************************************
///
/// DProj2WinSetup is a generator of installation programs for Windows
/// software developed under Delphi (in a recent version).
///
/// ***************************************************************************
///
/// Author(s) :
/// Patrick PREMARTIN
///
/// Site :
/// https://dproj2winsetup.olfsoftware.fr/
///
/// Project site :
/// https://github.com/DeveloppeurPascal/DProj2WinSetup
///
/// ***************************************************************************
/// File last update : 2024-06-29T11:48:34.836+02:00
/// Signature : e525a00a20cad521b68837efa91610ec4c25d61f
/// ***************************************************************************
/// </summary>

unit uConfig;

interface

type
  TConfig = class
  private
    class var FInnoSetupCompilerPathByDefault: string;
    class function GetExeBulkSigningServerIP: string; static;
    class procedure SetExeBulkSigningServerIP(const Value: string); static;
    class procedure SetExeBulkSigningServerPort(const Value: word); static;
    class function GetExeBulkSigningServerPort: word; static;
    class function GetExeBulkSigningAuthKey: string; static;
    class procedure SetExeBulkSigningAuthKey(const Value: string); static;
    class procedure SetInnoSetupCompilerPath(const Value: string); static;
    class function GetInnoSetupCompilerPath: string; static;
    class function GetInnoSetupCompilerPathByDefault: string; static;
  protected
  public
    class property ExeBulkSigningServerIP: string read GetExeBulkSigningServerIP
      write SetExeBulkSigningServerIP;
    class property ExeBulkSigningServerPort: word
      read GetExeBulkSigningServerPort write SetExeBulkSigningServerPort;
    class property ExeBulkSigningAuthKey: string read GetExeBulkSigningAuthKey
      write SetExeBulkSigningAuthKey;
    class property InnoSetupCompilerPath: string read GetInnoSetupCompilerPath
      write SetInnoSetupCompilerPath;
    class property InnoSetupCompilerPathByDefault: string
      read GetInnoSetupCompilerPathByDefault;
    class procedure Save;
    class procedure Cancel;
  end;

implementation

uses
  System.Classes,
  System.IOUtils,
  System.Types,
  System.SysUtils,
  Olf.RTL.CryptDecrypt,
  Olf.RTL.Params;

var
  ConfigFile: TParamsFile;

procedure initConfig;
begin
  TConfig.FInnoSetupCompilerPathByDefault := '';

  ConfigFile := TParamsFile.Create;
  ConfigFile.InitDefaultFileNameV2('OlfSoftware', 'DProj2WinSetup', false);
{$IFDEF RELEASE }
  ConfigFile.onCryptProc := function(Const AParams: string): TStream
    var
      Keys: TByteDynArray;
      ParStream: TStringStream;
    begin
      ParStream := TStringStream.Create(AParams);
      try
{$I '..\_PRIVATE\src\ConfigFileXORKey.inc'}
        result := TOlfCryptDecrypt.XORCrypt(ParStream, Keys);
      finally
        ParStream.free;
      end;
    end;
  ConfigFile.onDecryptProc := function(Const AStream: TStream): string
    var
      Keys: TByteDynArray;
      Stream: TStream;
      StringStream: TStringStream;
    begin
{$I '..\_PRIVATE\src\ConfigFileXORKey.inc'}
      result := '';
      Stream := TOlfCryptDecrypt.XORdeCrypt(AStream, Keys);
      try
        if assigned(Stream) and (Stream.Size > 0) then
        begin
          StringStream := TStringStream.Create;
          try
            Stream.Position := 0;
            StringStream.CopyFrom(Stream);
            result := StringStream.DataString;
          finally
            StringStream.free;
          end;
        end;
      finally
        Stream.free;
      end;
    end;
{$ENDIF}
  ConfigFile.load;
end;

{ TConfig }

class procedure TConfig.Cancel;
begin
  ConfigFile.Cancel;
end;

class function TConfig.GetExeBulkSigningAuthKey: string;
begin
  result := ConfigFile.getValue('ESBAuthKey', '');
end;

class function TConfig.GetExeBulkSigningServerIP: string;
begin
  result := ConfigFile.getValue('ESBServerIP', '127.0.0.1');
end;

class function TConfig.GetExeBulkSigningServerPort: word;
begin
  result := ConfigFile.getValue('ESBServerPort', 8080);
end;

class function TConfig.GetInnoSetupCompilerPath: string;
begin
  result := ConfigFile.getValue('ISCCPath', '');
end;

class function TConfig.GetInnoSetupCompilerPathByDefault: string;
var
  i: integer;
  ISCCCurrentPath: string;
begin
  if FInnoSetupCompilerPathByDefault.IsEmpty then
  begin
    if tdirectory.Exists('C:\Program Files (Arm)') then
      for i := 9 downto 1 do
      begin
        ISCCCurrentPath := 'C:\Program Files (Arm)\Inno Setup ' + i.ToString +
          '\ISCC.exe';
        if tfile.Exists(ISCCCurrentPath) then
          break;
      end;

    if (not tfile.Exists(ISCCCurrentPath)) and
      tdirectory.Exists('C:\Program Files') then
      for i := 9 downto 1 do
      begin
        ISCCCurrentPath := 'C:\Program Files\Inno Setup ' + i.ToString +
          '\ISCC.exe';
        if tfile.Exists(ISCCCurrentPath) then
          break;
      end;

    if (not tfile.Exists(ISCCCurrentPath)) and
      tdirectory.Exists('C:\Program Files (x86)') then
      for i := 9 downto 1 do
      begin
        ISCCCurrentPath := 'C:\Program Files (x86)\Inno Setup ' + i.ToString +
          '\ISCC.exe';
        if tfile.Exists(ISCCCurrentPath) then
          break;
      end;

    if tfile.Exists(ISCCCurrentPath) then
      FInnoSetupCompilerPathByDefault := ISCCCurrentPath;
  end;
  result := FInnoSetupCompilerPathByDefault;
end;

class procedure TConfig.Save;
begin
  ConfigFile.Save;
end;

class procedure TConfig.SetExeBulkSigningAuthKey(const Value: string);
begin
  ConfigFile.setValue('ESBAuthKey', Value);
end;

class procedure TConfig.SetExeBulkSigningServerIP(const Value: string);
begin
  ConfigFile.setValue('ESBServerIP', Value);
end;

class procedure TConfig.SetExeBulkSigningServerPort(const Value: word);
begin
  ConfigFile.setValue('ESBServerPort', Value);
end;

class procedure TConfig.SetInnoSetupCompilerPath(const Value: string);
begin
  ConfigFile.setValue('ISCCPath', Value);
end;

initialization

initConfig;

finalization

ConfigFile.free;

end.
