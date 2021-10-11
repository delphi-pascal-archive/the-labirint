{
Unité: NDTypes
Auteur: Gladis NDOUAB'S
Pseudo CodesSources: Diglas
e-mail: gndouabs@hotmail.de
Version 1 Copyrigth Janvier 2010
Description: Cette unité regroupe tous les types, constantes, bref les
             déclarations simples utiles pour les projets de NDSoft.
}
unit NDTypes;

interface

uses Windows, Types;

           { LES TYPES DE DONNEES DE NDSOFT }
type
  TInfosCD = Record
   Drive: Char;
   SystemFile,Name: Array[0..255]of Char;
   Hachage: string;
   SerialNummer: DWord;
   FreeSpace,TotalSpace: TLargeInteger;
  end; 

  TUnitesOctet = (uOctet,uKilo,uMega,uGiga,uTera);

              { LES CONSTANCES DE NDSOFT }
Const
    ND_US_ADMIN = 'ADMINISTRATEUR';
    ND_NULL = -1;{ Valeur nulle}
    ND_ADMIN=0; {User is Administrator}
    ND_GAST=1; {User is Gast}
    ND_ACCES=2; {Signifie que l'authentification a réussie}
    ND_DNAWC=3; {Don't Need Authentic with Connection}
    ND_NAWC=4; {Need Authentic with Connection}
    ND_IS_RUNING=5; {Signifie que le programme est entrain de se lancer}
    ND_CF = 100;{ Mode Copie de fichier}
    ND_MF = 101;{ Mode déplacement de fichier}
    ND_CD = 102;{ Mode Copie de repertoire}
    ND_DD = 103;{ Mode suppresion de repertoire}
    ND_MD = 104;{ Mode déplacement de repertoire}
    ND_CFE = 200;{ Erreur de copie du fichier}
    ND_NFDS = 201;{ Espace insuffisant pour la copie de fichier}
    ND_CFS = 202;{ Succes de copie du fichier}
    ND_MFE = 203;{ Erreur de déplacement du fichier}
    ND_MFS = 204;{ Succes de déplacement du fichier}
    ND_CDE = 205;{ Erreur de copie du repertoire}
    ND_CDS = 206;{ Succes de copie du repertoire}
    ND_DDE = 207;{ Erreur de suppresion du repertoire}
    ND_DDS = 208;{ Succes de suppresion du repertoire}
    ND_MDE = 209;{ Erreur de déplacement du repertoire}
    ND_MDS = 210;{ Succes de déplacement du repertoire}
    ND_KEY_EMPTY=110; { La clé est vide}
    ND_KEY_EXIST=111; { La clé existe dejas}
    ND_KEY_INVALID=112; { La clé est invalide}
    ND_KEY_NKF=113; { le fichier des clés est manquant}
    ND_KEY_CCV=114; { le le champ clé est vide}
    ND_LC_INVALID=116; { Vérification de la licence invalide}
    ND_LC_VALID=117; { Vérification de la licence valide}
    ND_LC_BOXI=118; { La propriété BoxMsg ou BoxTitel est vide}

    {Constantes pour la gestion des octets}
    UNITES_OCTET : array[TUnitesOctet] of string
                    = ('Octets', 'Ko', 'Mo', 'Go', 'To');
    {$IFDEF AVANT_STANDARDISATION}
      KILOOCTET = 1000.0 ;
    {$ELSE}
      KILOOCTET = 1024.0 ;
    {$ENDIF}
    MEGAOCTET  = KILOOCTET * KILOOCTET;
    GIGAOCTET  = KILOOCTET * MEGAOCTET;
    TERAOCTET  = KILOOCTET * GIGAOCTET;


implementation



end.
