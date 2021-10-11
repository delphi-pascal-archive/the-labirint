unit About;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, jpeg,IniFiles, NDUtils;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    PName: TLabel;
    Version: TLabel;
    Comments: TLabel;
    OKButton: TButton;
    Auteur: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ValComments: TLabel;
    Label9: TLabel;
    Image1: TImage;
    ValVersion: TLabel;
    Panel2: TPanel;
    Label1: TLabel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Label2: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Panel6: TPanel;
    Label11: TLabel;
    procedure OKButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation

{$R *.DFM}


procedure TAboutBox.OKButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TAboutBox.FormShow(Sender: TObject);
begin
 ValVersion.Caption:= LireVersion(Application);
end;

end.
 
