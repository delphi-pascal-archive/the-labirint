unit UHighScore;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFHighScore = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DScore: TLabel;
    IScore: TLabel;
    EScore: TLabel;
    DName: TLabel;
    IName: TLabel;
    EName: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FHighScore: TFHighScore;

implementation

uses ULabyrinthe;

{$R *.dfm}

procedure TFHighScore.Button2Click(Sender: TObject);
begin
 close;
end;

procedure TFHighScore.Button1Click(Sender: TObject);
begin
 FLabyrinthe.RazScore;
end;

procedure TFHighScore.FormActivate(Sender: TObject);
begin
 FHighScore.DScore.Caption:= ValSave.DHS + ' Secondes';
 FHighScore.IScore.Caption:= ValSave.IHS + ' Secondes';
 FHighScore.EScore.Caption:= ValSave.EHS + ' Secondes';
 FHighScore.DName.Caption:= ValSave.DNM;
 FHighScore.IName.Caption:= ValSave.INM;
 FHighScore.EName.Caption:= ValSave.ENM;
end;

end.
