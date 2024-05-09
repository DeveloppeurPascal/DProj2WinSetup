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
  FMX.Layouts;

type
  TfrmMain = class(TForm)
    OlfAboutDialog1: TOlfAboutDialog;
    MainMenu1: TMainMenu;
    mnuFile: TMenuItem;
    mnoTools: TMenuItem;
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
  private
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
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

uses
  System.IOUtils,
  u_urlOpen,
  uConfig,
  fOptions,
  uDProj2WinSetupProject;

procedure TfrmMain.btnProjectCancelClick(Sender: TObject);
begin
  InitProjectSettings;
end;

procedure TfrmMain.btnProjectSaveClick(Sender: TObject);
begin
  SaveProjectSettings(true);
end;

procedure TfrmMain.btnWin32CancelClick(Sender: TObject);
begin
  InitWin32Settings;
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

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // TODO : à compléter
  // Tester si projet modifié ouvert ou pas et proposer son enregistrement avant d'autoriser la fermeture du programme
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  InitAboutDialogBox;
  InitMainFormCaption;
  mnuHelpAbout.Text := '&About ' + OlfAboutDialog1.Titre;
  // TODO : traduire texte
  UpdateFileMenuOptionsVisibility;
  tcScreens.TabPosition := TTabPosition.None;
  tcScreens.ActiveTab := tiHome;
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
    (edtWin32Guid.TagString <> edtWin32Guid.Text);
end;

function TfrmMain.HasWin64SettingsChanged: Boolean;
begin
  result := (edtWin64Title.TagString <> edtWin64Title.Text) or
    (edtWin64Version.TagString <> edtWin64Version.Text) or
    (edtWin64Guid.TagString <> edtWin64Guid.Text);
end;

procedure TfrmMain.InitAboutDialogBox;
begin
  // TODO : traduire texte(s)
  OlfAboutDialog1.Licence.Text :=
    'This program is distributed as shareware. If you use it (especially for ' +
    'commercial or income-generating purposes), please remember the author and '
    + 'contribute to its development by purchasing a license.' + slinebreak +
    slinebreak +
    'This software is supplied as is, with or without bugs. No warranty is offered '
    + 'as to its operation or the data processed. Make backups!';
  OlfAboutDialog1.Description.Text :=
    'DProj2WinSetup is a generator of installation programs for Windows software developed under Delphi (in a recent version).'
    + slinebreak + slinebreak + '*****************' + slinebreak +
    '* Publisher info' + slinebreak + slinebreak +
    'This application was developed by Patrick Prémartin.' + slinebreak +
    slinebreak +
    'It is published by OLF SOFTWARE, a company registered in Paris (France) under the reference 439521725.'
    + slinebreak + slinebreak + '****************' + slinebreak +
    '* Personal data' + slinebreak + slinebreak +
    'This program is autonomous in its current version. It does not depend on the Internet and communicates nothing to the outside world.'
    + slinebreak + slinebreak + 'We have no knowledge of what you do with it.' +
    slinebreak + slinebreak +
    'No information about you is transmitted to us or to any third party.' +
    slinebreak + slinebreak +
    'We use no cookies, no tracking, no stats on your use of the application.' +
    slinebreak + slinebreak + '**********************' + slinebreak +
    '* User support' + slinebreak + slinebreak +
    'If you have any questions or require additional functionality, please leave us a message on the application''s website or on its code repository.'
    + slinebreak + slinebreak +
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

    if TDProj2WinSetupProject.HasChanged then
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

  SaveWin32Settings(false);
end;

procedure TfrmMain.InitWin64Settings;
begin
  edtWin64Title.Text := TDProj2WinSetupProject.ISTitle64;
  edtWin64Version.Text := TDProj2WinSetupProject.ISVersion64;
  edtWin64Guid.Text := TDProj2WinSetupProject.ISGUID64;

  SaveWin64Settings(false);
end;

procedure TfrmMain.mnuFileCloseClick(Sender: TObject);
begin
  if TDProj2WinSetupProject.IsOpened then
  begin
    // TODO : tester si le projet a été modifié et proposer son enregistrement
    TDProj2WinSetupProject.Close;
  end;

  InitMainFormCaption;
  UpdateFileMenuOptionsVisibility;
  tcScreens.ActiveTab := tiHome;
end;

procedure TfrmMain.mnuFileOpenClick(Sender: TObject);
var
  DefaultPath: string;
  DelphiProjectFileName, DProj2WinSetupProjectFileName: string;
begin
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
  Close;
end;

procedure TfrmMain.mnuFileSaveClick(Sender: TObject);
begin
  if TDProj2WinSetupProject.IsOpened then
    TDProj2WinSetupProject.Save;
  InitMainFormCaption;
end;

procedure TfrmMain.mnuHelpAboutClick(Sender: TObject);
begin
  OlfAboutDialog1.Execute;
end;

procedure TfrmMain.mnuToolsOptionsClick(Sender: TObject);
var
  frm: TfrmOptions;
begin
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
end;

procedure TfrmMain.SaveWin32Settings(const SaveParams: Boolean);
begin
  if SaveParams then
  begin
    TDProj2WinSetupProject.ISTitle32 := edtWin32Title.Text;
    TDProj2WinSetupProject.ISVersion32 := edtWin32Version.Text;
    TDProj2WinSetupProject.ISGUID32 := edtWin32Guid.Text;
    TDProj2WinSetupProject.Save;
  end;

  edtWin32Title.TagString := edtWin32Title.Text;
  edtWin32Version.TagString := edtWin32Version.Text;
  edtWin32Guid.TagString := edtWin32Guid.Text;
end;

procedure TfrmMain.SaveWin64Settings(const SaveParams: Boolean);
begin
  if SaveParams then
  begin
    TDProj2WinSetupProject.ISTitle64 := edtWin64Title.Text;
    TDProj2WinSetupProject.ISVersion64 := edtWin64Version.Text;
    TDProj2WinSetupProject.ISGUID64 := edtWin64Guid.Text;
    TDProj2WinSetupProject.Save;
  end;

  edtWin64Title.TagString := edtWin64Title.Text;
  edtWin64Version.TagString := edtWin64Version.Text;
  edtWin64Guid.TagString := edtWin64Guid.Text;
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
