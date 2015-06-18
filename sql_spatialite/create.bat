@ECHO OFF

:VARIABLES
SET SPLEX=C:\Users\cgul0007\Documents\GitHub\Gracelite\spatialite.exe
SET GLV=_beta1b
SET SPLDB=..\db_spatialite\gracethd_v2%GLV%.sqlite
REM SET SHPDB=.\shpcsv-in\

:BASE
ECHO GRACELITE - SUPPRESSION BASE
IF EXIST %SPLDB% DEL /s %SPLDB%

ECHO GRACELITE - CREATION BASE
ECHO GRACELITE - FOREIGN_KEYS = ON
%SPLEX% -silent %SPLDB% "PRAGMA foreign_keys = ON;"

:CONNECTSHP


:SCHEMA
ECHO GRACELITE - CREATION DE LA STRUCTURE DE LA BASE DE DONNEES
ECHO GRACELITE - CREATION DES LISTES
SET FSQL=gracethd_1_lists.sql
%SPLEX% -silent %SPLDB% < %FSQL%
ECHO GRACELITE - INSERT VALEURS DANS LES LISTES
SET FSQL=gracethd_2_insert.sql
%SPLEX% -silent %SPLDB% < %FSQL%
ECHO GRACELITE - CREATION DES TABLES
SET FSQL=gracethd_3_tables.sql
%SPLEX% -silent %SPLDB% < %FSQL%
ECHO GRACELITE - AJOUT DES CHAMPS GEOMETRIQUES
SET FSQL=gracethd_4_spatialite.sql
%SPLEX% -silent %SPLDB% < %FSQL%
ECHO GRACELITE - AJOUT DES INDEX
SET FSQL=gracethd_5_index.sql
%SPLEX% -silent %SPLDB% < %FSQL%
ECHO GRACELITE - AJOUT DES SPECIFICITES
SET FSQL=gracethd_6_specifique.sql
%SPLEX% -silent %SPLDB% < %FSQL%

:INSERTSHP


PAUSE