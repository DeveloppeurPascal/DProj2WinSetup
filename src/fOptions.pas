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
/// Signature : 45f7de9a19e2c7522d4abf8a86905d82876851cc
/// ***************************************************************************
/// </summary>

unit fOptions;

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
  FMX.Layouts,
  FMX.TabControl,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Edit;

type
  TfrmOptions = class(TForm)
    TabControl1: TTabControl;
    Layout1: TLayout;
    btnClose: TButton;
    tiExeBulkSigning: TTabItem;
    tiInnoSetup: TTabItem;
    vsbExeBulkSigning: TVertScrollBox;
    vsbInnoSetup: TVertScrollBox;
    lblEBSDownload: TLabel;
    lblEBSServerPort: TLabel;
    lblEBSAuthKey: TLabel;
    edtEBSServerIP: TEdit;
    edtEBSServerPort: TEdit;
    edtEBSAuthKey: TEdit;
    gplEBSSaveCancel: TGridPanelLayout;
    btnEBSSave: TButton;
    btnEBSCancel: TButton;
    btnEBSDownload: TButton;
    lblEBSServerIP: TLabel;
    btnEBSTestConnection: TButton;
    lblISDownload: TLabel;
    btnISDownload: TButton;
    lblISPath: TLabel;
    edtISPath: TEdit;
    gplISSaveCancel: TGridPanelLayout;
    btnISSave: TButton;
    btnISCancel: TButton;
    btnISPathSelect: TEllipsesEditButton;
    PasswordEditButton1: TPasswordEditButton;
    odISCC: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnISPathSelectClick(Sender: TObject);
    procedure btnISSaveClick(Sender: TObject);
    procedure btnISCancelClick(Sender: TObject);
    procedure btnEBSDownloadClick(Sender: TObject);
    procedure btnISDownloadClick(Sender: TObject);
    procedure btnEBSTestConnectionClick(Sender: TObject);
    procedure btnEBSSaveClick(Sender: TObject);
    procedure btnEBSCancelClick(Sender: TObject);
  private
    procedure InitEBSSettings;
    procedure SaveEBSSettings(Const SaveParams: Boolean);
    function HasEBSSettingsChanged: Boolean;
    procedure InitISSettings;
    procedure SaveISSettings(Const SaveParams: Boolean);
    function HasISSettingsChanged: Boolean;
  public
  end;

implementation

{$R *.fmx}

uses
  FMX.DialogService,
  System.IOUtils,
  uConfig,
  u_urlOpen,
  ExeBulkSigningClientLib;

procedure TfrmOptions.btnCloseClick(Sender: TObject);
begin
  close;
end;

procedure TfrmOptions.btnEBSSaveClick(Sender: TObject);
begin
  SaveEBSSettings(true);
end;

procedure TfrmOptions.btnEBSCancelClick(Sender: TObject);
begin
  InitEBSSettings;
end;

procedure TfrmOptions.btnEBSDownloadClick(Sender: TObject);
begin
  url_Open_In_Browser('https://exebulksigning.olfsoftware.fr')
end;

procedure TfrmOptions.btnEBSTestConnectionClick(Sender: TObject);
var
  EBSClient: TESBClient;
begin
  // TODO : à changer lorsque le ticket https://github.com/DeveloppeurPascal/ExeBulkSigning/issues/50 sera clôturé
  EBSClient := TESBClient.Create(edtEBSServerIP.Text,
    edtEBSServerPort.Text.ToInteger, edtEBSAuthKey.Text);
  try
    if EBSClient.isConnected then
      showmessage('Ok')
    else
      showmessage('Can''t connect to the server !');
  finally
    EBSClient.free;
  end;
end;

procedure TfrmOptions.btnISCancelClick(Sender: TObject);
begin
  InitISSettings;
end;

procedure TfrmOptions.btnISDownloadClick(Sender: TObject);
begin
  url_Open_In_Browser('https://jrsoftware.org/isinfo.php');
end;

procedure TfrmOptions.btnISPathSelectClick(Sender: TObject);
var
  iscc: string;
begin
  iscc := edtISPath.Text.trim;

  if iscc.IsEmpty then
    iscc := tpath.GetDirectoryName(edtISPath.TextPrompt);

  if iscc.IsEmpty then
    iscc := GetEnvironmentVariable('ProgramFiles');

  odISCC.InitialDir := iscc;

  if odISCC.Execute then
    if (odISCC.FileName <> edtISPath.TextPrompt) and string(odISCC.FileName)
      .ToLower.EndsWith('iscc.exe') then
      edtISPath.Text := odISCC.FileName
    else
      edtISPath.Text := '';
end;

procedure TfrmOptions.btnISSaveClick(Sender: TObject);
begin
  SaveISSettings(true);
end;

procedure TfrmOptions.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if HasEBSSettingsChanged or HasISSettingsChanged then
  begin
    CanClose := false;
    // TODO : traduire text
    tdialogservice.MessageDialog('Do you want to save pending changes ?',
      TMsgDlgType.mtConfirmation, mbYesNo, TMsgDlgBtn.mbYes, 0,
      procedure(Const AModalResult: TModalResult)
      begin
        if AModalResult = mryes then
        begin
          SaveEBSSettings(true);
          SaveISSettings(true);
        end
        else
        begin
          InitEBSSettings;
          InitISSettings;
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

procedure TfrmOptions.FormCreate(Sender: TObject);
begin
  TabControl1.ActiveTab := tiExeBulkSigning;

  // Global program settings
  // TODO : à compléter

  // Exe Bulk Signing Settings
  InitEBSSettings;

  // Inno Setup Settings
  edtISPath.TextPrompt := tconfig.InnoSetupCompilerPathByDefault;
  InitISSettings;
end;

function TfrmOptions.HasEBSSettingsChanged: Boolean;
begin
  result := (edtEBSServerIP.TagString <> edtEBSServerIP.Text) or
    (edtEBSServerPort.TagString <> edtEBSServerPort.Text) or
    (edtEBSAuthKey.TagString <> edtEBSAuthKey.Text);
end;

function TfrmOptions.HasISSettingsChanged: Boolean;
begin
  result := (edtISPath.TagString <> edtISPath.Text);
end;

procedure TfrmOptions.InitEBSSettings;
begin
  edtEBSServerIP.Text := tconfig.ExeBulkSigningServerIP;
  edtEBSServerPort.Text := tconfig.ExeBulkSigningServerPort.ToString;
  edtEBSAuthKey.Text := tconfig.ExeBulkSigningAuthKey;

  SaveEBSSettings(false);
end;

procedure TfrmOptions.InitISSettings;
begin
  edtISPath.Text := tconfig.InnoSetupCompilerPath;

  SaveISSettings(false);
end;

procedure TfrmOptions.SaveEBSSettings(const SaveParams: Boolean);
begin
  if SaveParams then
  begin
    tconfig.ExeBulkSigningServerIP := edtEBSServerIP.Text;
    tconfig.ExeBulkSigningServerPort := edtEBSServerPort.Text.ToInteger;
    tconfig.ExeBulkSigningAuthKey := edtEBSAuthKey.Text;
    tconfig.Save;
  end;

  edtEBSServerIP.TagString := edtEBSServerIP.Text;
  edtEBSServerPort.TagString := edtEBSServerPort.Text;
  edtEBSAuthKey.TagString := edtEBSAuthKey.Text;
end;

procedure TfrmOptions.SaveISSettings(const SaveParams: Boolean);
begin
  if SaveParams then
  begin
    tconfig.InnoSetupCompilerPath := edtISPath.Text;
    tconfig.Save;
  end;

  edtISPath.TagString := edtISPath.Text;
end;

end.
