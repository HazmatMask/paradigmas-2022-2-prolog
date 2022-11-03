:- module('TDA-hexString',
           [myLengthR/3,myLength/2,myStringLength/2,hex/1,isHexR/1,isHex/1,isRGBHex/1,hexToInteger/2,hexChToDec/2,hexStringTo/2,
           decToHexStr/2,rgbStringToHex/4]).

%MYLENGTH
% DETERMINA EL LARGO DE UNA LISTA.
% DOMINIO(MYLENGTHR): LISTA X ENTERO X ENTERO.
%        (MYLENGTH):  LISTA X ENTERO
% RECURSIÓN DE COLA.

myLengthR([],L,L).
myLengthR([_|T],L,L_out):- L_up is L+1, myLengthR(T,L_up,L_out).

myLength(List,L_out):-myLengthR(List,0,L_out).

%MYSTRINGLENGTH
% TRANSFORMA UN STRING EN UNA LISTA DE CARACTERES, Y LUEGO DETERMINA SU
% LARGO POR MEDIO DE FUNCION ASOCIADA 'MYLENGTH'.
% DOMINIO: STRING X ENTERO
%
myStringLength(String,L_out):- string_chars(String,String_out), myLength(String_out,L_out).

%HEX
% DOMINIO: CHAR.

hex('0').
hex('1').
hex('2').
hex('3').
hex('4').
hex('5').
hex('6').
hex('7').
hex('8').
hex('9').
hex('A').
hex('B').
hex('C').
hex('D').
hex('E').
hex('F').

%HEXSTRING
% STRING CON 6 CARACTERES QUE CORRESPONDAN A TDA:HEX.

%IS_HEXSTRING
% DETERMINA SI UN STRING CORRESPONDE A UN HEXSTRING VÁLIDO.
% DOMINIO (ISHEXR): LISTA
%         (ISHEX):  STRING

isHexR([H|[]]):- hex(H).
isHexR([H|T]):- hex(H), isHexR(T).

isHex(String):-string_chars(String,S_out),isHexR(S_out).

%ISRGBHEX
% DETERMINA SI UN STRING POSEE 6 CARACTERES, Y ADEMÁS ES UN
% HEXSTRING VALIDO.

isRGBHex(String):- myStringLength(String,6), isHex(String).

%HEX TO INTEGER
% UNIFICA UN CARACTER EN HEXADECIMAL CON SU HOMOLOGO ENTERO.
% DOMINIO: CARACTER X ENTERO

hexToInteger('0',0).
hexToInteger('1',1).
hexToInteger('2',2).
hexToInteger('3',3).
hexToInteger('4',4).
hexToInteger('5',5).
hexToInteger('6',6).
hexToInteger('7',7).
hexToInteger('8',8).
hexToInteger('9',9).
hexToInteger('A',10).
hexToInteger('B',11).
hexToInteger('C',12).
hexToInteger('D',13).
hexToInteger('E',14).
hexToInteger('F',15).

%HEXCHAR LIST TO DECIMAL

%HEXCHTODEC
% DETERMINA SI UN PAR DE ELEMENTOS CORRESPONDE A UN PAR HEXADECIMAL
% VÁLIDO. LUEGO DETERMINA SU VALOR EN DECIMAL.
% DOMINIO: PAR (ANY) X ENTERO

hexChToDec([A,B],Sum_Out):-hexToInteger(A,Dec_A), hexToInteger(B,Dec_B), Sum_A is 16*Dec_A, Sum_Out is Sum_A+Dec_B.

%HEXSTRINGTO
% UNIFICA UN STRING DE 6 CARACTERES CON UN TRIO DE ENTEROS, LOS
% CUALES CORRESPONDEN AL DECIMAL DE SU HEXADECIMAL, DE EXISTIR ESTOS.
% DOMINIO: STRING X LISTA DE 3 ENTEROS.

hexStringTo(String,[A,B,C]):- string_chars(String,[A1,A2,B1,B2,C1,C2]),hexChToDec([A1,A2],A),hexChToDec([B1,B2],B),hexChToDec([C1,C2],C).

%DECTOHEXSTR
% UNIFICA UN ENTERO DECIMAL CON SU STRING HEXADECIMAL CORRESPONDIENTE.
% DOMINIO: ENTERO X STRING

decToHexStr(Value,Hex_out):-A is Value div 16, B is Value mod 16, hexToInteger(A_char,A), hexToInteger(B_char,B), string_chars(Hex_out,[A_char,B_char]).

%RGBSTRINGTOHEX
% UNIFICA 3 ENTEROS DECIMALES CON UN HEXADECIMAL QUE CORRESPONDE A LA
% CONCATENACION DE LAS FORMAS HEXADECIMALES DE DICHOS ENTEROS.
% DOMINIO: ENTERO X ENTERO X ENTERO X STRING

rgbStringToHex(R,G,B,Hex_out):- decToHexStr(R,R_hex), decToHexStr(G,G_hex), decToHexStr(B,B_hex), string_concat(R_hex,G_hex,RG_hex), string_concat(RG_hex,B_hex,Hex_out).

