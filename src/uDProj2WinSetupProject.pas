unit uDProj2WinSetupProject;

interface

type
  TDProj2WinSetupProject = class
  private
    class var FDProj2WinSetupProjectFileName: string;
    class var FDelphiProjectFileName: string;
    class procedure SetISGUID32(const Value: string); static;
    class procedure SetISGUID64(const Value: string); static;
    class procedure SetISTitle32(const Value: string); static;
    class procedure SetISTitle64(const Value: string); static;
    class procedure SetISVersion32(const Value: string); static;
    class procedure SetISVersion64(const Value: string); static;
    class procedure SetSignTitle(const Value: string); static;
    class procedure SetSignURL(const Value: string); static;
    class function GetISGUID32: string; static;
    class function GetISGUID64: string; static;
    class function GetISTitle32: string; static;
    class function GetISTitle64: string; static;
    class function GetISVersion32: string; static;
    class function GetISVersion64: string; static;
    class function GetSignTitle: string; static;
    class function GetSignURL: string; static;
  protected
  public
    class property DProj2WinSetupProjectFileName: string
      read FDProj2WinSetupProjectFileName;
    class property DelphiProjectFileName: string read FDelphiProjectFileName;
    class property SignTitle: string read GetSignTitle write SetSignTitle;
    class property SignURL: string read GetSignURL write SetSignURL;
    class property ISTitle32: string read GetISTitle32 write SetISTitle32;
    class property ISVersion32: string read GetISVersion32 write SetISVersion32;
    class property ISGUID32: string read GetISGUID32 write SetISGUID32;
    class property ISTitle64: string read GetISTitle64 write SetISTitle64;
    class property ISVersion64: string read GetISVersion64 write SetISVersion64;
    class property ISGUID64: string read GetISGUID64 write SetISGUID64;
    class procedure CreateFromFile(Const ADelphiProjectFileName: string);
    class procedure LoadFromFile(Const ADProj2WinSetupProjectFileName: string);
    class procedure Save;
    class procedure Close;
    class function GetDProj2WinSetupProjectFileNameFromDelphiProjectFileName
      (Const ADelphiProjectFileName: string): string;
    class function GetDelphiProjectFileNameFromDProj2WinSetupProjectFileName
      (Const ADProj2WinSetupProjectFileName: string): string;
    class function IsOpened: boolean;
    class function HasChanged: boolean;
  end;

implementation

uses
  System.SysUtils,
  System.IOUtils,
  Olf.RTL.Params;

var
  ProjectFile: TParamsFile;

procedure InitProjectFile(Const ADelphiProjectFileName,
  ADProj2WinSetupProjectFileName: string);
begin
  Freeandnil(ProjectFile);

  if not tfile.Exists(ADelphiProjectFileName) then
    raise exception.Create('This Delphi project Doesn''t exist !');

  TDProj2WinSetupProject.FDelphiProjectFileName := ADelphiProjectFileName;
  TDProj2WinSetupProject.FDProj2WinSetupProjectFileName :=
    ADProj2WinSetupProjectFileName;
  ProjectFile := TParamsFile.Create(ADProj2WinSetupProjectFileName);
end;

class procedure TDProj2WinSetupProject.Close;
begin
  Freeandnil(ProjectFile);
end;

class procedure TDProj2WinSetupProject.CreateFromFile
  (const ADelphiProjectFileName: string);
begin
  InitProjectFile(ADelphiProjectFileName,
    GetDProj2WinSetupProjectFileNameFromDelphiProjectFileName
    (ADelphiProjectFileName));
end;

class function TDProj2WinSetupProject.
  GetDelphiProjectFileNameFromDProj2WinSetupProjectFileName
  (const ADProj2WinSetupProjectFileName: string): string;
begin
  result := tpath.combine
    (tpath.GetDirectoryName(ADProj2WinSetupProjectFileName),
    tpath.GetFileNameWithoutExtension(ADProj2WinSetupProjectFileName) +
    '.dproj');
end;

class function TDProj2WinSetupProject.
  GetDProj2WinSetupProjectFileNameFromDelphiProjectFileName
  (Const ADelphiProjectFileName: string): string;
begin
  result := tpath.combine(tpath.GetDirectoryName(ADelphiProjectFileName),
    tpath.GetFileNameWithoutExtension(ADelphiProjectFileName) + '.dproj2setup');
end;

class function TDProj2WinSetupProject.GetISGUID32: string;
begin
  result := ProjectFile.getValue('ISGuid32', '');
end;

class function TDProj2WinSetupProject.GetISGUID64: string;
begin
  result := ProjectFile.getValue('ISGuid64', '');
end;

class function TDProj2WinSetupProject.GetISTitle32: string;
begin
  result := ProjectFile.getValue('ISTitle32', '');
end;

class function TDProj2WinSetupProject.GetISTitle64: string;
begin
  result := ProjectFile.getValue('ISTitle64', '');
end;

class function TDProj2WinSetupProject.GetISVersion32: string;
begin
  result := ProjectFile.getValue('ISVersion32', '');
end;

class function TDProj2WinSetupProject.GetISVersion64: string;
begin
  result := ProjectFile.getValue('ISVersion64', '');
end;

class function TDProj2WinSetupProject.GetSignTitle: string;
begin
  result := ProjectFile.getValue('SignTitle', '');
end;

class function TDProj2WinSetupProject.GetSignURL: string;
begin
  result := ProjectFile.getValue('SignURL', '');
end;

class function TDProj2WinSetupProject.HasChanged: boolean;
begin
  // TODO : à prendre en charge lorsque le ticket https://github.com/DeveloppeurPascal/librairies/issues/86 aura été traité
  // Result := ProjectFileName.HasChanged;
  result := false;
end;

class function TDProj2WinSetupProject.IsOpened: boolean;
begin
  result := assigned(ProjectFile);
end;

class procedure TDProj2WinSetupProject.LoadFromFile
  (const ADProj2WinSetupProjectFileName: string);
begin
  if not tfile.Exists(ADProj2WinSetupProjectFileName) then
    raise exception.Create('This Delphi WinSetup project Doesn''t exist !');

  InitProjectFile(GetDelphiProjectFileNameFromDProj2WinSetupProjectFileName
    (ADProj2WinSetupProjectFileName), ADProj2WinSetupProjectFileName);
  ProjectFile.load;
end;

class procedure TDProj2WinSetupProject.Save;
begin
  ProjectFile.Save;
end;

class procedure TDProj2WinSetupProject.SetISGUID32(const Value: string);
begin
  ProjectFile.setValue('ISGuid32', Value);
end;

class procedure TDProj2WinSetupProject.SetISGUID64(const Value: string);
begin
  ProjectFile.setValue('ISGuid64', Value);
end;

class procedure TDProj2WinSetupProject.SetISTitle32(const Value: string);
begin
  ProjectFile.setValue('ISTitle32', Value);
end;

class procedure TDProj2WinSetupProject.SetISTitle64(const Value: string);
begin
  ProjectFile.setValue('ISTitle64', Value);
end;

class procedure TDProj2WinSetupProject.SetISVersion32(const Value: string);
begin
  ProjectFile.setValue('ISVersion32', Value);
end;

class procedure TDProj2WinSetupProject.SetISVersion64(const Value: string);
begin
  ProjectFile.setValue('ISVersion64', Value);
end;

class procedure TDProj2WinSetupProject.SetSignTitle(const Value: string);
begin
  ProjectFile.setValue('SignTitle', Value);
end;

class procedure TDProj2WinSetupProject.SetSignURL(const Value: string);
begin
  ProjectFile.setValue('SignURL', Value);
end;

initialization

ProjectFile := nil;

finalization

TDProj2WinSetupProject.Close;

end.
