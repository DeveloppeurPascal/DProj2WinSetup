unit fMain;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  Olf.FMX.AboutDialog,
  uDMLogo,
  FMX.StdCtrls,
  FMX.Controls.Presentation,
  FMX.Edit,
  FMX.Menus,
  FMX.TabControl,
  FMX.Layouts,
  FMX.Objects;

type
  TfrmMain = class(TForm)
    OlfAboutDialog1: TOlfAboutDialog;
    MainMenu1: TMainMenu;
    mnuFile: TMenuItem;
    mnuTools: TMenuItem;
    mnuFileOpen: TMenuItem;
    mnuFileSave: TMenuItem;
    mnuFileClose: TMenuItem;
    mnuSeparator: TMenuItem;
    mnuHelp: TMenuItem;
    mnuToolsOptions: TMenuItem;
    mnuHelpAbout: TMenuItem;
    mnuFileQuit: TMenuItem;
    tcScreens: TTabControl;
    tiHome: TTabItem;
    tiProject: TTabItem;
    btnProjectOpen: TButton;
    OpenDialog1: TOpenDialog;
    tcProject: TTabControl;
    tiProjectOptions: TTabItem;
    tiSetupWin32: TTabItem;
    tiSetupWin64: TTabItem;
    lblSignTitle: TLabel;
    edtSignTitle: TEdit;
    lblSignURL: TLabel;
    edtSignURL: TEdit;
    lblWin32Title: TLabel;
    lblWin32Version: TLabel;
    lblWin32Guid: TLabel;
    edtWin32Title: TEdit;
    edtWin32Guid: TEdit;
    edtWin32Version: TEdit;
    edtWin64Title: TEdit;
    edtWin64Guid: TEdit;
    edtWin64Version: TEdit;
    lblWin64Title: TLabel;
    lblWin64Version: TLabel;
    lblWin64Guid: TLabel;
    GridPanelLayout1: TGridPanelLayout;
    btnProjectSave: TButton;
    btnProjectCancel: TButton;
    GridPanelLayout2: TGridPanelLayout;
    btnWin32Save: TButton;
    btnWin32Cancel: TButton;
    GridPanelLayout3: TGridPanelLayout;
    btnWin64Save: TButton;
    btnWin64Cancel: TButton;
    btnWin32GuidGenerate: TEditButton;
    btnWin64GuidGenerate: TEditButton;
    btnSendToExeBulkSigning: TButton;
    lBlockScreen: TLayout;
    rBlockScreen: TRectangle;
    aniBlockScreen: TAniIndicator;
    btnSignInnoSetupProgramWin32: TButton;
    btnCompileISSWin32: TButton;
    btnGenerateISSWin32: TButton;
    btnCompileISSWin64: TButton;
    btnGenerateISSWin64: TButton;
    btnSignInnoSetupProgram64: TButton;
    lblWin64Publisher: TLabel;
    edtWin64Publisher: TEdit;
    lblWin64URL: TLabel;
    edtWin64URL: TEdit;
    edtWin32Publisher: TEdit;
    edtWin32URL: TEdit;
    lblWin32Publisher: TLabel;
    lblWin32URL: TLabel;
    btnSignEXEAndGenerateSetup: TButton;
    procedure FormCreate(Sender: TObject);
    procedure OlfAboutDialog1URLClick(const AURL: string);
    procedure mnuToolsOptionsClick(Sender: TObject);
    procedure mnuFileCloseClick(Sender: TObject);
    procedure mnuFileOpenClick(Sender: TObject);
    procedure mnuFileQuitClick(Sender: TObject);
    procedure mnuFileSaveClick(Sender: TObject);
    procedure mnuHelpAboutClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnProjectSaveClick(Sender: TObject);
    procedure btnProjectCancelClick(Sender: TObject);
    procedure btnWin32CancelClick(Sender: TObject);
    procedure btnWin32SaveClick(Sender: TObject);
    procedure btnWin64CancelClick(Sender: TObject);
    procedure btnWin64SaveClick(Sender: TObject);
    procedure btnWin64GuidGenerateClick(Sender: TObject);
    procedure btnWin32GuidGenerateClick(Sender: TObject);
    procedure btnSendToExeBulkSigningClick(Sender: TObject);
    procedure btnGenerateISSWin32Click(Sender: TObject);
    procedure btnGenerateISSWin64Click(Sender: TObject);
    procedure btnCompileISSWin64Click(Sender: TObject);
    procedure btnCompileISSWin32Click(Sender: TObject);
    procedure btnSignInnoSetupProgramWin32Click(Sender: TObject);
    procedure btnSignInnoSetupProgram64Click(Sender: TObject);
    procedure btnSignEXEAndGenerateSetupClick(Sender: TObject);
  private
  protected
    procedure DoEditChange(Sender: TObject);
  public
    procedure InitMainFormCaption;
    procedure InitAboutDialogBox;
    procedure UpdateFileMenuOptionsVisibility;
    procedure InitProjectSettings;
    procedure SaveProjectSettings(Const SaveParams: Boolean);
    function HasProjectSettingsChanged: Boolean;
    procedure InitWin32Settings;
    procedure SaveWin32Settings(Const SaveParams: Boolean);
    function HasWin32SettingsChanged: Boolean;
    procedure InitWin64Settings;
    procedure SaveWin64Settings(Const SaveParams: Boolean);
    function HasWin64SettingsChanged: Boolean;
    function HasProjectChanged: Boolean;
    procedure ReplaceCurrentGuidByANewOne(Const edt: TEdit);
    procedure BlockScreen(Const AEnabled: Boolean);
    procedure SignProjectExecutables(Const onSuccess: TProc;
      Const onError: TProc = nil);
    procedure GenerateISSProject(Const OperatingSystem: string;
      Const onSuccess: TProc; Const onError: TProc = nil);
    procedure CompileISSProject(Const OperatingSystem: string;
      Const onSuccess: TProc; Const onError: TProc = nil);
    procedure SignSetupExecutables(Const OperatingSystem: string;
      Const onSuccess: TProc; Const onError: TProc = nil);
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

uses
  FMX.DialogService,
  System.IOUtils,
  u_urlOpen,
  uConfig,
  fOptions,
  uDProj2WinSetupProject,
  ExeBulkSigningClientLib,
  DosCommand,
  Olf.RTL.DPROJReader;

procedure TfrmMain.BlockScreen(const AEnabled: Boolean);
begin
  if AEnabled then
  begin
    lBlockScreen.Visible := true;
    lBlockScreen.BringToFront;
    rBlockScreen.BringToFront;
    aniBlockScreen.Enabled := true;
    aniBlockScreen.BringToFront;
    tcScreens.Enabled := false;
  end
  else
  begin
    aniBlockScreen.Enabled := false;
    lBlockScreen.Visible := false;
    tcScreens.Enabled := true;
  end;
end;

procedure TfrmMain.btnCompileISSWin32Click(Sender: TObject);
begin
  BlockScreen(true);
  try
    CompileISSProject('Win32',
      procedure
      begin
        BlockScreen(false);
      end,
      procedure
      begin
        BlockScreen(false);
      end);
  except
    BlockScreen(false);
  end;
end;

procedure TfrmMain.btnCompileISSWin64Click(Sender: TObject);
begin
  BlockScreen(true);
  try
    CompileISSProject('Win64',
      procedure
      begin
        BlockScreen(false);
      end,
      procedure
      begin
        BlockScreen(false);
      end);
  except
    BlockScreen(false);
  end;
end;

procedure TfrmMain.btnGenerateISSWin32Click(Sender: TObject);
begin
  BlockScreen(true);
  try
    GenerateISSProject('Win32',
      procedure
      begin
        BlockScreen(false);
      end,
      procedure
      begin
        BlockScreen(false);
      end);
  except
    BlockScreen(false);
  end;
end;

procedure TfrmMain.btnGenerateISSWin64Click(Sender: TObject);
begin
  BlockScreen(true);
  try
    GenerateISSProject('Win64',
      procedure
      begin
        BlockScreen(false);
      end,
      procedure
      begin
        BlockScreen(false);
      end);
  except
    BlockScreen(false);
  end;
end;

procedure TfrmMain.btnProjectCancelClick(Sender: TObject);
begin
  InitProjectSettings;
end;

procedure TfrmMain.btnProjectSaveClick(Sender: TObject);
begin
  SaveProjectSettings(true);
end;

procedure TfrmMain.btnSendToExeBulkSigningClick(Sender: TObject);
begin
  BlockScreen(true);
  try
    SignProjectExecutables(
      procedure
      begin
        BlockScreen(false);
      end,
      procedure
      begin
        BlockScreen(false);
      end);
  except
    BlockScreen(false);
  end;
end;

procedure TfrmMain.btnSignEXEAndGenerateSetupClick(Sender: TObject);
begin
  BlockScreen(true);
  try
    SignProjectExecutables(
      procedure
      begin
        GenerateISSProject('Win32',
          procedure
          begin
            GenerateISSProject('Win64',
              procedure
              begin
                CompileISSProject('Win32',
                  procedure
                  begin
                    CompileISSProject('Win64',
                      procedure
                      begin
                        SignSetupExecutables('Win32',
                          procedure
                          begin
                            SignSetupExecutables('Win64',
                              procedure
                              begin
                                ShowMessage('Opération terminée');
                                BlockScreen(false);
                              end,
                              procedure
                              begin
                                BlockScreen(false);
                              end);
                          end,
                          procedure
                          begin
                            BlockScreen(false);
                          end);
                      end,
                      procedure
                      begin
                        BlockScreen(false);
                      end);
                  end,
                  procedure
                  begin
                    BlockScreen(false);
                  end);
              end,
              procedure
              begin
                BlockScreen(false);
              end);
          end,
          procedure
          begin
            BlockScreen(false);
          end);
      end,
      procedure
      begin
        BlockScreen(false);
      end);
  except
    BlockScreen(false);
  end;
end;

procedure TfrmMain.btnSignInnoSetupProgram64Click(Sender: TObject);
begin
  BlockScreen(true);
  try
    SignSetupExecutables('Win64',
      procedure
      begin
        BlockScreen(false);
      end,
      procedure
      begin
        BlockScreen(false);
      end);
  except
    BlockScreen(false);
  end;
end;

procedure TfrmMain.btnSignInnoSetupProgramWin32Click(Sender: TObject);
begin
  BlockScreen(true);
  try
    SignSetupExecutables('Win32',
      procedure
      begin
        BlockScreen(false);
      end,
      procedure
      begin
        BlockScreen(false);
      end);
  except
    BlockScreen(false);
  end;
end;

procedure TfrmMain.btnWin32CancelClick(Sender: TObject);
begin
  InitWin32Settings;
end;

procedure TfrmMain.btnWin32GuidGenerateClick(Sender: TObject);
begin
  ReplaceCurrentGuidByANewOne(edtWin32Guid);
end;

procedure TfrmMain.btnWin32SaveClick(Sender: TObject);
begin
  SaveWin32Settings(true);
end;

procedure TfrmMain.btnWin64CancelClick(Sender: TObject);
begin
  InitWin64Settings;
end;

procedure TfrmMain.btnWin64SaveClick(Sender: TObject);
begin
  SaveWin64Settings(true);
end;

procedure TfrmMain.CompileISSProject(const OperatingSystem: string;
const onSuccess, onError: TProc);
begin
  if TDProj2WinSetupProject.HasPlatform(OperatingSystem) then
    try
      tthread.CreateAnonymousThread(
        procedure
        var
          ISSFilePath, SetupFilePath, ISCCPath: string;
          InnoSetupCompileCmd: string;
          DosCommand: TDosCommand;
        begin
          try
            ISSFilePath := TDProj2WinSetupProject.GetISSProjectFilePath
              (OperatingSystem);
            if not tfile.Exists(ISSFilePath) then
              raise exception.Create('Inno Setup Script file for ' +
                OperatingSystem + ' doesn''t exist !');

            SetupFilePath := TDProj2WinSetupProject.GetSetupFilePath
              (OperatingSystem);
            if tfile.Exists(SetupFilePath) then
              tfile.delete(SetupFilePath);

            if not tconfig.InnoSetupCompilerPath.IsEmpty then
              ISCCPath := tconfig.InnoSetupCompilerPath
            else if not tconfig.InnoSetupCompilerPathByDefault.IsEmpty then
              ISCCPath := tconfig.InnoSetupCompilerPathByDefault
            else
              raise exception.Create
                ('Please define where ISCC.exe is located in the menu Tools/Options/Inno Setup');

            // Exemple de commande pour compiler un script Inno Setup en ligne de commande :
            // "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" /O+ "/OC:\DossierDeDestination" "/FNomDuSetupEXESansExtension" /Q "C:\CheminVersScriptInnoSetupACompiler.iss"
            InnoSetupCompileCmd := '"' + ISCCPath + '" /O+ "/O' +
              tpath.GetDirectoryName(SetupFilePath) + '" /F' +
              tpath.GetFileNameWithoutExtension(SetupFilePath) + ' "' +
              ISSFilePath + '"';
            // /Q (quiet) a été retiré au cas où l'absence de sortie de ISCC perturbe DosCommand entrainant un plantage (cf https://github.com/DeveloppeurPascal/DProj2WinSetup/issues/39 )

            DosCommand := TDosCommand.Create(nil);
            try
              DosCommand.CommandLine := InnoSetupCompileCmd;
              DosCommand.InputToOutput := false;
              DosCommand.Execute;

              while DosCommand.IsRunning and
                (DosCommand.EndStatus = TEndStatus.esStill_Active) do
                sleep(100);
            finally
              DosCommand.Free;
            end;

            if tfile.Exists(SetupFilePath) then
            begin
{$IFDEF RELEASE}
              if tfile.Exists(ISSFilePath) then
                tfile.delete(ISSFilePath);
{$ENDIF}
              if assigned(onSuccess) then
                tthread.queue(nil,
                  procedure
                  begin
                    onSuccess;
                  end);
            end
            else if assigned(onError) then
              tthread.queue(nil,
                procedure
                begin
                  onError;
                end);
          except
            if assigned(onError) then
              tthread.queue(nil,
                procedure
                begin
                  onError;
                end);
          end;
        end).start;
    except
      if assigned(onError) then
        onError;
    end
  else if assigned(onSuccess) then
    tthread.queue(nil,
      procedure
      begin
        onSuccess;
      end);
end;

procedure TfrmMain.DoEditChange(Sender: TObject);
begin
  InitMainFormCaption;
end;

procedure TfrmMain.btnWin64GuidGenerateClick(Sender: TObject);
begin
  ReplaceCurrentGuidByANewOne(edtWin64Guid);
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if (tcScreens.ActiveTab = tiProject) and HasProjectChanged then
  begin
    CanClose := false;
    // TODO : traduire text
    tdialogservice.MessageDialog('Do you want to save pending changes ?',
      TMsgDlgType.mtConfirmation, mbYesNo, TMsgDlgBtn.mbYes, 0,
      procedure(Const AModalResult: TModalResult)
      begin
        if AModalResult = mryes then
        begin
          SaveProjectSettings(true);
          SaveWin32Settings(true);
          SaveWin64Settings(true);
        end
        else
        begin
          InitProjectSettings;
          InitWin32Settings;
          InitWin64Settings;
        end;
        tthread.forcequeue(nil,
          procedure
          begin
            close;
          end);
      end);
  end
  else
    CanClose := true;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  i: integer;
begin
  BlockScreen(false);
  InitAboutDialogBox;
  InitMainFormCaption;

  mnuHelpAbout.Text := '&About ' + OlfAboutDialog1.Titre;
  // TODO : traduire texte

  UpdateFileMenuOptionsVisibility;

  tcScreens.TabPosition := TTabPosition.None;
  tcScreens.ActiveTab := tiHome;

  btnProjectOpen.SetFocus;

  for i := 0 to ComponentCount - 1 do
    if (components[i] is TEdit) then
      (components[i] as TEdit).OnChange := DoEditChange;
end;

procedure TfrmMain.GenerateISSProject(const OperatingSystem: string;
const onSuccess, onError: TProc);
begin
  if TDProj2WinSetupProject.HasPlatform(OperatingSystem) then
    try
      tthread.CreateAnonymousThread(
        procedure
        var
          ISScript: string;
          s: string;
          Publisher: string;
          FilesToDeploy: TOlfFilesToDeployList;
          i: integer;
        begin
          try
            ISScript :=
              '; Generated by DProj2WinSetup (https://dproj2winsetup.olfsoftware.fr/)'
              + sLineBreak;
            ISScript := ISScript +
              '; Don''t change anything there, it will be erase next time !' +
              sLineBreak;
            ISScript := ISScript + '; Generation date : ' + DateTimeToStr(now) +
              sLineBreak;
            ISScript := ISScript + sLineBreak;
            if (OperatingSystem = 'Win32') and
              not TDProj2WinSetupProject.ISTitle32.IsEmpty then
              s := TDProj2WinSetupProject.ISTitle32
            else if (OperatingSystem = 'Win64') and
              not TDProj2WinSetupProject.ISTitle64.IsEmpty then
              s := TDProj2WinSetupProject.ISTitle64
            else
              s := TDProj2WinSetupProject.SignTitle;
            ISScript := ISScript + '#define MyAppName "' + s + '"' + sLineBreak;
            if (OperatingSystem = 'Win32') then
              s := TDProj2WinSetupProject.ISVersion32
            else if (OperatingSystem = 'Win64') then
              s := TDProj2WinSetupProject.ISVersion64
            else
              s := '';
            ISScript := ISScript + '#define MyAppVersion "' + s + '"' +
              sLineBreak;
            if (OperatingSystem = 'Win32') then
              Publisher := TDProj2WinSetupProject.ISPublisher32
            else if (OperatingSystem = 'Win64') then
              Publisher := TDProj2WinSetupProject.ISPublisher64
            else
              Publisher := '';
            if not Publisher.IsEmpty then
              ISScript := ISScript + '#define MyAppPublisher "' + Publisher +
                '"' + sLineBreak;
            if (OperatingSystem = 'Win32') and
              not TDProj2WinSetupProject.ISURL32.IsEmpty then
              s := TDProj2WinSetupProject.ISURL32
            else if (OperatingSystem = 'Win64') and
              not TDProj2WinSetupProject.ISURL64.IsEmpty then
              s := TDProj2WinSetupProject.ISURL64
            else
              s := TDProj2WinSetupProject.SignURL;
            ISScript := ISScript + '#define MyAppURL "' + s + '"' + sLineBreak;
            ISScript := ISScript + '#define MyAppExeName "' +
              tpath.GetFileName
              (TDProj2WinSetupProject.GetProjectExecutableFileName
              (OperatingSystem)) + '"' + sLineBreak;

            ISScript := ISScript + '[Setup]' + sLineBreak;
            if (OperatingSystem = 'Win32') then
              s := TDProj2WinSetupProject.ISGUID32
            else if (OperatingSystem = 'Win64') then
              s := TDProj2WinSetupProject.ISGUID64
            else
              raise exception.Create('No GUID specified for ' + OperatingSystem
                + ' setup.');
            ISScript := ISScript + 'AppId={' + s + sLineBreak;
            ISScript := ISScript + 'AppName={#MyAppName}' + sLineBreak;
            ISScript := ISScript + 'AppVersion={#MyAppVersion}' + sLineBreak;
            if not Publisher.IsEmpty then
            begin
              ISScript := ISScript + 'AppPublisher={#MyAppPublisher}' +
                sLineBreak;
              ISScript := ISScript + 'AppPublisherURL={#MyAppURL}' + sLineBreak;
            end;
            ISScript := ISScript + 'AppSupportURL={#MyAppURL}' + sLineBreak;
            ISScript := ISScript + 'AppUpdatesURL={#MyAppURL}' + sLineBreak;
            if Publisher.IsEmpty then
              ISScript := ISScript + 'DefaultDirName={autopf}\{#MyAppName}' +
                sLineBreak
            else
              ISScript := ISScript +
                'DefaultDirName={autopf}\{#MyAppPublisher}\{#MyAppName}' +
                sLineBreak;
            ISScript := ISScript + 'DisableProgramGroupPage=yes' + sLineBreak;
            ISScript := ISScript + 'PrivilegesRequired=lowest' + sLineBreak;
            ISScript := ISScript + 'PrivilegesRequiredOverridesAllowed=dialog' +
              sLineBreak;
            ISScript := ISScript + 'OutputDir=' + tpath.GetDirectoryName
              (TDProj2WinSetupProject.GetSetupFilePath(OperatingSystem)) +
              sLineBreak;
            ISScript := ISScript + 'OutputBaseFilename=' +
              tpath.GetFileNameWithoutExtension
              (TDProj2WinSetupProject.GetSetupFilePath(OperatingSystem)) +
              sLineBreak;
            ISScript := ISScript + 'Compression=lzma' + sLineBreak;
            ISScript := ISScript + 'SolidCompression=yes' + sLineBreak;
            ISScript := ISScript + 'WizardStyle=modern' + sLineBreak;

            if OperatingSystem = 'Win64' then
            begin
              ISScript := ISScript + 'ArchitecturesAllowed=x64 arm64 ia64' +
                sLineBreak;
              ISScript := ISScript +
                'ArchitecturesInstallIn64BitMode=x64 arm64 ia64' + sLineBreak;
            end;

            ISScript := ISScript + '[Languages]' + sLineBreak;
            ISScript := ISScript +
              'Name: "english"; MessagesFile: "compiler:Default.isl"' +
              sLineBreak;
            ISScript := ISScript +
              'Name: "french"; MessagesFile: "compiler:Languages\French.isl"' +
              sLineBreak;

            ISScript := ISScript + '[Tasks]' + sLineBreak;
            ISScript := ISScript +
              'Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked'
              + sLineBreak;

            ISScript := ISScript + '[Files]' + sLineBreak;
            FilesToDeploy := TDProj2WinSetupProject.GetFilesToDeploy
              (OperatingSystem, 'Release');
            try
              for i := 0 to FilesToDeploy.count - 1 do
                if tfile.Exists(tpath.combine(FilesToDeploy[i].Frompath,
                  FilesToDeploy[i].FromFileName)) then
                begin
                  if FilesToDeploy[i].FromFileName = tpath.GetFileName
                    (TDProj2WinSetupProject.GetProjectExecutableFileName
                    (OperatingSystem)) then
                    FilesToDeploy[i].FromFileName :=
                      tpath.GetFileNameWithoutExtension(FilesToDeploy[i]
                      .FromFileName) + '-signed.exe';
                  ISScript := ISScript + 'Source: "' +
                    tpath.combine(FilesToDeploy[i].Frompath,
                    FilesToDeploy[i].FromFileName) + '";';

                  if FilesToDeploy[i].ToPath.IsEmpty then
                    ISScript := ISScript + ' DestDir: "{app}";'
                  else
                    ISScript := ISScript + ' DestDir: "{app}\"' + FilesToDeploy
                      [i].ToPath;

                  ISScript := ISScript + ' DestName: "' + FilesToDeploy[i]
                    .ToFileName + '";';

                  if FilesToDeploy[i].Overwrite then
                    ISScript := ISScript + ' Flags: ignoreversion'
                  else
                    ISScript := ISScript +
                      ' Flags: ignoreversion onlyifdoesntexist';

                  ISScript := ISScript + sLineBreak;
                end
                else
                begin
                  // TODO : signaler l'absence du fichier détecté (permet de passer outre les fichiers conditionnés comme SKIA dans une v1.0 du programme)
                end;
            finally
              FilesToDeploy.Free;
            end;

            ISScript := ISScript + '[Icons]' + sLineBreak;
            ISScript := ISScript +
              'Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"'
              + sLineBreak;
            ISScript := ISScript +
              'Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon'
              + sLineBreak;

            ISScript := ISScript + '[Run]' + sLineBreak;
            ISScript := ISScript +
              'Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, ''&'', ''&&'')}}"; Flags: nowait postinstall skipifsilent'
              + sLineBreak;

            tfile.WriteAllText(TDProj2WinSetupProject.GetISSProjectFilePath
              (OperatingSystem), ISScript, TEncoding.UTF8);

            if assigned(onSuccess) then
              tthread.queue(nil,
                procedure
                begin
                  onSuccess;
                end);
          except
            if assigned(onError) then
              tthread.queue(nil,
                procedure
                begin
                  onError;
                end);
          end;
        end).start;
    except
      if assigned(onError) then
        onError;
    end
  else if assigned(onSuccess) then
    tthread.queue(nil,
      procedure
      begin
        onSuccess;
      end);
end;

function TfrmMain.HasProjectChanged: Boolean;
begin
  result := HasProjectSettingsChanged or HasWin32SettingsChanged or
    HasWin64SettingsChanged;
end;

function TfrmMain.HasProjectSettingsChanged: Boolean;
begin
  result := (edtSignTitle.TagString <> edtSignTitle.Text) or
    (edtSignURL.TagString <> edtSignURL.Text);
end;

function TfrmMain.HasWin32SettingsChanged: Boolean;
begin
  result := (edtWin32Title.TagString <> edtWin32Title.Text) or
    (edtWin32Version.TagString <> edtWin32Version.Text) or
    (edtWin32Guid.TagString <> edtWin32Guid.Text) or
    (edtWin32Publisher.TagString <> edtWin32Publisher.Text) or
    (edtWin32URL.TagString <> edtWin32URL.Text);
end;

function TfrmMain.HasWin64SettingsChanged: Boolean;
begin
  result := (edtWin64Title.TagString <> edtWin64Title.Text) or
    (edtWin64Version.TagString <> edtWin64Version.Text) or
    (edtWin64Guid.TagString <> edtWin64Guid.Text) or
    (edtWin64Publisher.TagString <> edtWin64Publisher.Text) or
    (edtWin64URL.TagString <> edtWin64URL.Text);
end;

procedure TfrmMain.InitAboutDialogBox;
begin
  // TODO : traduire texte(s)
  OlfAboutDialog1.Licence.Text :=
    'This program is distributed as shareware. If you use it (especially for ' +
    'commercial or income-generating purposes), please remember the author and '
    + 'contribute to its development by purchasing a license.' + sLineBreak +
    sLineBreak +
    'This software is supplied as is, with or without bugs. No warranty is offered '
    + 'as to its operation or the data processed. Make backups!';
  OlfAboutDialog1.Description.Text :=
    'DProj2WinSetup is a generator of installation programs for Windows software developed under Delphi (in a recent version).'
    + sLineBreak + sLineBreak + '*****************' + sLineBreak +
    '* Publisher info' + sLineBreak + sLineBreak +
    'This application was developed by Patrick Prémartin.' + sLineBreak +
    sLineBreak +
    'It is published by OLF SOFTWARE, a company registered in Paris (France) under the reference 439521725.'
    + sLineBreak + sLineBreak + '****************' + sLineBreak +
    '* Personal data' + sLineBreak + sLineBreak +
    'This program is autonomous in its current version. It does not depend on the Internet and communicates nothing to the outside world.'
    + sLineBreak + sLineBreak + 'We have no knowledge of what you do with it.' +
    sLineBreak + sLineBreak +
    'No information about you is transmitted to us or to any third party.' +
    sLineBreak + sLineBreak +
    'We use no cookies, no tracking, no stats on your use of the application.' +
    sLineBreak + sLineBreak + '**********************' + sLineBreak +
    '* User support' + sLineBreak + sLineBreak +
    'If you have any questions or require additional functionality, please leave us a message on the application''s website or on its code repository.'
    + sLineBreak + sLineBreak +
    'To find out more, visit https://dproj2winsetup.olfsoftware.fr';
end;

procedure TfrmMain.InitMainFormCaption;
begin
{$IFDEF DEBUG}
  caption := '[DEBUG] ';
{$ELSE}
  caption := '';
{$ENDIF}
  if TDProj2WinSetupProject.IsOpened then
  begin
    caption := caption + tpath.GetFileNameWithoutExtension
      (TDProj2WinSetupProject.DProj2WinSetupProjectFileName);

    if HasProjectChanged then
      caption := caption + ' (*) ';

    caption := caption + ' - ';
  end;

  caption := caption + OlfAboutDialog1.Titre + ' v' +
    OlfAboutDialog1.VersionNumero;
end;

procedure TfrmMain.InitProjectSettings;
begin
  edtSignTitle.Text := TDProj2WinSetupProject.SignTitle;
  edtSignURL.Text := TDProj2WinSetupProject.SignURL;

  SaveProjectSettings(false);
end;

procedure TfrmMain.InitWin32Settings;
begin
  edtWin32Title.Text := TDProj2WinSetupProject.ISTitle32;
  edtWin32Version.Text := TDProj2WinSetupProject.ISVersion32;
  edtWin32Guid.Text := TDProj2WinSetupProject.ISGUID32;
  edtWin32Publisher.Text := TDProj2WinSetupProject.ISPublisher32;
  edtWin32URL.Text := TDProj2WinSetupProject.ISURL32;

  SaveWin32Settings(false);
end;

procedure TfrmMain.InitWin64Settings;
begin
  edtWin64Title.Text := TDProj2WinSetupProject.ISTitle64;
  edtWin64Version.Text := TDProj2WinSetupProject.ISVersion64;
  edtWin64Guid.Text := TDProj2WinSetupProject.ISGUID64;
  edtWin64Publisher.Text := TDProj2WinSetupProject.ISPublisher64;
  edtWin64URL.Text := TDProj2WinSetupProject.ISURL64;

  SaveWin64Settings(false);
end;

procedure TfrmMain.mnuFileCloseClick(Sender: TObject);
begin
  if lBlockScreen.Visible then
    exit;

  if TDProj2WinSetupProject.IsOpened and HasProjectChanged then
    // TODO : traduire text
    tdialogservice.MessageDialog('Do you want to save pending changes ?',
      TMsgDlgType.mtConfirmation, mbYesNo, TMsgDlgBtn.mbYes, 0,
      procedure(Const AModalResult: TModalResult)
      begin
        if AModalResult = mryes then
        begin
          SaveProjectSettings(true);
          SaveWin32Settings(true);
          SaveWin64Settings(true);
        end
        else
        begin
          InitProjectSettings;
          InitWin32Settings;
          InitWin64Settings;
        end;
        mnuFileCloseClick(Sender);
      end)
  else
  begin
    TDProj2WinSetupProject.close;
    InitMainFormCaption;
    UpdateFileMenuOptionsVisibility;
    tcScreens.ActiveTab := tiHome;
  end;
end;

procedure TfrmMain.mnuFileOpenClick(Sender: TObject);
var
  DefaultPath: string;
  DelphiProjectFileName, DProj2WinSetupProjectFileName: string;
begin
  if lBlockScreen.Visible then
    exit;

  if TDProj2WinSetupProject.IsOpened then
    mnuFileCloseClick(Sender);

  OpenDialog1.FileName := '';

  if OpenDialog1.InitialDir.IsEmpty then
  begin
    // TODO : utiliser le chemin par défaut préféré de l'utilisateur
    DefaultPath := tpath.combine([tpath.GetDocumentsPath, 'Embarcadero',
      'Studio', 'Projects']);
    if not TDirectory.Exists(DefaultPath) then
      DefaultPath := tpath.combine([tpath.GetDocumentsPath, 'Embarcadero',
        'Studio', 'Projets']);
    if not TDirectory.Exists(DefaultPath) then
      DefaultPath := tpath.combine([tpath.GetDocumentsPath, 'Embarcadero',
        'Studio']);
    if not TDirectory.Exists(DefaultPath) then
      DefaultPath := tpath.GetDocumentsPath;
    OpenDialog1.InitialDir := DefaultPath;
  end;

  if OpenDialog1.Execute then
  begin
    DelphiProjectFileName := OpenDialog1.FileName;
    if not(tpath.GetExtension(DelphiProjectFileName).ToLower = '.dproj') then
      raise exception.Create
        ('This file is not a Delphi project options file !');

    if not tfile.Exists(DelphiProjectFileName) then
      raise exception.Create('This project doesn''t exist !');

    // TODO : voir si nécessaire de conserver le dernier projet ou dossier ouvert pour le suivant
    OpenDialog1.InitialDir := tpath.GetDirectoryName(DelphiProjectFileName);

    DProj2WinSetupProjectFileName :=
      TDProj2WinSetupProject.
      GetDProj2WinSetupProjectFileNameFromDelphiProjectFileName
      (DelphiProjectFileName);
    if tfile.Exists(DProj2WinSetupProjectFileName) then
      TDProj2WinSetupProject.LoadFromFile(DProj2WinSetupProjectFileName)
    else
      TDProj2WinSetupProject.CreateFromFile(DelphiProjectFileName);

    tiSetupWin32.Visible := TDProj2WinSetupProject.HasWin32Platform;
    tiSetupWin64.Visible := TDProj2WinSetupProject.HasWin64Platform;
  end;

  if TDProj2WinSetupProject.IsOpened then
  begin
    InitMainFormCaption;
    tcScreens.ActiveTab := tiProject;
    tcProject.ActiveTab := tiProjectOptions;
    InitProjectSettings;
    InitWin32Settings;
    InitWin64Settings;
  end
  else
    tcScreens.ActiveTab := tiHome;
  UpdateFileMenuOptionsVisibility;
end;

procedure TfrmMain.mnuFileQuitClick(Sender: TObject);
begin
  if lBlockScreen.Visible then
    exit;

  close;
end;

procedure TfrmMain.mnuFileSaveClick(Sender: TObject);
begin
  if lBlockScreen.Visible then
    exit;

  if TDProj2WinSetupProject.IsOpened and HasProjectChanged then
  begin
    SaveProjectSettings(true);
    SaveWin32Settings(true);
    SaveWin64Settings(true);
    InitMainFormCaption;
  end;
end;

procedure TfrmMain.mnuHelpAboutClick(Sender: TObject);
begin
  if lBlockScreen.Visible then
    exit;

  OlfAboutDialog1.Execute;
end;

procedure TfrmMain.mnuToolsOptionsClick(Sender: TObject);
var
  frm: TfrmOptions;
begin
  if lBlockScreen.Visible then
    exit;

  frm := TfrmOptions.Create(self);
  try
    frm.ShowModal;
  finally
    frm.Free;
  end;
end;

procedure TfrmMain.OlfAboutDialog1URLClick(const AURL: string);
begin
  url_Open_In_Browser(AURL);
end;

procedure TfrmMain.ReplaceCurrentGuidByANewOne(const edt: TEdit);
begin
  if edt.Text.IsEmpty then
    edt.Text := TGUID.NewGuid.ToString
  else
    tdialogservice.MessageDialog('Do you want to replace current GUID ?',
      TMsgDlgType.mtConfirmation, mbYesNo, TMsgDlgBtn.mbYes, 0,
      procedure(Const AModalResult: TModalResult)
      begin
        if AModalResult = mryes then
          edt.Text := TGUID.NewGuid.ToString;
      end);
end;

procedure TfrmMain.SaveProjectSettings(const SaveParams: Boolean);
begin
  if SaveParams then
  begin
    TDProj2WinSetupProject.SignTitle := edtSignTitle.Text;
    TDProj2WinSetupProject.SignURL := edtSignURL.Text;
    TDProj2WinSetupProject.Save;
  end;

  edtSignTitle.TagString := edtSignTitle.Text;
  edtSignURL.TagString := edtSignURL.Text;

  InitMainFormCaption;
end;

procedure TfrmMain.SaveWin32Settings(const SaveParams: Boolean);
begin
  if SaveParams then
  begin
    TDProj2WinSetupProject.ISTitle32 := edtWin32Title.Text;
    TDProj2WinSetupProject.ISVersion32 := edtWin32Version.Text;
    TDProj2WinSetupProject.ISGUID32 := edtWin32Guid.Text;
    TDProj2WinSetupProject.ISPublisher32 := edtWin32Publisher.Text;
    TDProj2WinSetupProject.ISURL32 := edtWin32URL.Text;
    TDProj2WinSetupProject.Save;
  end;

  edtWin32Title.TagString := edtWin32Title.Text;
  edtWin32Version.TagString := edtWin32Version.Text;
  edtWin32Guid.TagString := edtWin32Guid.Text;
  edtWin32Publisher.TagString := edtWin32Publisher.Text;
  edtWin32URL.TagString := edtWin32URL.Text;

  InitMainFormCaption;
end;

procedure TfrmMain.SaveWin64Settings(const SaveParams: Boolean);
begin
  if SaveParams then
  begin
    TDProj2WinSetupProject.ISTitle64 := edtWin64Title.Text;
    TDProj2WinSetupProject.ISVersion64 := edtWin64Version.Text;
    TDProj2WinSetupProject.ISGUID64 := edtWin64Guid.Text;
    TDProj2WinSetupProject.ISPublisher64 := edtWin64Publisher.Text;
    TDProj2WinSetupProject.ISURL64 := edtWin64URL.Text;
    TDProj2WinSetupProject.Save;
  end;

  edtWin64Title.TagString := edtWin64Title.Text;
  edtWin64Version.TagString := edtWin64Version.Text;
  edtWin64Guid.TagString := edtWin64Guid.Text;
  edtWin64Publisher.TagString := edtWin64Publisher.Text;
  edtWin64URL.TagString := edtWin64URL.Text;

  InitMainFormCaption;
end;

procedure TfrmMain.SignProjectExecutables(Const onSuccess, onError: TProc);
begin
  try
    tthread.CreateAnonymousThread(
      procedure
      var
        EBSClient: TESBClient;
        ExeFileName: string;
      begin
        try
          EBSClient := TESBClient.Create(tconfig.ExeBulkSigningServerIP,
            tconfig.ExeBulkSigningServerPort, tconfig.ExeBulkSigningAuthKey);
          try
            if TDProj2WinSetupProject.HasWin32Platform then
            begin
              ExeFileName :=
                TDProj2WinSetupProject.GetProjectExecutableFileName('Win32');
              if tfile.Exists(ExeFileName) then
                EBSClient.SendFileToServer(TDProj2WinSetupProject.SignTitle,
                  TDProj2WinSetupProject.SignURL, ExeFileName);
            end;
            if TDProj2WinSetupProject.HasWin64Platform then
            begin
              ExeFileName :=
                TDProj2WinSetupProject.GetProjectExecutableFileName('Win64');
              if tfile.Exists(ExeFileName) then
                EBSClient.SendFileToServer(TDProj2WinSetupProject.SignTitle,
                  TDProj2WinSetupProject.SignURL, ExeFileName);
            end;
            while (EBSClient.HasWaitingFiles > 0) do
              sleep(1000);
          finally
            EBSClient.Free;
          end;
          if assigned(onSuccess) then
            tthread.queue(nil,
              procedure
              begin
                onSuccess;
              end);
        except
          if assigned(onError) then
            tthread.queue(nil,
              procedure
              begin
                onError;
              end);
        end;
      end).start;
  except
    if assigned(onError) then
      onError;
  end;
end;

procedure TfrmMain.SignSetupExecutables(const OperatingSystem: string;
const onSuccess, onError: TProc);
begin
  if TDProj2WinSetupProject.HasPlatform(OperatingSystem) then
    try
      tthread.CreateAnonymousThread(
        procedure
        var
          EBSClient: TESBClient;
          SetupFilePath, SignedSetupFilePath, FinalSetupFilePath,
            FinalSetupFilePathWithoutSignedText: string;
        begin
          try
            EBSClient := TESBClient.Create(tconfig.ExeBulkSigningServerIP,
              tconfig.ExeBulkSigningServerPort, tconfig.ExeBulkSigningAuthKey);
            try
              SetupFilePath := TDProj2WinSetupProject.GetSetupFilePath
                (OperatingSystem);
              if tfile.Exists(SetupFilePath) then
                EBSClient.SendFileToServer(TDProj2WinSetupProject.SignTitle +
                  ' (' + OperatingSystem + ' setup)',
                  TDProj2WinSetupProject.SignURL, SetupFilePath);

              while (EBSClient.HasWaitingFiles > 0) do
                sleep(1000);
            finally
              EBSClient.Free;
            end;
            SignedSetupFilePath :=
              tpath.combine(tpath.GetDirectoryName(SetupFilePath),
              tpath.GetFileNameWithoutExtension(SetupFilePath) + '-signed.exe');
            if tfile.Exists(SignedSetupFilePath) then
            begin
              FinalSetupFilePath :=
                tpath.combine(tpath.GetDirectoryName
                (TDProj2WinSetupProject.DelphiProjectFileName),
                tpath.GetFileNameWithoutExtension(SignedSetupFilePath)
                + '.exe');
              if tfile.Exists(FinalSetupFilePath) then
                tfile.delete(FinalSetupFilePath);
              tfile.Move(SignedSetupFilePath, FinalSetupFilePath);
              FinalSetupFilePathWithoutSignedText :=
                FinalSetupFilePath.Replace('-signed.exe', '.exe');
              if tfile.Exists(FinalSetupFilePathWithoutSignedText) then
                tfile.delete(FinalSetupFilePathWithoutSignedText);
              tfile.Move(FinalSetupFilePath,
                FinalSetupFilePathWithoutSignedText);
{$IFDEF RELEASE}
              if tfile.Exists(SetupFilePath) then
                tfile.delete(SetupFilePath);
{$ENDIF}
              if assigned(onSuccess) then
                tthread.queue(nil,
                  procedure
                  begin
                    onSuccess;
                  end);
            end
            else if assigned(onError) then
              tthread.queue(nil,
                procedure
                begin
                  onError;
                end);
          except
            if assigned(onError) then
              tthread.queue(nil,
                procedure
                begin
                  onError;
                end);
          end;
        end).start;
    except
      if assigned(onError) then
        onError;
    end
  else if assigned(onSuccess) then
    tthread.queue(nil,
      procedure
      begin
        onSuccess;
      end);
end;

procedure TfrmMain.UpdateFileMenuOptionsVisibility;
begin
  mnuFileSave.Enabled := TDProj2WinSetupProject.IsOpened;
  mnuFileClose.Enabled := TDProj2WinSetupProject.IsOpened;
end;

initialization

{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := true;
{$ENDIF}

end.
