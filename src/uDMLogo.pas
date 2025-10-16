(* C2PP
  ***************************************************************************

  DProj to Windows setup

  Copyright 2024-2025 Patrick PREMARTIN under AGPL 3.0 license.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
  DEALINGS IN THE SOFTWARE.

  ***************************************************************************

  DProj2WinSetup is a generator of installation programs for Windows
  software developed under Delphi (in a recent version).

  ***************************************************************************

  Author(s) :
  Patrick PREMARTIN

  Site :
  https://dproj2winsetup.olfsoftware.fr

  Project site :
  https://github.com/DeveloppeurPascal/DProj2WinSetup

  ***************************************************************************
  File last update : 2025-10-16T15:26:00.124+02:00
  Signature : 0ccc57a886f014126c4c9d1eaac42e1de07c447a
  ***************************************************************************
*)

unit uDMLogo;

interface

uses
  System.SysUtils,
  System.Classes,
  System.ImageList,
  FMX.ImgList;

type
  TdmLogo = class(TDataModule)
    imgLogo: TImageList;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  dmLogo: TdmLogo;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

end.
