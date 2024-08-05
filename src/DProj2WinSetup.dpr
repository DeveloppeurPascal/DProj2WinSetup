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
/// Signature : f47fb09eed0af838c7e85aae7126f5a3a39c9e1c
/// ***************************************************************************
/// </summary>

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
