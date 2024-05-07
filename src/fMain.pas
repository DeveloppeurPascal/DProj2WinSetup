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
  FMX.Menus;

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
    procedure FormCreate(Sender: TObject);
    procedure OlfAboutDialog1URLClick(const AURL: string);
    procedure mnuToolsOptionsClick(Sender: TObject);
    procedure mnuFileCloseClick(Sender: TObject);
    procedure mnuFileOpenClick(Sender: TObject);
    procedure mnuFileQuitClick(Sender: TObject);
    procedure mnuFileSaveClick(Sender: TObject);
    procedure mnuHelpAboutClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
  public
    procedure InitMainFormCaption;
    procedure InitAboutDialogBox;
    procedure UpdateFileMenuOptionsVisibility;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

uses
  u_urlOpen,
  uConfig,
  fOptions;

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
  caption := caption + OlfAboutDialog1.Titre + ' v' +
    OlfAboutDialog1.VersionNumero;
  // TODO : ajouter nom du projet ouvert s'il y en a un (éventuellement son statut de modification)
end;

procedure TfrmMain.mnuFileCloseClick(Sender: TObject);
begin
  // TODO : à compléter
  // si projet avec modifications en cours, proposer son enregistrement avant (ou le faire par défaut)
  // TODO : recalculer le titre de la fenêtre
  UpdateFileMenuOptionsVisibility;
end;

procedure TfrmMain.mnuFileOpenClick(Sender: TObject);
begin
  // TODO : à compléter
  // Open a DPROJ and/or DPROJ2Setup file
  // TODO : recalculer le titre de la fenêtre
  UpdateFileMenuOptionsVisibility;
end;

procedure TfrmMain.mnuFileQuitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.mnuFileSaveClick(Sender: TObject);
begin
  // TODO : à compléter
  // TODO : recalculer le titre de la fenêtre
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

procedure TfrmMain.UpdateFileMenuOptionsVisibility;
begin
  // TODO : replace "False" by a test of current opened project
  mnuFileSave.Enabled := false;
  mnuFileClose.Enabled := false;
end;

initialization

{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := true;
{$ENDIF}

end.
