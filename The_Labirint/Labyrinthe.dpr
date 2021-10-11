program Labyrinthe;

uses
  Forms,
  ULabyrinthe in 'ULabyrinthe.pas' {FLabyrinthe},
  UHighScore in 'UHighScore.pas' {FHighScore},
  About in 'ABOUT.PAS' {AboutBox};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Labyrinthe';
  Application.CreateForm(TFLabyrinthe, FLabyrinthe);
  Application.CreateForm(TFHighScore, FHighScore);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.
