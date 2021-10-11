{
Unité: NDUtils
Auteur: Gladis NDOUAB'S
Pseudo CodesSources: Diglas
e-mail: gndouabs@hotmail.de
Version 1 Copyrigth Janvier 2010
Description: Cette unité regroupe toutes les méthodes utiles pour les projets de NDSoft.
}
unit NDUtils;

interface

uses Windows, SysUtils, Classes, ShellAPI, NDMD5Utils, Forms, mmSystem, NDTypes;

  { Calcule la taille du buffer à louer pour copier une donnée
    avec la taille de la donnée en entrée }
  function GetNeedBufSize(const ObjetSize: Int64	):Integer;
  { Determination de la lettre du disque d'installation de Windows }
  Function GetWinDisk :string;
  { Retourne l'espace disponible d'un lecteur disque }              
  function GetDiskSize(const lecteur: String): int64;
  {*******Trouver le n° de série d'un disque.******
    RepertoireRacine : par exemple 'c' ou 'd'}
  Function NumSerieDisque(const RepertoireRacine:String):DWord;
  { Determination du repertoire Windows }
  Function GetWinDir :string;
  { Determination du repertoire system32 }
  function GetSysDir:string;
  {Genere la clé de licence}
  function GenereKey(AppKey: string):string;
  {*Empêcher le lancement du même programme deux fois à la fois*}
  procedure ExecuteOnce(source:TApplication);
  {*Lecture de la version de l'application en cours*}
  function LireVersion(source:TApplication): string;
  {* Allocation pour la recherche de la version de l'application en cours*}
  function Version(source:TApplication): string;
  { Cryptage d'une chaine de caractère }
  function CrypterT(const chaine,key:string):string;
  { Cryptage d'un fichier par TextFile }
  function CrypterF(const fileIn,fileOut,key: string): Boolean;
  { Génerateur du nom de dossier a partir d'un nom}
  function NameGenerate(const name:string):string;
  {Ouvre le tiroir du lecteur optique indiqué par DriveLetter}
  procedure OpenDoor(const DriveLetter: Char);
  {Ferme le tiroir du lecteur optique indiqué par DriveLetter}
  procedure CloseDoor(const DriveLetter: Char);
  {Renvoi les informations à propos d'un CD/DVD inséré dans le lecteur "Drive"}
  function GetInfosCD(const Drive: string): TInfosCD;
  {Convertie une valeur Octets en ses differents multiples (Ko,Mo,Go,...)}
  function ConversionOctets (const Valeur: Extended; Source, Destination: TUnitesOctet ): string;
  {Convertie les octets en un multiple automatiquement}
  function OctetAutoConvert(const Value:  Extended): string;
  {Efface un dossier (repertoire) non vide}
  function EffaceDossier(Dossier: string; titre:string):Boolean;
  {Trouve le programme avec lequel s'ouvre ce fichier}
  function FindExec(const sFile: String): String;
  {Bloque(True)/Débloque(False) le clavier et la sourie}
  function BlockInputA(BlockIt:Bool):Bool;overload;StdCall;External 'USER32.DLL' Name 'BlockInput';
  {Bloque le clavier et la sourie pendant nbSec second}
  procedure Blockinput(const nbSec: Cardinal);overload;


implementation



procedure Blockinput(const nbSec: Cardinal);
begin
 BlockinputA(True);
 sleep(nbSec*1000);
 BlockinputA(False);
end;

function GetNeedBufSize(const ObjetSize: Int64	):Integer;
var
  MS: TMemoryStatus;
begin
 Result:= 0;
 if ObjetSize = 0 then exit;
 GlobalMemoryStatus(MS);
 if (ObjetSize div 1024) < 1 then
  Result:= 256
 else if (ObjetSize div 1024) <= 5 then
  Result:= 512
 else if ((ObjetSize div 1024) div 1024) <= 5 then
  Result:= 1024
 else if ((ObjetSize div 1024) div 1024) > 50 then
  Result:= 843776
 else Result:= 421888;
end;

Function GetWinDisk :string;
var Dossier: ARRAY [0..MAX_PATH] OF char;
begin
  if GetWindowsDirectory(Dossier,SizeOf(Dossier))<>0 then Result:=string(Dossier[0]);
end;

function GetDiskSize(const lecteur: String): int64;
Var Drive: Array[0..255] Of char;
    TailleDisque: int64;
Begin
 Try
  TailleDisque := 0;
  strPCopy(Drive, lecteur[1]+':\');
  GetDiskFreeSpaceEx(Drive, Result, TailleDisque, Nil);
 Except
  Result := 0;
 End;
End;

Function NumSerieDisque(const RepertoireRacine:String):DWord;
var Repertoire:PChar;
    NomVolume: array[0..255] of char;
    NumSerie:DWORD;
    LongeurMaxNomFichier:DWORD;
    TypeCase:DWORD;
    FileSystem: array[0..255] of char;
begin
 Repertoire:=PChar(RepertoireRacine[1]+':\');
 if not GetVolumeInformation(Repertoire,NomVolume,SizeOf(NomVolume),@NumSerie,
                LongeurMaxNomFichier,TypeCase, FileSystem,sizeOf(FileSystem))then
  Result:=0
 else Result:=NumSerie;
end;

Function GetWinDir :string;
var Dossier: ARRAY [0..MAX_PATH] OF char;
begin
  if GetWindowsDirectory (Dossier,SizeOf(Dossier))<>0 then Result:=string(Dossier)+'\';
end;

function GetSysDir:string;
var Dossier: ARRAY [0..MAX_PATH] OF char;
begin
  if GetSystemDirectory (Dossier,SizeOf(Dossier))<>0 then Result:=string(Dossier)+'\';
end;

function GenereKey(AppKey: string):string;
var Tmp, Chaine: string;
    i: Integer;
begin
 Chaine:= '';
 Tmp:= UpperCase(MD5T(AppKey));
{change A en G, B en H, C en J, D en K, E en X et F en Y}
 for i:= 1 to length(tmp) do
  case Tmp[i] of
   'A': Chaine:= Chaine + 'G';
   'B': Chaine:= Chaine + 'H';
   'C': Chaine:= Chaine + 'J';
   'D': Chaine:= Chaine + 'K';
   'E': Chaine:= Chaine + 'X';
   'F': Chaine:= Chaine + 'Y';
  else Chaine:= Chaine + Tmp[i];
  end;
 Insert('-', Chaine,9);
 Insert('-', Chaine,18);
 Insert('-', Chaine,27);
 Result:= Chaine;
end;

procedure OpenDoor(const DriveLetter: Char);
var AliasName, st: string;
begin
  AliasName := 'Laufwerk' + DriveLetter;
  st :=  'Open ' + DriveLetter + ': Alias ' + AliasName + ' Type CDAudio';
  mciSendString(@st[1], nil, 0, 0);
  st := 'Set ' + AliasName + ' Door Open';
  mciSendString(@st[1], nil, 0, 0);
end;

procedure CloseDoor(const DriveLetter: Char);
var AliasName, st: string;
begin
 AliasName := 'Laufwerk' + DriveLetter;
 st :=  'Open ' + DriveLetter + ': Alias ' + AliasName + ' Type CDAudio';
 mciSendString(@st[1], nil, 0, 0 );
 st := 'Set ' + AliasName +' Door Closed';
 mciSendString(@st[1], nil, 0, 0);
end;

function GetInfosCD(const Drive: string): TInfosCD;
var Long, Flags : DWord; // nécéssaire seulement pour GetVolumeInformation
    Lettre: Char;
    FreeBytesAvailable: TLargeInteger;
begin
 Lettre:=Drive[1];
{Initialisation}
 Result.Drive:='#';
 Result.Name:='';
 Result.SystemFile:='';
 Result.Hachage:='';
 Result.SerialNummer:=0;
 Result.FreeSpace:=0;
 Result.TotalSpace:=0; 
 {On sort de la fonction si le lecteur n'est pas optique(CD/DVD)}
 if GetDriveType(PChar(Lettre+':\')) <> DRIVE_CDROM then exit;
 {on récupère les informations du volume sélectionné}
 GetVolumeInformation(PChar(Lettre+':\')
                         ,@Result.Name,SizeOf(Result.Name)
                         ,@Result.SerialNummer
                         ,Long
                         ,Flags
                         ,@Result.SystemFile,SizeOf(Result.SystemFile));
 Result.Drive:=Lettre;
{On recupere les infos d'espace disque s'il y a un disque dans le lecteur optique sélectionné}
 if Result.SerialNummer <> 0 then
  GetDiskFreeSpaceEx(PChar(Lettre+':\'),FreeBytesAvailable, Result.TotalSpace, @Result.FreeSpace);
{On calcule le Hash du disque}
 Result.Hachage:=uppercase(MD5T(format('%s%d%s%s%s',[Result.Name,Result.SerialNummer,
                                           Result.SystemFile,IntToStr(Result.FreeSpace),
                                           IntToStr(Result.TotalSpace)])));
end;

function ConversionOctets (const Valeur: Extended; Source, Destination: TUnitesOctet ): string;
var EnOctets : Extended ;
    Resultat : Extended ;
begin
 EnOctets:= Valeur;
 Resultat:= EnOctets;
 {Conversion de la valeur source en octets si "Valeur" n'est pas en octets}
 case Source of
   uOctet: EnOctets:= Valeur;
   uKilo:  EnOctets:= Valeur * KILOOCTET;
   uMega:  EnOctets:= Valeur * MEGAOCTET;
   uGiga:  EnOctets:= Valeur * GIGAOCTET;
   uTera:  EnOctets:= Valeur * TERAOCTET;
 end ;

 //Conversion de la valeur dans l'unité souhaitées
 case Destination of
   uOctet: Resultat:= EnOctets;
   uKilo:  Resultat:= EnOctets / KILOOCTET;
   uMega:  Resultat:= EnOctets / MEGAOCTET;
   uGiga:  Resultat:= EnOctets / GIGAOCTET;
   uTera:  Resultat:= EnOctets / TERAOCTET;
 end ;

 // Formattage de la chaine de sortie}
 Result := Format( '%.2f ' + UNITES_OCTET[Destination], [Resultat] ) ;
end;

function OctetAutoConvert(const Value:  Extended): string;
var UnitOut: TUnitesOctet;
begin
 UnitOut:= uOctet;
 if (Value >= 0) and (Value < KILOOCTET) then
  UnitOut:= uOctet
 else if (Value >= KILOOCTET) and (Value < MEGAOCTET) then
  UnitOut:= uKilo
 else if (Value >= MEGAOCTET) and (Value < GIGAOCTET) then
  UnitOut:= uMega
 else if (Value >= GIGAOCTET) and (Value < TERAOCTET) then
  UnitOut:= uGiga
 else if (Value >= TERAOCTET) and (Value < 1000 * TERAOCTET) then
  UnitOut:= uTera;

 Result:= ConversionOctets(Value,uOctet,UnitOut);
end;

function EffaceDossier(Dossier: string; titre:string):Boolean;
var FileOpStruct: TShFileOpStruct;
begin
 FileOpStruct.Wnd := 0;
 FileOpStruct.wFunc := FO_COPY;
 FileOpStruct.pFrom := PChar(Dossier+'\*.*');
 FileOpStruct.pTo := PChar(Dossier+'\a\');
 FileOpStruct.fFlags := FOF_NOCONFIRMATION  or FOF_SILENT or FOF_FILESONLY or FOF_NOCONFIRMMKDIR;
 FileOpStruct.lpszProgressTitle := PChar(titre);
 Result := ShFileOperation(FileOpStruct) = 0;
end;

{Trouve le programme avec lequel s'ouvre ce fichier}
function FindExec(const sFile: String): String;
var Exec: array [0..255] of Char;
begin
  FindExecutable(PChar(ExtractFileName(sFile)), PChar(ExtractFilePath(sFile)), Exec);
  Result:=String(Exec);
end;


{ METHODES SYSTEME DE L'APPLICATION }

procedure ExecuteOnce(source:TApplication);
{ cette fonction renvoie 0 s'il n'y a pas d'instance du même programme déjà lancée sinon
  le handle de l'instance déjà lancée c'est à dire une valeur <>0
  cette fonction est appelé dans le source du projet. voir ce source pour comprendre }
var ClassName: array[0..255] of char;
    TitreApplication: string;
    Resultat: HWND;
begin
 TitreApplication := source.Title;
 {on change le titre car sinon, on trouverait toujours une application déjà lancée (la notre!)}
 source.Title := '';
 try
 {met dans ClassName le nom de la class de l'application ('TApplication' en Delphi3)}
  GetClassName(source.handle, ClassName, 254);
 {renvoie le Handle de la première fenêtre de Class (type) ClassName et de
  titre TitreApplication (0 s'il n'y en a pas)}
  Resultat := FindWindow(ClassName, PChar(TitreApplication));
 finally
  source.Title := TitreApplication; // restauration du vrai titre
 end;
 if Resultat <> 0 then source.Terminate;
end;

function Version(source:TApplication): string;
var S: string;
    Taille, VersionL: DWord;
    Buffer, VersionPC: PChar;
begin
 Result := '';
 Buffer := '';
 {--- On demande la taille des informations sur l'application ---}
 S := source.ExeName;
 Taille := GetFileVersionInfoSize(PChar(S), Taille);
 if Taille > 0 then
 try
   {--- Réservation en mémoire d'une zone de la taille voulue ---}
  Buffer := AllocMem(Taille);
   {--- Copie dans le buffer des informations ---}
  GetFileVersionInfo(PChar(S), 0, Taille, Buffer);
   {--- Recherche de l'information de version ---}
  if VerQueryValue(Buffer, PChar('\StringFileInfo\040C04E4\FileVersion'), Pointer(VersionPC), VersionL) then
   Result := VersionPC;
 finally
  FreeMem(Buffer, Taille);
 end;
end;

function LireVersion(source:TApplication): string;
var ver, Chaine: string;
    i: Integer;
begin
 Chaine := Version(source); ver := '';
 if Chaine <> '' then
 begin
  i := Pos('.', Chaine);
  if i > 1 then
  begin
   ver := Copy(Chaine, 1, i - 1);
   Chaine := Copy(Chaine, i + 1, Length(Chaine) - i);
   i := Pos('.', Chaine);
   if i > 1 then
   begin
    ver := ver + '.';
    ver := ver + Copy(Chaine, 1, i - 1);
    Chaine := Copy(Chaine, i + 1, Length(Chaine) - i);
    i := Pos('.', Chaine);
    if i > 1 then
    begin
     ver := ver + '.';
     ver := ver + Copy(Chaine, 1, i - 1);
     result := ver;
    end;
   end;
  end;
 end;
end;

function CrypterT(const chaine,key:string):string;
var i,k:integer;
begin
 k:=0;
 result:='';
 { On crypte ou décrypte chaque caractère du texte }
 for i := 1 to length(chaine) do
 begin
  inc(k,1);
  if k > length(key) then k:=1;
  result := result + char(ord(chaine[i]) xor ord(Key[(k mod length(Key))])*255);
 end;
end;

function CrypterF(const fileIn,fileOut,key: string):Boolean;
var fin,fout: Textfile;
    phrase: string;
begin
 result:=False;
 if not Fileexists(fileIn) then exit;
 AssignFile(fin,fileIn);
 AssignFile(fout,fileOut);
 {$I-}
 Reset(fin);
 Rewrite(fout);
 while not Eof(fin) do
 begin
  Readln(fin,phrase);
  Writeln(fout,CrypterT(phrase,key));
 end;
 {$I+}
 if IOResult = 0 then
  result:=True;
 CloseFile(fin);
 CloseFile(fout);
end;

// Génerateur du nom de dossier a partir d'un nom
function NameGenerate(const name:string):string;
var tmp:string;
    i:integer;
begin
 tmp:=inttostr(ord(name[1]));
 for i:=2 to length(name) do tmp:=tmp+inttostr(ord(name[i]));
 result:=tmp;
end;

end.
