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
    /// <summary>
    /// Search default path for the Inno Setup Command-Line Compiler (ISCC.exe)
    /// </summary>
    procedure InitISCCDefaultPath;

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
  InitISCCDefaultPath;
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

procedure TfrmOptions.InitISCCDefaultPath;
var
  i: integer;
  ISCCCurrentPath: string;
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
    edtISPath.TextPrompt := ISCCCurrentPath
  else
    edtISPath.TextPrompt := '';
end;

procedure TfrmOptions.InitISSettings;
begin
  edtISPath.Text := tconfig.InnoSetupPath;

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
    tconfig.InnoSetupPath := edtISPath.Text;
    tconfig.Save;
  end;

  edtISPath.TagString := edtISPath.Text;
end;

end.
