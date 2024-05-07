unit uConfig;

interface

type
  TConfig = class
  private
    class function GetExeBulkSigningServerIP: string; static;
    class procedure SetExeBulkSigningServerIP(const Value: string); static;
    class procedure SetExeBulkSigningServerPort(const Value: word); static;
    class function GetExeBulkSigningServerPort: word; static;
    class function GetExeBulkSigningAuthKey: string; static;
    class procedure SetExeBulkSigningAuthKey(const Value: string); static;
    class procedure SetInnoSetupPath(const Value: string); static;
    class function GetInnoSetupPath: string; static;
  protected
  public
    class property ExeBulkSigningServerIP: string read GetExeBulkSigningServerIP
      write SetExeBulkSigningServerIP;
    class property ExeBulkSigningServerPort: word
      read GetExeBulkSigningServerPort write SetExeBulkSigningServerPort;
    class property ExeBulkSigningAuthKey: string read GetExeBulkSigningAuthKey
      write SetExeBulkSigningAuthKey;
    class property InnoSetupPath: string read GetInnoSetupPath
      write SetInnoSetupPath;
    class procedure Save;
    class procedure Cancel;
  end;

implementation

uses
  System.Classes,
  System.Types,
  Olf.RTL.CryptDecrypt,
  Olf.RTL.Params;

var
  ConfigFile: TParamsFile;

procedure initConfig;
begin
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

class function TConfig.GetInnoSetupPath: string;
begin
  result := ConfigFile.getValue('ISPath', '');
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

class procedure TConfig.SetInnoSetupPath(const Value: string);
begin
  ConfigFile.setValue('ISPath', Value);
end;

initialization

initConfig;

finalization

ConfigFile.free;

end.
