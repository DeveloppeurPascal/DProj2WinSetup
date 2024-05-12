program DProj2WinSetup;

uses
  System.StartUpCopy,
  FMX.Forms,
  fMain in 'fMain.pas' {frmMain},
  Olf.FMX.AboutDialog in '..\lib-externes\AboutDialog-Delphi-Component\src\Olf.FMX.AboutDialog.pas',
  Olf.FMX.AboutDialogForm in '..\lib-externes\AboutDialog-Delphi-Component\src\Olf.FMX.AboutDialogForm.pas' {OlfAboutDialogForm},
  u_urlOpen in '..\lib-externes\librairies\src\u_urlOpen.pas',
  uDMLogo in 'uDMLogo.pas' {dmLogo: TDataModule},
  Olf.RTL.CryptDecrypt in '..\lib-externes\librairies\src\Olf.RTL.CryptDecrypt.pas',
  Olf.RTL.Params in '..\lib-externes\librairies\src\Olf.RTL.Params.pas',
  uConfig in 'uConfig.pas',
  fOptions in 'fOptions.pas' {frmOptions},
  ExeBulkSigningClientLib in '..\lib-externes\ExeBulkSigning\src\ExeBulkSigningClientLib.pas',
  ExeBulkSigningClientServerAPI in '..\lib-externes\ExeBulkSigning\src\ExeBulkSigningClientServerAPI.pas',
  Olf.RTL.FileBuffer in '..\lib-externes\librairies\src\Olf.RTL.FileBuffer.pas',
  Olf.Net.Socket.Messaging in '..\lib-externes\Socket-Messaging-Library\src\Olf.Net.Socket.Messaging.pas',
  ExeBulkSigningClientServerAPIConsts in '..\lib-externes\ExeBulkSigning\src\ExeBulkSigningClientServerAPIConsts.pas',
  Olf.RTL.GenRandomID in '..\lib-externes\librairies\src\Olf.RTL.GenRandomID.pas',
  uDProj2WinSetupProject in 'uDProj2WinSetupProject.pas',
  DosCommand in '..\lib-externes\DOSCommand\Source\DosCommand.pas',
  Olf.RTL.DPROJReader in '..\lib-externes\librairies\src\Olf.RTL.DPROJReader.pas',
  Olf.RTL.PathAliases in '..\lib-externes\librairies\src\Olf.RTL.PathAliases.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmLogo, dmLogo);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
