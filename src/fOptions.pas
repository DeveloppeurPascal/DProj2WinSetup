unit fOptions;

interface

// TODO : fill edtISPath text prompt with default InnoSetup installation path (if the program is detected)

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
    btnEBDSave: TButton;
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
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnISPathSelectClick(Sender: TObject);
    procedure btnISSaveClick(Sender: TObject);
    procedure btnISCancelClick(Sender: TObject);
    procedure btnEBSDownloadClick(Sender: TObject);
    procedure btnISDownloadClick(Sender: TObject);
    procedure btnEBSTestConnectionClick(Sender: TObject);
    procedure btnEBDSaveClick(Sender: TObject);
    procedure btnEBSCancelClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

implementation

{$R *.fmx}

uses
  uConfig, u_urlOpen;

procedure TfrmOptions.btnCloseClick(Sender: TObject);
begin
  close;
end;

procedure TfrmOptions.btnEBDSaveClick(Sender: TObject);
begin
  // TODO : à compléter
end;

procedure TfrmOptions.btnEBSCancelClick(Sender: TObject);
begin
  // TODO : à compléter
end;

procedure TfrmOptions.btnEBSDownloadClick(Sender: TObject);
begin
  url_Open_In_Browser('https://exebulksigning.olfsoftware.fr')
end;

procedure TfrmOptions.btnEBSTestConnectionClick(Sender: TObject);
begin
  // TODO : à compléter
end;

procedure TfrmOptions.btnISCancelClick(Sender: TObject);
begin
  // TODO : à compléter
end;

procedure TfrmOptions.btnISDownloadClick(Sender: TObject);
begin
  url_Open_In_Browser('https://jrsoftware.org/isinfo.php');
end;

procedure TfrmOptions.btnISPathSelectClick(Sender: TObject);
begin
  // TODO : à compléter
end;

procedure TfrmOptions.btnISSaveClick(Sender: TObject);
begin
  // TODO : à compléter
end;

procedure TfrmOptions.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // TODO : tester si des modifications sont en attente et proposer l'enregistrement ou l'abandon
end;

procedure TfrmOptions.FormCreate(Sender: TObject);
begin
  TabControl1.ActiveTab := tiExeBulkSigning;
end;

end.
