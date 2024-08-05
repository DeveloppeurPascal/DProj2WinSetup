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
/// File last update : 2024-08-05T16:17:24.000+02:00
/// Signature : 7db60e3f0b2e378c78efb135c7070cf4fff9a3e9
/// ***************************************************************************
/// </summary>

unit uDProj2WinSetupProject;

interface

uses
  Olf.RTL.DPROJReader;

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
    class function GetISPublisher32: string; static;
    class function GetISPublisher64: string; static;
    class function GetISURL32: string; static;
    class function GetISURL64: string; static;
    class procedure SetISPublisher32(const Value: string); static;
    class procedure SetISPublisher64(const Value: string); static;
    class procedure SetISURL32(const Value: string); static;
    class procedure SetISURL64(const Value: string); static;
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
    class property ISPublisher32: string read GetISPublisher32
      write SetISPublisher32;
    class property ISURL32: string read GetISURL32 write SetISURL32;
    class property ISTitle64: string read GetISTitle64 write SetISTitle64;
    class property ISVersion64: string read GetISVersion64 write SetISVersion64;
    class property ISGUID64: string read GetISGUID64 write SetISGUID64;
    class property ISPublisher64: string read GetISPublisher64
      write SetISPublisher64;
    class property ISURL64: string read GetISURL64 write SetISURL64;
    class procedure CreateFromFile(Const ADelphiProjectFileName: string);
    class procedure LoadFromFile(Const ADProj2WinSetupProjectFileName: string);
    class procedure Save;
    class procedure Close;
    class function GetDProj2WinSetupProjectFileNameFromDelphiProjectFileName
      (Const ADelphiProjectFileName: string): string;
    class function GetDelphiProjectFileNameFromDProj2WinSetupProjectFileName
      (Const ADProj2WinSetupProjectFileName: string): string;
    class function IsOpened: boolean;
    class function GetISSProjectFilePath(Const OperatingSystem: string): string;
    class function GetSetupFilePath(Const OperatingSystem: string;
      const EXESigning: boolean): string;
    class function GetProjectExecutableFileName(const OperatingSystem
      : string): string;
    class function HasPlatform(const OperatingSystem: string): boolean;
    class function HasWin32Platform: boolean;
    class function HasWin64Platform: boolean;
    class function GetFilesToDeploy(Const APlatform: string;
      Const AConfiguration: string = 'Release'): TOlfFilesToDeployList;
  end;

implementation

uses
  System.SysUtils,
  System.IOUtils,
  Olf.RTL.Params;

var
  ProjectFile: TParamsFile;
  DPROJReader: TOlfDPROJReader;

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
  DPROJReader := TOlfDPROJReader.Create(ADelphiProjectFileName);
  DPROJReader.BDSVersion := '23.0'; // TODO : à remplacer par un paramétrage
  DPROJReader.onGetPathForAliasFunc := function(Const AAlias: string): string
    begin
      if AAlias = 'SKIADIR' then
        result := 'c:\temp'
        // TODO : à remplacer par le bon chemin d'installation par défaut ou choisi par l'utilisateur dans la configuration du projet
      else
        result := '';
    end;
end;

class procedure TDProj2WinSetupProject.Close;
begin
  Freeandnil(ProjectFile);
  Freeandnil(DPROJReader);
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
    tpath.GetFileNameWithoutExtension(ADelphiProjectFileName) +
    '.dproj2winsetup');
end;

class function TDProj2WinSetupProject.GetFilesToDeploy(const APlatform,
  AConfiguration: string): TOlfFilesToDeployList;
begin
  result := DPROJReader.GetFilesToDeploy(APlatform, AConfiguration);
end;

class function TDProj2WinSetupProject.GetISGUID32: string;
begin
  result := ProjectFile.getValue('ISGuid32', '');
end;

class function TDProj2WinSetupProject.GetISGUID64: string;
begin
  result := ProjectFile.getValue('ISGuid64', '');
end;

class function TDProj2WinSetupProject.GetISPublisher32: string;
begin
  result := ProjectFile.getValue('ISPublisher32', '');
end;

class function TDProj2WinSetupProject.GetISPublisher64: string;
begin
  result := ProjectFile.getValue('ISPublisher64', '');
end;

class function TDProj2WinSetupProject.GetISSProjectFilePath
  (const OperatingSystem: string): string;
begin
  result := tpath.combine(tpath.GetTempPath,
    tpath.GetFileNameWithoutExtension(DelphiProjectFileName) + '-' +
    OperatingSystem + '-setup.iss');
end;

class function TDProj2WinSetupProject.GetISTitle32: string;
begin
  result := ProjectFile.getValue('ISTitle32', '');
end;

class function TDProj2WinSetupProject.GetISTitle64: string;
begin
  result := ProjectFile.getValue('ISTitle64', '');
end;

class function TDProj2WinSetupProject.GetISURL32: string;
begin
  result := ProjectFile.getValue('ISURL32', '');
end;

class function TDProj2WinSetupProject.GetISURL64: string;
begin
  result := ProjectFile.getValue('ISURL64', '');
end;

class function TDProj2WinSetupProject.GetISVersion32: string;
begin
  result := ProjectFile.getValue('ISVersion32', '');
end;

class function TDProj2WinSetupProject.GetISVersion64: string;
begin
  result := ProjectFile.getValue('ISVersion64', '');
end;

class function TDProj2WinSetupProject.GetProjectExecutableFileName
  (const OperatingSystem: string): string;
begin
  result := DPROJReader.GetProjectExecutable(OperatingSystem, 'Release');
end;

class function TDProj2WinSetupProject.GetSetupFilePath(const OperatingSystem
  : string; const EXESigning: boolean): string;
begin
  if EXESigning then
    result := tpath.combine(tpath.GetTempPath,
      tpath.GetFileNameWithoutExtension(DelphiProjectFileName) + '-' +
      OperatingSystem + '-setup.exe')
  else
    result := tpath.combine(tpath.GetDirectoryName(DelphiProjectFileName),
      tpath.GetFileNameWithoutExtension(DelphiProjectFileName) + '-' +
      OperatingSystem + '-setup.exe');
end;

class function TDProj2WinSetupProject.GetSignTitle: string;
begin
  result := ProjectFile.getValue('SignTitle', '');
end;

class function TDProj2WinSetupProject.GetSignURL: string;
begin
  result := ProjectFile.getValue('SignURL', '');
end;

class function TDProj2WinSetupProject.HasPlatform(const OperatingSystem
  : string): boolean;
begin
  result := DPROJReader.HasPlatform(OperatingSystem) and
    (not DPROJReader.GetProjectExecutable(OperatingSystem, 'Release').isempty);
end;

class function TDProj2WinSetupProject.HasWin32Platform: boolean;
begin
  result := HasPlatform('Win32');
end;

class function TDProj2WinSetupProject.HasWin64Platform: boolean;
begin
  result := HasPlatform('Win64');
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

class procedure TDProj2WinSetupProject.SetISPublisher32(const Value: string);
begin
  ProjectFile.setValue('ISPublisher32', Value);
end;

class procedure TDProj2WinSetupProject.SetISPublisher64(const Value: string);
begin
  ProjectFile.setValue('ISPublisher64', Value);
end;

class procedure TDProj2WinSetupProject.SetISTitle32(const Value: string);
begin
  ProjectFile.setValue('ISTitle32', Value);
end;

class procedure TDProj2WinSetupProject.SetISTitle64(const Value: string);
begin
  ProjectFile.setValue('ISTitle64', Value);
end;

class procedure TDProj2WinSetupProject.SetISURL32(const Value: string);
begin
  ProjectFile.setValue('ISURL32', Value);
end;

class procedure TDProj2WinSetupProject.SetISURL64(const Value: string);
begin
  ProjectFile.setValue('ISURL64', Value);
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
DPROJReader := nil;

finalization

TDProj2WinSetupProject.Close;

end.
