{
Unité: Labyrinthe
Auteur: Gladis NDOUAB'S
Pseudo CodesSources: Diglas
e-mail: gndouabs@hotmail.de
Version 1.02 Copyrigth Juin 2010
Description: Cette unité application qui permet de trouver le chemin d'un labyrinthe.
             c'est un resolveur de labyrinthe; Projet de Timmalos(merci de l'idée)
              faites sur Freepascal que j'ai migré sur delphi.
             lien: http://www.delphifr.com/codes/GENERATION-RECHERCHE-SORTIE-LABYRINTHE_51844.aspx
}
unit ULabyrinthe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, StdCtrls, Grids, Buttons, ImgList, IniFiles, NDTypes;

       { DECLARATION DES CONSTANTES (Par Timmalos)}

Const
    Dim_X_max = 200; // Dimension X Max de la matrice(Nombre paire seulement)
    Dim_Y_max = 200; // Dimension Y Max de la matrice(Nombre paire seulement)
	  Dim_C_max = 500; // Dimension Max du NB de noeuds(Nombre paire seulement)


               { DECLARATION DES TYPES }

type
  Tlaby = Record // Type contenant le labyrinthe(Par Timmalos)
       Table: array[1..Dim_X_max,1..Dim_Y_max] of char ;
       Dim_X, Dim_Y: integer ;
       Pos_X_entree, Pos_Y_entree: integer ;
       Pos_X_sortie, Pos_Y_sortie: integer ;
  end;

	TLoutre = Record // Type contenant le chemin de la loutre (Par Timmalos)
		 Chemin: array[0..dim_C_max,1..2] of integer ;
	   Noeuds: array[1..dim_C_max,1..3] of integer ;
		 Etape, nb_noeuds: integer;
	end;

  TPoint = Record
   EX, EY:integer; //Type contenant l'abscisse et l'ordonnée d'un point de la loutre
  end;

  {Type contenant les informations contenues dans le fichier Laby.INI et les
    dimmensions du cadre Image et Form}
  TIniSave = Record
   Choix: Integer;
   DHS, DNM, EHS, ENM, IHS, INM, PHS, PNM: string;
   FHeight, FWidth: integer;
   CHeight, CWidth:integer;
  end;

  {Type contenant les informations de chaque noeud trouvé (0,0 contient le
  nombre de chemins possibles (Par Timmalos)}
	TNoeud = array[1..5,1..2] of integer;
	TGen = array[0..Dim_X_max div 2,0..Dim_Y_max div 2] of integer; // Type utilisé pour le générateur (Par Timmalos)
	TGen_final = array[1..Dim_X_max+1,1..Dim_Y_max+1] of char; // Idem (Par Timmalos)


  TFLabyrinthe = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    ValRecord: TEdit;
    ValTempEcoule: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ResolverTimer: TTimer;
    MainMenu1: TMainMenu;
    Partie1: TMenuItem;
    Nouveau1: TMenuItem;
    Debutant1: TMenuItem;
    Intermdiaire1: TMenuItem;
    Expert1: TMenuItem;
    N2: TMenuItem;
    Meilleurtemps1: TMenuItem;
    Quitter1: TMenuItem;
    N1: TMenuItem;
    BtnSolver: TSpeedButton;
    Chrono: TTimer;
    IconActuel: TImage;
    LoutreIcon: TImageList;
    N3: TMenuItem;
    Charger1: TMenuItem;
    Chargeur: TOpenDialog;
    Enregistrersous1: TMenuItem;
    procedure Debutant1Click(Sender: TObject);
    procedure Intermdiaire1Click(Sender: TObject);
    procedure Expert1Click(Sender: TObject);
    procedure Quitter1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Nouveau1Click(Sender: TObject);
    procedure ResolverTimerTimer(Sender: TObject);
    procedure BtnSolverClick(Sender: TObject);
    procedure Meilleurtemps1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ChronoTimer(Sender: TObject);
    procedure Charger1Click(Sender: TObject);
    procedure Enregistrersous1Click(Sender: TObject);
  private
    { Déclarations privées }
    procedure Direction(var msg:TMessage); message WM_KEYDOWN;
  public
    { Déclarations publiques }
    procedure charger(nom_fichier:string;var board:Tlaby);
    procedure GenerLab;
    procedure RazScore;
  end;



var
  FLabyrinthe: TFLabyrinthe;
  compteur:integer;
  TheRect:TRect;
  ValSave: TIniSave;
  MonLab:TImage;
  LActuel: TPoint;
  LManuel: array[1..dim_X_max,1..dim_Y_max] of 0..1;//contient le chemin qui se trace par l'utilisateur
  loutrefinal:TLoutre; // Variable qui contiendra le chemin de la loutre (Par Timmalos)
  main: Tlaby ;// Declaration variable contenant les infos labyrinthe (Par Timmalos)
  main_sauv: Tlaby ;//Idem a main mais ne sera pas modifiée par get_chemin() (Par Timmalos)
  	
implementation

uses UHighScore, About;

{$R *.dfm}

{Traitement des événements de touche de direction}
procedure TFLabyrinthe.Direction(var msg: TMessage);
Label fin;
begin
 if (main_sauv.pos_X_sortie = LActuel.EX)and(main_sauv.pos_Y_sortie = LActuel.EY) then goto fin;
 case msg.WParam of
  VK_LEFT: begin
            if LActuel.EX <= 1 then exit;
            if MonLab.Canvas.Pixels[(24*(LActuel.EX-2))+2, (LActuel.EY-1)*24+2] = clBlack then
             exit
            else
            begin
             if MonLab.Canvas.Pixels[(24*(LActuel.EX-2))+2, (LActuel.EY-1)*24+2] = clFuchsia then
              MonLab.Canvas.Brush.Color:= clFuchsia
             else
              MonLab.Canvas.Brush.Color:= clAqua;
             Dec(LActuel.EX);
             TheRect:= Rect((24*(LActuel.EX-1)), (LActuel.EY-1)*24, 24*LActuel.EX, 24*LActuel.EY);
             MonLab.Canvas.Rectangle(TheRect);
             if (LActuel.EX = main_sauv.pos_X_entree)and(LActuel.EY = main_sauv.pos_Y_entree) then
              FLabyrinthe.LoutreIcon.GetBitmap(2, FLabyrinthe.IconActuel.Picture.Bitmap)
             else
             FLabyrinthe.LoutreIcon.GetBitmap(0, FLabyrinthe.IconActuel.Picture.Bitmap);
             TheRect:= Rect((24*(LActuel.EX-1))+3, (LActuel.EY-1)*24+3, 24*LActuel.EX-4, 24*LActuel.EY-4);
             MonLab.Canvas.StretchDraw(TheRect, FLabyrinthe.IconActuel.Picture.Bitmap);
             if LManuel[LActuel.EX, LActuel.EY] = 1 then
             begin
              MonLab.Canvas.Brush.Color:= clSilver;
              LManuel[LActuel.EX+1, LActuel.EY]:= 0;
             end
             else
             begin
              MonLab.Canvas.Brush.Color:= clAqua;
              LManuel[LActuel.EX, LActuel.EY]:= 1;
             end;
             TheRect:= Rect(24*(LActuel.EX), (LActuel.EY-1)*24, 24*(LActuel.EX+1), 24*LActuel.EY);
             MonLab.Canvas.Rectangle(TheRect);
            end;
           end;
   VK_UP:  begin
            if LActuel.EY <= 1 then exit;
            if MonLab.Canvas.Pixels[(24*(LActuel.EX-1))+2, (LActuel.EY-2)*24+2] = clBlack then
             exit
            else
            begin
             MonLab.Canvas.Brush.Color:= clAqua;
             Dec(LActuel.EY);
             TheRect:= Rect(24*(LActuel.EX-1), (LActuel.EY-1)*24, 24*LActuel.EX, 24*LActuel.EY);
             MonLab.Canvas.Rectangle(TheRect);
             FLabyrinthe.LoutreIcon.GetBitmap(0, FLabyrinthe.IconActuel.Picture.Bitmap);
             TheRect:= Rect((24*(LActuel.EX-1))+3, (LActuel.EY-1)*24+3, 24*LActuel.EX-4, 24*LActuel.EY-4);
             MonLab.Canvas.StretchDraw(TheRect, FLabyrinthe.IconActuel.Picture.Bitmap);
             if LManuel[LActuel.EX, LActuel.EY] = 1 then
             begin
              MonLab.Canvas.Brush.Color:= clSilver;
              LManuel[LActuel.EX, LActuel.EY+1]:= 0;
             end
             else
             begin
              MonLab.Canvas.Brush.Color:= clAqua;
              LManuel[LActuel.EX, LActuel.EY]:= 1;
             end;
             TheRect:= Rect(24*(LActuel.EX-1), (LActuel.EY)*24, 24*LActuel.EX, 24*(LActuel.EY+1));
             MonLab.Canvas.Rectangle(TheRect);
            end;
           end;
  VK_RIGHT:begin
            if LActuel.EX >= main_sauv.dim_X then exit;
            if MonLab.Canvas.Pixels[(24*(LActuel.EX))+2, (LActuel.EY-1)*24+2] = clBlack then
             exit
            else
            begin
             if MonLab.Canvas.Pixels[(24*(LActuel.EX))+2, (LActuel.EY-1)*24+2] = clLime then
              MonLab.Canvas.Brush.Color:= clLime
             else
              MonLab.Canvas.Brush.Color:= clAqua;
             Inc(LActuel.EX);
             TheRect :=Rect(24*(LActuel.EX-1), (LActuel.EY-1)*24, 24*LActuel.EX, 24*LActuel.EY);
             MonLab.Canvas.Rectangle(TheRect);
             if (LActuel.EX = main_sauv.pos_X_sortie)and(LActuel.EY = main_sauv.pos_Y_sortie) then
              FLabyrinthe.LoutreIcon.GetBitmap(1, FLabyrinthe.IconActuel.Picture.Bitmap)
             else
             FLabyrinthe.LoutreIcon.GetBitmap(0, FLabyrinthe.IconActuel.Picture.Bitmap);
             TheRect:=Rect((24*(LActuel.EX-1))+3, (LActuel.EY-1)*24+3, 24*LActuel.EX-4, 24*LActuel.EY-4);
             MonLab.Canvas.StretchDraw(TheRect, FLabyrinthe.IconActuel.Picture.Bitmap);
             if LManuel[LActuel.EX, LActuel.EY] = 1 then
             begin
              MonLab.Canvas.Brush.Color:= clSilver;
              LManuel[LActuel.EX-1, LActuel.EY]:= 0;
             end
             else
             begin
              if(LActuel.EX-1 = 1)then
               MonLab.Canvas.Brush.Color:= clFuchsia
              else
               MonLab.Canvas.Brush.Color:= clAqua;
              LManuel[LActuel.EX, LActuel.EY]:= 1;
             end;
             TheRect:= Rect(24*(LActuel.EX-2), (LActuel.EY-1)*24, 24*(LActuel.EX-1), 24*LActuel.EY);
             MonLab.Canvas.Rectangle(TheRect);
            end;
           end;
  VK_DOWN: begin
            if LActuel.EY >= main_sauv.dim_Y then exit;
            if MonLab.Canvas.Pixels[(24*(LActuel.EX-1))+2, (LActuel.EY)*24+2] = clBlack then
             exit
            else
            begin
             MonLab.Canvas.Brush.Color:= clAqua;
             Inc(LActuel.EY);
             TheRect:= Rect(24*(LActuel.EX-1), (LActuel.EY-1)*24, 24*LActuel.EX, 24*LActuel.EY);
             MonLab.Canvas.Rectangle(TheRect);
             FLabyrinthe.LoutreIcon.GetBitmap(0, FLabyrinthe.IconActuel.Picture.Bitmap);
             TheRect:= Rect((24*(LActuel.EX-1))+3, (LActuel.EY-1)*24+3, 24*LActuel.EX-4, 24*LActuel.EY-4);
             MonLab.Canvas.StretchDraw(TheRect, FLabyrinthe.IconActuel.Picture.Bitmap);
             if LManuel[LActuel.EX, LActuel.EY]=1 then
             begin
              MonLab.Canvas.Brush.Color:= clSilver;
              LManuel[LActuel.EX, LActuel.EY-1]:= 0;
             end
             else
             begin
              MonLab.Canvas.Brush.Color:= clAqua;
              LManuel[LActuel.EX, LActuel.EY]:= 1;
             end;
             TheRect:= Rect(24*(LActuel.EX-1), (LActuel.EY-2)*24, 24*LActuel.EX, 24*(LActuel.EY-1));
             MonLab.Canvas.Rectangle(TheRect);
            end;
           end;
 end;

fin:
 MonLab.Update;
 if LActuel.EX = main_sauv.pos_X_entree + 1 then
  Chrono.Enabled:= true;

 {Sortie trouvée et enregistrement du record si battu}
 if(LActuel.EX = main_sauv.pos_X_sortie)and(main_sauv.Dim_X in [11,15,24])
    and(main_sauv.Dim_Y in [11,15,24])then
 begin
  Chrono.Enabled:= false;
  case ValSave.Choix of
   1:if strtoint(ValTempEcoule.Text) < strtoint(ValSave.DHS) then
     begin
      InputQuery('NOUVEAU RECORD...','Félicitation!!'#10#13'Veuillez entrez votre nom:',ValSave.DNM);
      ValSave.DHS:= ValTempEcoule.Text;
      ValRecord.Text:= ValSave.DHS;
     end;
   2:if strtoint(ValTempEcoule.Text) < strtoint(ValSave.IHS) then
     begin
      InputQuery('NOUVEAU RECORD...','Félicitation!!'#10#13'Veuillez entrez votre nom:',ValSave.INM);
      ValSave.IHS:= ValTempEcoule.Text;
      ValRecord.Text:= ValSave.IHS;
     end;
   3:if strtoint(ValTempEcoule.Text) < strtoint(ValSave.EHS) then
     begin
      InputQuery('NOUVEAU RECORD...','Félicitation!!'#10#13'Veuillez entrez votre nom:',ValSave.ENM);
      ValSave.EHS:= ValTempEcoule.Text;
      ValRecord.Text:= ValSave.EHS;
     end;
  end;
 end
 else if(LActuel.EX = main_sauv.pos_X_sortie)and not((main_sauv.Dim_X in [11,15,24])and
     (main_sauv.Dim_Y in [11,15,24]))then
  Chrono.Enabled:= false;
 inherited;// si on veut continuer à propager le message
end;

{Fonction heuristique: Cherche quelle case est la plus probable. Fonction qui
 Donne la case à choisir. Cette recherche est heuristique, on calcule la distance
  (Pythagore) entre 2 points puis on cherche le minimum, on choisira le plus
 proche, car la probabilité pour que la solution soit plus courte est plus importante}
function heuristique(const point1, point2: TPoint; const f_board: Tlaby): TPoint; //(Par Timmalos)
var p1, p2: integer;
 {Fonction heuristique: Cherche quelle case est la plus probable.
  Fonction qui calcule le minimum entre 2 valeurs.
  Used by : Fonction Heuristique}
 function minimum(const x, y: Integer): Integer; //(Par Timmalos)
 begin
  if x < y then
   result:= x
  else
   result:= y;
 end;
begin
 p1:=((point1.EX-f_board.pos_X_sortie)*(point1.EX-f_board.pos_X_sortie))+((point1.EY-f_board.pos_Y_sortie)*(point1.EY-f_board.pos_Y_sortie));
 p2:=((point2.EX-f_board.pos_X_sortie)*(point2.EX-f_board.pos_X_sortie))+((point2.EY-f_board.pos_Y_sortie)*(point2.EY-f_board.pos_Y_sortie));
 if minimum(p1, p2) = p2 then
  result:= point2
 else
  result:= point1;
end;

{Procedure get_chemin: Procedure principale qui retourne un chemin le plus court possible
 en fonction du chemin déjà parcouru par la loutre
 Elle travaille directement sur les variables board (labyrinthe) et loutre (chemin de la loutre)}
procedure get_chemin(var board: Tlaby;var loutre:TLoutre); //(Par Timmalos)
var x,y:integer;
	  nb:TNoeud;
    point,temp_point1,temp_point2:TPoint;
 {Fonction get_last_noeud: Donne le dernier noeud qui n'a pas totalement été visité
  en fonction du chemin déjà parcouru par la loutre
   Return TPoint:
  EX : X du dernier noeud
  EY : Y du dernier noeud}
 function get_last_noeud(const f_loutre: TLoutre): TPoint;//(Par Timmalos)
 var i: integer;
 begin
  i:= 0;
  Repeat
   Inc(i);
  until (f_loutre.noeuds[i, 1] = 0);
  result.EX:= f_loutre.noeuds[i-1, 1];
  result.EY:= f_loutre.noeuds[i-1, 2];
 end;
 
 {Fonction get_nb_chemins: Donne le nombre total de possibilités (Droite gauche haut bas) pour la case
  en fonction de x et y et retourne TNoeud contenant les informations
  Return TNoeud:
  [1,1] : Nb de Chemins possibles
  [i,1] (2<i<5) : Coordonnées X des chemins possibles (4 maximum)
  [i,2] (2<i<5) : Coordonnées X des chemins possibles (4 maximum)}
 function get_nb_chemins(const f_board: Tlaby; const f_x, f_y: integer): TNoeud; //(Par Timmalos)
 var nb: integer;
 begin
  nb:= 0;
  if (f_y > 1)and((f_board.table[f_x, f_y-1] = ' ')or(f_board.table[f_x, f_y-1] = 'S'))then // haut
  begin
   Inc(nb);
   result[nb+1, 1]:= f_x;
   result[nb+1, 2]:= f_y-1;
  end;
  if (f_y < f_board.dim_y)and((f_board.table[f_x, f_y+1] = ' ')or(f_board.table[f_x, f_y+1] = 'S'))then //bas
  begin
   Inc(nb);
   result[nb+1,1]:= f_x;
   result[nb+1,2]:= f_y+1;
  end;
  If (f_x > 1)and((f_board.table[f_x-1, f_y] = ' ')or(f_board.table[f_x-1, f_y] = 'S'))then //gauche
  begin
   Inc(nb);
   result[nb+1, 1]:= f_x-1;
   result[nb+1, 2]:= f_y;
  end;
  If (f_x < f_board.dim_X)and((f_board.table[f_x+1, f_y] = ' ')or(f_board.table[f_x+1, f_y] = 'S'))then //droite
  begin
   Inc(nb);
   result[nb+1, 1]:= f_x+1;
   result[nb+1, 2]:= f_y;
  end;
  result[1, 1]:= nb;
 end;
begin
 x:= board.pos_X_entree;
 y:= board.pos_Y_entree;
 loutre.etape:= 0;
 loutre.nb_noeuds:= 0;
 loutre.chemin[0, 1]:= x;
 loutre.chemin[0, 2]:= y;
 while ((x <> board.pos_X_sortie)or(y <> board.pos_Y_sortie))and(loutre.nb_noeuds >= 0) do
 begin
  nb:= get_nb_chemins(board,x,y);
  Inc(loutre.etape);
  loutre.noeuds[loutre.nb_noeuds, 3]:= loutre.noeuds[loutre.nb_noeuds, 3] + 1;

	Case nb[1, 1] of
		0:begin
			 point:= get_last_noeud(loutre);
       if (point.EX = x) and (point.EY = y) then
			 begin
				//La loutre est coincée, Elle retourne au dernier embranchement!
        loutre.noeuds[loutre.nb_noeuds+1, 1]:= 0;
        loutre.noeuds[loutre.nb_noeuds+1, 2]:= 0;
        point:= get_last_noeud(loutre);
			 end;
       board.table[x, y]:= 'C';
       loutre.chemin[loutre.etape, 1]:= point.EX;
       loutre.chemin[loutre.etape, 2]:= point.EY;
       x:= point.EX;
			 y:= point.EY;
       // Maintenant, on efface les endroits ou la loutre est allée et qui ne vaut pas.
       loutre.etape:= loutre.etape - loutre.noeuds[loutre.nb_noeuds,3];
       loutre.noeuds[loutre.nb_noeuds, 3] := 0;
       Dec(loutre.nb_noeuds);
       loutre.noeuds[loutre.nb_noeuds, 3]:= loutre.noeuds[loutre.nb_noeuds, 3] - 1;
			end;
    1:begin
       if (x = loutre.noeuds[loutre.nb_noeuds+1, 1])and(y = loutre.noeuds[loutre.nb_noeuds+1, 2])then
       begin
        Inc(loutre.nb_noeuds);
        loutre.noeuds[loutre.nb_noeuds, 3]:= loutre.noeuds[loutre.nb_noeuds, 3] + 1;
       end;
       loutre.chemin[loutre.etape, 1]:= nb[2, 1];
       loutre.chemin[loutre.etape, 2]:= nb[2, 2];
       board.table[x, y]:= 'C';
       x:= nb[2, 1];
       y:= nb[2, 2];
      end;
		2:begin
       Inc(loutre.nb_noeuds);
       loutre.noeuds[loutre.nb_noeuds, 1]:= x;
       loutre.noeuds[loutre.nb_noeuds, 2]:= y;
       temp_point1.EX:= nb[2, 1];
       temp_point1.EY:= nb[2, 2];
       temp_point2.EX:= nb[3, 1];
       temp_point2.EY:= nb[3, 2];
       point:= heuristique(temp_point1, temp_point2, board);
       loutre.chemin[loutre.etape, 1]:= point.EX;
       loutre.chemin[loutre.etape, 2]:= point.EY;
       loutre.noeuds[loutre.nb_noeuds, 3]:= loutre.noeuds[loutre.nb_noeuds, 3] + 1;
       board.table[x, y]:= 'C';
       x:= point.EX;
       y:= point.EY;
			end;
		3:begin
       Inc(loutre.nb_noeuds);
       loutre.noeuds[loutre.nb_noeuds, 1]:= x;
       loutre.noeuds[loutre.nb_noeuds, 2]:= y;
       temp_point1.EX:= nb[2, 1];
       temp_point1.EY:= nb[2, 2];
       temp_point2.EX:= nb[3, 1];
       temp_point2.EY:= nb[3, 2];
       point:= heuristique(temp_point1, temp_point2, board);
       temp_point1.EX:= point.EX;
       temp_point1.EY:= point.EY;
       temp_point2.EX:= nb[4,1];
       temp_point2.EY:= nb[4, 2];
       point:= heuristique(temp_point1, temp_point2, board);
       loutre.chemin[loutre.etape, 1]:= point.EX;
       loutre.chemin[loutre.etape, 2]:= point.EY;
       loutre.noeuds[loutre.nb_noeuds, 3]:= loutre.noeuds[loutre.nb_noeuds,3] + 1;
       board.table[x, y]:= 'C';
       x:= point.EX;
       y:= point.EY;
			end;
	end;
 end;
end;

{Procedure affichage: Procedure qui sert à afficher le labyrinthe à vide.
 Elle travaille sur une copie de la variable board (labyrinthe).}
procedure affichage(const board: Tlaby; var cadre: TImage);
var i, j: integer;
begin
 for i:= 1 to dim_X_max do
 	for j:= 1 to dim_Y_max do
   LManuel[i, j]:= 0;
 for i:= 1 to board.dim_X do
 	for j:= 1 to board.dim_Y do
	 Case board.table[i, j] of
		'E','D' :begin
              cadre.Canvas.Brush.Color:= clFuchsia;
              TheRect:= Rect(24*(i-1), (j-1)*24, 24*i, 24*j);
              cadre.Canvas.Rectangle(TheRect);
             end;
		'S'     :begin
              cadre.Canvas.Brush.Color:= clLime;
              TheRect:= Rect(24*(i-1), (j-1)*24, 24*i, 24*j);
              cadre.Canvas.Rectangle(TheRect);
             end;
		'M'     :begin
              cadre.Canvas.Brush.Color:= clBlack;
              TheRect:= Rect(24*(i-1), (j-1)*24, 24*i,24*j);
              cadre.Canvas.Rectangle(TheRect);
             end;
    else
    begin
     cadre.Canvas.Brush.Color:= clWhite;
     TheRect:= Rect(24*(i-1), (j-1)*24, 24*i, 24*j);
     cadre.Canvas.Rectangle(TheRect);
    end;
	 end;
 cadre.Canvas.Brush.Color:= cadre.Canvas.Pixels[(24*(board.pos_X_entree-1))+12, (board.pos_Y_entree-1)*24+12];
 TheRect:= Rect(24*(board.pos_X_entree-1), (board.pos_Y_entree-1)*24, 24*board.pos_X_entree, 24*board.pos_Y_entree);
 cadre.Canvas.Rectangle(TheRect);
 TheRect:= Rect((24*(board.pos_X_entree-1))+3, (board.pos_Y_entree-1)*24+3, 24*board.pos_X_entree-4, 24*board.pos_Y_entree-4);
 FLabyrinthe.LoutreIcon.GetBitmap(2, FLabyrinthe.IconActuel.Picture.Bitmap);
 cadre.Canvas.StretchDraw(TheRect, FLabyrinthe.IconActuel.Picture.Bitmap);
 LActuel.EX:= board.pos_X_entree;
 LActuel.EY:= board.pos_Y_entree;
 LManuel[LActuel.EX,LActuel.EY]:= 1;
end;

{Procedure afficher_sortie : Procedure affiche la loutre et son voyage a travers le labyrinthe.
 Notamment les tableaux de loutre.}
procedure afficher_sortie(const board: Tlaby; const loutre: TLoutre;const i: integer; var cadre:TImage);
begin
 cadre.Canvas.Brush.Color:= cadre.Canvas.Pixels[(24*(loutre.chemin[i, 1]-1))+12, (loutre.chemin[i, 2]-1)*24+12];
 TheRect:= Rect(24*(loutre.chemin[i, 1]-1), (loutre.chemin[i, 2]-1)*24, 24*loutre.chemin[i, 1], 24*loutre.chemin[i, 2]);
 cadre.Canvas.Rectangle(TheRect);
 if (loutre.chemin[i, 1] = board.pos_X_sortie)and(loutre.chemin[i, 2] = board.pos_Y_sortie) then
  FLabyrinthe.LoutreIcon.GetBitmap(1, FLabyrinthe.IconActuel.Picture.Bitmap)
 else
  FLabyrinthe.LoutreIcon.GetBitmap(0, FLabyrinthe.IconActuel.Picture.Bitmap);
 TheRect:=Rect((24*(loutre.chemin[i,1]-1))+3, (loutre.chemin[i,2]-1)*24+3, 24*loutre.chemin[i,1]-4, 24*loutre.chemin[i,2]-4);
 cadre.Canvas.StretchDraw(TheRect, FLabyrinthe.IconActuel.Picture.Bitmap);
 if (loutre.chemin[i-1, 1] <> board.pos_X_entree)or(loutre.chemin[i-1, 2] <> board.pos_Y_entree) then
 begin
  cadre.Canvas.Brush.Color:= clSkyBlue;
  TheRect:= Rect(24*(loutre.chemin[i-1,1]-1), (loutre.chemin[i-1,2]-1)*24, 24*loutre.chemin[i-1,1], 24*loutre.chemin[i-1,2]);
  cadre.Canvas.Rectangle(TheRect);
 end
 else
 begin
  cadre.Canvas.Brush.Color:= clFuchsia;
  TheRect:= Rect(24*(loutre.chemin[i-1,1]-1), (loutre.chemin[i-1,2]-1)*24, 24*loutre.chemin[i-1,1], 24*loutre.chemin[i-1,2]);
  cadre.Canvas.Rectangle(TheRect);
 end;
end;

// Fonction necessaire à l'algorithme de generation ; Cf http://ilay.org/yann/articles/maze/ Pour l'algorithme utilisé
procedure NettoieCellules(var lab:TGen; x2, y2, dim_x, dim_y, v1, v2:integer);//(Par Timmalos)
begin
 lab[x2, y2]:= v1;
 if (x2 > 0) and (lab[x2 - 1,y2] = v2) then
  NettoieCellules(lab, x2 - 1, y2, dim_x, dim_y, v1, v2);
 if (x2 < dim_x-1) and (lab[x2 + 1,y2] = v2) then
  NettoieCellules(lab, x2 + 1, y2, dim_x, dim_y, v1, v2);
 if (y2 > 0) and (lab[x2,y2 - 1] = v2) then
  NettoieCellules(lab, x2, y2 - 1, dim_X, dim_y, v1, v2);
 if (y2 < dim_y-1) and (lab[x2,y2 + 1] = v2) then
  NettoieCellules(lab, x2, y2 + 1, dim_x, dim_y, v1, v2);
end;

procedure TFLabyrinthe.charger(nom_fichier:string;var board:Tlaby);//(Par Timmalos)
const LF = chr(10);
var fichier: TextFile;
    car:char;
    i, j, sauv_j: integer;
begin
 AssignFile(fichier, nom_fichier);
 Reset(fichier);
 i:= 1;
 j:= 1;
 sauv_j:= 1;
 while not eof(fichier) do
 begin
	read(fichier, car);
	if car = LF then
	begin
	 Inc(i);
	 If j > 1 Then
		sauv_j:= j - 1;
	 j:= 1;
	end
	else
	begin
	 board.table[j, i]:= car;
	 Inc(j);
	 Case car  Of
    'D','E':begin
             board.pos_X_entree:= j - 1;
             board.pos_Y_entree:= i;
            end;
			  'S':begin
             board.pos_X_sortie:= j - 1;
             board.pos_Y_sortie:= i;
            end;
	 end;
	end;
 end;
 board.dim_X:= sauv_j - 1;
 board.dim_Y:= i - 1;
 CloseFile(fichier);
end;

{Procedure initialise : Procedure qui initialise les tableaux utilisés.
 Notamment les tableaux de loutre.}
procedure initialise(var f_loutre: TLoutre);//(Par Timmalos)
var i: integer;
begin
 for i:= 1 to dim_C_max do
 begin
  f_loutre.noeuds[i][1]:= 0;
  f_loutre.noeuds[i][2]:= 0;
  f_loutre.noeuds[i][3]:= 0;
  f_loutre.chemin[i][1]:= 0;
  f_loutre.chemin[i][2]:= 0;
 end;
end;

//Genere le fichier .slb à l'oupout rentré, de dimension voulue.
procedure generer_lab(const outpout: string; const dim: integer); //(Par Timmalos)
var lab, MH, MV: TGen;
    continue, rand, dim_x, dim_y, dim_Finale, NbMurs: integer;
    v1, v2, x1, x2, y1, y2, i, j: integer;
    rendu: TGen_final;
    fichier: text;
begin
 dim_x:= dim;
 dim_y:= dim;
 dim_Finale:= 2*dim+1;
 randomize;
 NbMurs:= 0;
 x1:= 0; x2:= 0; y1:= 0; y2:= 0;
 //Initialisation des tableaux de murs
 for i:= 0 to dim_x-1 do
	for j:= 0 to dim_y-1 do
	 lab[i, j]:= i * dim_y + j;

 for i:= 0 to dim_x-1 do
	for j:= 0 to dim_y-2 do
	 MH[i, j]:= 1;

	for i:= 0 to dim_x-2 do
	 for j:= 0 to dim_y-1 do
		MV[i, j]:= 1;
 //On va maintenant enlever nos murs 1 par 1
 while NbMurs <> (dim_x*dim_y)-1 do
 begin
	continue:= 0;
	rand:= random(2) + 1;
	Case rand of
	 1:begin//Murs Horizontaux
			x1:= random(dim_x);
			y1:= random(dim_y-1);
			if MH[x1,y1] = 1 then
			begin
			 continue:= 1;
			 x2:= x1;
			 y2:= y1 + 1	;
			end;
		 end;
	 2:begin//Murs Verticaux
			x1:= random(dim_x-1);
			y1:= random(dim_y);
			if MV[x1,y1] = 1 then
			begin
			 continue:= 1;
			 x2:= x1+1;
			 y2:= y1;
			end;
		 end;
	end;
	if continue = 1 then // (= Si un mur a été trouvé)
	begin
	 v1:= lab[x1, y1];
	 v2:= lab[x2, y2];
	 if v1 <> v2 then
	 begin
		// On enlève le mur
		Case rand of
		 1: MH[x1][y1]:= 0;
		 2: MV[x1][y1]:= 0;
		end;
		// On met la même valeur dans les cases de la chaîne
    NettoieCellules(lab, x2, y2, dim_x, dim_y, v1, v2);
    Inc(NbMurs);
	 end;
  end;
 end;
 //Maintenant, on a 2 tableaux avec des murs horizontaux et verticaux, tres facile a utiliser.
 //On doit cependant les traiter pour pouvoir creer notre tableaux de la forme souhaitée dans le TP.
 //Et ce ne fut pas une partie de plaisir.

 //On met des trous de partout
 for i:= 1 to dim_Finale do
	for j:= 1 to dim_Finale do
	 rendu[i, j]:= ' ';
 //On met des M sur la premiere et derniere ligne
 for i:= 1 to dim_Finale do
	rendu[1, i]:= 'M';
 for i:= 1 to dim_Finale do
	rendu[dim_Finale, i]:= 'M';
 //On met des M sur la premiere colonne et derniere colonne.
 for i:= 1 to dim_Finale do
 begin
	rendu[i, 1]:= 'M';
 	rendu[i, dim_Finale]:= 'M';
 end;
 // On met les murs la ou ils doivent etre en sachant que la dimension finale va etre multipliée par 2 puis additionée à 1.
 for i:= 0 to dim_x-2 do
  for j:= 0 to dim_y-1 do
   if (MV[i, j] = 1) then
   begin
    rendu[2*(i+1)+1, j*2+1]:= 'M';
    rendu[2*(i+1)+1, j*2+2]:= 'M';
    rendu[2*(i+1)+1, j*2+3]:= 'M';
   end;
 for i:= 0 to dim_x-1 do
  for j:= 0 to dim_y-2 do
    if (MH[i,j] = 1) then
    begin
     rendu[i*2+1,(j+1)*2+1]:= 'M';
     rendu[i*2+2,(j+1)*2+1]:= 'M';
     rendu[i*2+3,(j+1)*2+1]:= 'M';
    end;
 //On met l'entrée et la sortie sur les cotés du labyrinthe ou on est sur qu'il n'y a aucun mur devant.
 rendu[(random(dim_Finale div 2)+1)*2, 1]:= 'E';
 rendu[(random(dim_Finale div 2)+1)*2, dim_Finale]:= 'S';

 //On ecrit le fichier
 assignfile (fichier, outpout);
 rewrite(fichier);

 for i:= 1 to dim_Finale do
 begin
  for j:= 1 to dim_Finale do
   Write(fichier, rendu[i, j]);
  Writeln(fichier, '');
 end;
 closefile(fichier);
end;



procedure TFLabyrinthe.Debutant1Click(Sender: TObject);
begin
 ValSave.Choix:= 1;
 ValSave.FHeight:= 264;
 ValSave.FWidth:= 264;
 ValSave.CHeight:= 363;
 ValSave.CWidth:= 276;
 ValRecord.Text:= ValSave.DHS;
 Height:= ValSave.CHeight;
 Width:= ValSave.CWidth;
 Debutant1.Checked:= true;
 Intermdiaire1.Checked:= false;
 Expert1.Checked:= false;
 BtnSolver.Enabled:= true;
 GenerLab;
end;

procedure TFLabyrinthe.Intermdiaire1Click(Sender: TObject);
begin
 ValSave.Choix:= 2;
 ValSave.FHeight:= 360;
 ValSave.FWidth:= 360;
 ValSave.CHeight:= 459;
 ValSave.CWidth:= 372;
 ValRecord.Text:= ValSave.IHS;
 Height:= ValSave.CHeight;
 Width:= ValSave.CWidth;
 Debutant1.Checked:= false;
 Intermdiaire1.Checked:= true;
 Expert1.Checked:= false;
 BtnSolver.Enabled:= true;
 GenerLab;
end;

procedure TFLabyrinthe.RazScore;
begin
 if messagedlg('Êtes-vous sûr de vouloir éffacer les scores?',mtConfirmation,[mbYes,mbNo],0)=mrNo then
  exit;
 ValSave.DHS:= '999';
 ValSave.IHS:= '999';
 ValSave.EHS:= '999';
 ValSave.DNM:= 'Inconnu';
 ValSave.INM:= 'Inconnu';
 ValSave.ENM:= 'Inconnu';
 FHighScore.DScore.Caption:= ValSave.DHS + ' Secondes';
 FHighScore.IScore.Caption:= ValSave.IHS + ' Secondes';
 FHighScore.EScore.Caption:= ValSave.EHS + ' Secondes';
 FHighScore.DName.Caption:= ValSave.DNM;
 FHighScore.IName.Caption:= ValSave.INM;
 FHighScore.EName.Caption:= ValSave.ENM;
 case ValSave.Choix of
  1: ValRecord.Text:= ValSave.DHS;
  2: ValRecord.Text:= ValSave.IHS;
  3: ValRecord.Text:= ValSave.EHS;
 end;
end;

procedure TFLabyrinthe.Expert1Click(Sender: TObject);
begin
 ValSave.Choix:= 3;
 ValSave.FHeight:= 600;
 ValSave.FWidth:= 600;
 ValSave.CHeight:= 699;
 ValSave.CWidth:= 612;
 ValRecord.Text:= ValSave.EHS;
 Height:= ValSave.CHeight;
 Width:= ValSave.CWidth;
 Debutant1.Checked:= false;
 Intermdiaire1.Checked:= false;
 Expert1.Checked:= true;
 BtnSolver.Enabled:= true;
 GenerLab;
end;

procedure TFLabyrinthe.Quitter1Click(Sender: TObject);
begin
 close;
end;

procedure TFLabyrinthe.FormCreate(Sender: TObject);
var MyIniFile: TIniFile;
begin
 MyIniFile:= TIniFile.Create(ExtractFilePath(Application.ExeName)+'laby.ini');

 case MyIniFile.ReadInteger('App', 'choix', 1) of
  1:begin
     Debutant1.Checked:= true;
     Intermdiaire1.Checked:= false;
     Expert1.Checked:= false;
     ValSave.Choix:= 1;
     ValSave.FHeight:= 264;
     ValSave.FWidth:= 264;
     ValSave.CHeight:= 363;
     ValSave.CWidth:= 276;
     ValSave.DHS:= MyIniFile.ReadString('App', 'recd', '999');
     ValRecord.Text:= ValSave.DHS;
    end;
  2:begin
     Debutant1.Checked:= false;
     Intermdiaire1.Checked:= true;
     Expert1.Checked:= false;
     ValSave.Choix:= 2;
     ValSave.FHeight:= 360;
     ValSave.FWidth:= 360;
     ValSave.CHeight:= 459;
     ValSave.CWidth:= 372;
     ValSave.IHS:= MyIniFile.ReadString('App', 'reci', '999');
     ValRecord.Text:= ValSave.IHS;
    end;
  3:begin
     Debutant1.Checked:= false;
     Intermdiaire1.Checked:= false;
     Expert1.Checked:= true;
     ValSave.Choix:= 3;
     ValSave.FHeight:= 600;
     ValSave.FWidth:= 600;
     ValSave.CHeight:= 699;
     ValSave.CWidth:= 612;
     ValSave.EHS:= MyIniFile.ReadString('App', 'rece', '999');
     ValRecord.Text:= ValSave.EHS;
    end;
 end;
 ValSave.PHS:= '000';
 ValSave.DHS:= MyIniFile.ReadString('App', 'recd', '999');
 ValSave.IHS:= MyIniFile.ReadString('App', 'reci', '999');
 ValSave.EHS:= MyIniFile.ReadString('App', 'rece', '999');
 ValSave.DNM:= MyIniFile.ReadString('App', 'nmd', 'Inconnu');
 ValSave.INM:= MyIniFile.ReadString('App', 'nmi', 'Inconnu');
 ValSave.ENM:= MyIniFile.ReadString('App', 'nme', 'Inconnu');
 Height:= ValSave.CHeight;
 Width:= ValSave.CWidth;
 MyIniFile.UpdateFile;
 MyIniFile.Free;
 GenerLab;
end;

procedure TFLabyrinthe.GenerLab;
var fichier : string;
begin
 case ValSave.Choix of
  1:begin
     fichier:= 'labyrinthe_alea.slb';
		 generer_lab(fichier, 5);
    end;
  2:begin
     fichier:= 'labyrinthe_alea.slb';
		 generer_lab(fichier, 7);
    end;
  3:begin
     fichier:= 'labyrinthe_alea.slb';
		 generer_lab(fichier, 12);
    end;
 end;
 initialise(loutrefinal); // On vide toutes les arrays de la loutre
 charger(fichier, main); // On recupere le labyrinthe
 main_sauv:= main;
 MonLab:=TImage.Create(FLabyrinthe);
 RemoveComponent(MonLab);
 Panel2.InsertControl(MonLab);
 MonLab.Left:= 2;
 MonLab.Top:= 2;
 MonLab.Height:= ValSave.FHeight;
 MonLab.Width:= ValSave.FWidth;
 MonLab.Canvas.Pen.Color:= clRed;
 MonLab.Canvas.Pen.Width:= 2;
 MonLab.Visible:= true;
 MonLab.Update;
 MonLab.BringToFront;
 affichage(main_sauv, MonLab); // On affiche le labyrinthe
 BtnSolver.Enabled:= true;
 ValTempEcoule.Text:= '000';
end;

procedure TFLabyrinthe.Nouveau1Click(Sender: TObject);
begin
 case ValSave.Choix of
  1: Debutant1Click(Sender);
  2: Intermdiaire1Click(Sender);
  3: Expert1Click(Sender);
 end;
end;

procedure TFLabyrinthe.ResolverTimerTimer(Sender: TObject);
begin
 if compteur <= loutrefinal.etape then
 begin
  afficher_sortie(main_sauv, loutrefinal, compteur, MonLab); // On affiche la sortie
  Inc(compteur);
 end
 else
  ResolverTimer.Enabled:= false;
end;

procedure TFLabyrinthe.BtnSolverClick(Sender: TObject);
begin
 Chrono.Enabled:= false;
 LActuel.EX:= main_sauv.Pos_X_sortie;
 LActuel.EY:= main_sauv.Pos_Y_sortie;
 BtnSolver.Enabled:= false;
 get_chemin(main, loutrefinal); // On trouve la sortie
 compteur:= 1;
 If loutrefinal.nb_noeuds >= 0 Then // Sortie trouvée
  ResolverTimer.Enabled:= true;
end;

procedure TFLabyrinthe.Meilleurtemps1Click(Sender: TObject);
begin
 FHighScore.ShowModal;
end;

procedure TFLabyrinthe.N1Click(Sender: TObject);
begin
 AboutBox.ShowModal;
end;

procedure TFLabyrinthe.FormClose(Sender: TObject;
  var Action: TCloseAction);
var fini: TIniFile;  
begin
 fini:= TIniFile.Create(ExtractFilePath(Application.ExeName)+'Laby.ini');
 fini.WriteInteger('App', 'choix', ValSave.Choix);
 fini.WriteString('App', 'recd', ValSave.DHS);
 fini.WriteString('App', 'reci', ValSave.IHS);
 fini.WriteString('App', 'rece', ValSave.EHS);
 fini.WriteString('App', 'nmd', ValSave.DNM);
 fini.WriteString('App', 'nmi', ValSave.INM);
 fini.WriteString('App', 'nme', ValSave.ENM);
 fini.UpdateFile;
 fini.Free;
 MonLab.Free;
end;

procedure TFLabyrinthe.ChronoTimer(Sender: TObject);
var val:string;
begin
 val:= Inttostr(strtoint(ValTempEcoule.Text)+1);
 if val = '1000' then exit;
 case length(val) of
  1: ValTempEcoule.Text:= '00' + val;
  2: ValTempEcoule.Text:= '0' + val;
 else
  ValTempEcoule.Text:= val;
 end;
end;

procedure TFLabyrinthe.Charger1Click(Sender: TObject);
begin
 if Chargeur.Execute then
 begin
  initialise(loutrefinal);
  charger(Chargeur.FileName, main);
  if((main.Dim_X < Dim_X_max)and(main.Dim_X >= 5))and
    ((main.Dim_Y < Dim_Y_max)and(main.Dim_Y >= 5)) then
  begin
   main_sauv:= main;
   MonLab:=TImage.Create(FLabyrinthe);
   RemoveComponent(MonLab);
   Panel2.InsertControl(MonLab);
   MonLab.Left:= 2;
   MonLab.Top:= 2;
   ValRecord.Text:= ValSave.PHS;
   ValSave.FHeight:= 24 * main.Dim_Y;
   ValSave.FWidth:= 24 * main.Dim_X;
   ValSave.CHeight:= ValSave.FHeight + 99;
   ValSave.CWidth:= ValSave.FWidth + 12;
   MonLab.Height:= ValSave.FHeight;
   MonLab.Width:= ValSave.FWidth;
   Height:= ValSave.CHeight;
   Width:= ValSave.CWidth;
   MonLab.Canvas.Pen.Color:= clRed;
   MonLab.Canvas.Pen.Width:= 2;
   MonLab.Visible:= true;
   MonLab.Update;
   MonLab.BringToFront;
   affichage(main_sauv, MonLab);
   BtnSolver.Enabled:= true;
   ValTempEcoule.Text:= '000';
  end
  else
  case ValSave.Choix of
   1: Debutant1Click(Sender);
   2: Intermdiaire1Click(Sender);
   3: Expert1Click(Sender);
  end;
 end;
end;

procedure TFLabyrinthe.Enregistrersous1Click(Sender: TObject);
var Nom_fichier: string;
    i: integer;
    valided: boolean;
begin
 repeat
  valided:= true;
  Nom_fichier:= ' ';
  InputQuery('Sauvegarde du labyrinthe','Veuillez saisir le nom du fichier:',Nom_fichier);
  for i:= 1 to length(Nom_fichier) do
   if not(Nom_fichier[i] in ['A'..'Z','a'..'z','_','0'..'9']) then
   begin
    valided:= false;
    Showmessage('Nom de fichier invalide!');
   end;
 until (valided = true)or(Nom_fichier = ' ');
 if Nom_fichier <> ' ' then
  if FileExists(Nom_fichier+'.SLB') then
   Showmessage('Ce fichier existe deja!')
  else
  begin
   if FileIsReadOnly('labyrinthe_alea.slb') then
    FileSetReadOnly('labyrinthe_alea.slb',false);
   RenameFile('labyrinthe_alea.slb', Nom_fichier+'.SLB');
  end;
end;

end.
