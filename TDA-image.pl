:- module('TDA-image',
           [ image/4,
             isBitList/1,
             isRgbList/1,
             isHexList/1,
             imageIsBitmap/1,
             imageIsPixmap/1,
             imageIsHexmap/1,
             imageIsCompressed/1,
             create_pix/4,
             select_pix_x/2,
             select_pix_y/2,
             select_pix_content/2,
             select_pix_end/2,
             select_pix_depth/2,
             mod_pix_x/3,
             mod_pix_y/3,
             flipHRec/3,
             imageFlipH/2,
             flipVRec/3,
             imageFlipV/2,
             cropRec/6,
             imageCrop/6,
             recPixListRGBtoHex/2,
             imageRGBtoHex/2,
             recPixListHexToRGB/2,
             imageHextoRGB/2,
             is_BIN_in_List/2,
             add_BIN_value/3,
             add_BIN_value/3,
             up_BIN_value/3,
             run_BIN_List/3,
             is_RGB_in_List/4,
             add_RGB_value/5,
             up_RGB_value/5,
             run_RGB_List/3,
             imageToHistogram/2,
             imageRotate90Rec/3,
             imageRotate90/2,
             createCompressedImage/4,
             recMostFrequentBINHisto/3,
             mostFrequentBINHisto/2,
             recCompressBINList_newList/4,
             compressBINList_newList/3,
             recCompressBINList_clear/3,
             compressBINList_clear/3,
             compressBitmap/2,
             recMostFrequentRGBHisto/3,
             mostFrequentRGBHisto/2,
             recCompressRGBList_newList/4,
             compressRGBList_newList/3,
             recCompressRGBList_clear/3,
             compressRGBList_clear/3,
             compressPixmap/2,
             mostFrequentHEXHisto/2,
             recCompressHEXList_newList/4,
             compressHEXList_newList/3,
             recCompressHEXList_clear/3,
             compressHEXList_clear/3,
             compressHexmap/2,
             compress/2,
             imageChangePixelRec/3,
             validate_entries_ICP/3,
             imageChangePixel/3,
             imageInvertColorRGBRec/2,
             getPix_out/4,
             getPix_clear/4,
             sort_Content/6,
             sort_Image/2,
             bitListToString/4,
             bitmapToString/2,
             pixListToString/4,
             pixmapToString/2,
             hexListToString/4,
             hexmapToString/2,
             imageToString_back/2,
             imageToString/2,
             createBaseImage/8,
             createBaseRGBImage/10,
             getNDepth_list/4,
             getNDepth_clear/4,
             getNDepthRGB_list/4,
             getNDepthRGB_clear/4,
             insertPixList/3,
             bitDepthLayers/5,
             rgbDepthLayers/5,
             hexDepthLayers/5,
             imageDepthLayers/2,
             unpack_CompressedBit/4,
             unpack_CompressedBitmap/2,
             concat_PixList/3,
             decompressBitmap/2,
             unpack_CompressedPix/6,
             unpack_CompressedPixmap/2,
             decompressPixmap/2,
             unpack_CompressedHex/4,
             unpack_CompressedHexmap/2,
             decompressHexmap/2,
             decompress/2,
             imageInvertColorRGB/2
           ]
         ).

%CONSTRUCTOR
%
%TDA: IMAGE
% ENTERO X ENTERO X LISTA X TDA:IMAGE

image(X,Y,Content,[X,Y,Content]).

%ISBITLIST
% DETERMINA SI TODOS LOS ELEMENTOS DE UNA LISTA CORRESPONDEN A
% TDA:PIXBIT.
% DOMINIO: LISTA.
% RECURSIÓN: PILA.

isBitList([]).
isBitList([H|T]):-isPixbit(H),isBitList(T).

%ISRGBLIST
% DETERMINA SI TODOS LOS ELEMENTOS DE UNA LISTA CORRESPONDEN A
% TDA:PIXRGB.
% DOMINIO: LISTA.
% RECURSIÓN: PILA.

isRgbList([]).
isRgbList([H|T]):-isPixrgb(H),isRgbList(T).

%ISHEXLIST
% DETERMINA SI TODOS LOS ELEMENTOS DE UNA LISTA CORRESPONDEN A
% TDA:PIXHEX.
% DOMINIO: LISTA.
% RECURSIÓN: PILA.
%

isHexList([]).
isHexList([H|T]):-isPixhex(H),isHexList(T).

%IMAGEISBITMAP
% DETERMINA SI UNA LISTA CORRESPONDE A UN TDA:BITMAP, CON SU PRIMER Y
% SEGUNDO ELEMENTO CORRESPONDIENDO A ENTEROS NO NEGATIVOS, Y SU TERCER
% ELEMENTO CORRESPONDIENTE A UNA LISTA DE TDA:PIXBIT.
% DOMINIO: LISTA.

imageIsBitmap([X,Y,Content|_]):-integer(X),integer(Y),X > -1, Y > -1, isBitList(Content).

%IMAGEISPIXMAP
% DETERMINA SI UNA LISTA CORRESPONDE A UN TDA:PIXMAP, CON SU PRIMER Y
% SEGUNDO ELEMENTO CORRESPONDIENDO A ENTEROS NO NEGATIVOS, Y SU TERCER
% ELEMENTO CORRESPONDIENTE A UNA LISTA DE TDA:PIXRGB.
% DOMINIO: LISTA.

imageIsPixmap([X,Y,Content|_]):-integer(X),integer(Y),X > -1, Y > -1, isRgbList(Content).

%IMAGEISHEXMAP
% DETERMINA SI UNA LISTA CORRESPONDE A UN TDA:HEXMAP, CON SU PRIMER Y
% SEGUNDO ELEMENTO CORRESPONDIENDO A ENTEROS NO NEGATIVOS, Y SU TERCER
% ELEMENTO CORRESPONDIENTE A UNA LISTA DE TDA:PIXHEX.
% DOMINIO: LISTA.

imageIsHexmap([X,Y,Content|_]):-integer(X),integer(Y),X > -1, Y > -1, isHexList(Content).

%IMAGEISCOMPRESSED
% DETERMINA SI UNA LISTA POSEE UNA COLA CORRESPONDIENTE A UN ELEMENTO NO
% NULO, POSTERIOR A SU TERCER ELEMENTO, AL IGUAL QUE UN PRIMER Y SEGUNDO
% ELEMENTO ENTEROS NO NEGATIVOS.
% DOMINIO: LISTA

imageIsCompressed([X,Y,_|[_|_]]):- integer(X),integer(Y),X > -1, Y > -1.

%CREATE_PIX
% UNIFICA DOS ELEMENTOS Y UNA LISTA CON UNA SEGUNDA LISTA
% CORRESPONDIENTE A ESTOS ENLISTADOS.
% DOMINIO: ENTERO X ENTERO X LISTA X LISTA.

create_pix(X,Y,Content,[X,Y|Content]).

%SELECT_PIX_X
% UNIFICA EL PRIMER ELEMENTO DE UNA LISTA CON UN ELEMENTO X.
% DOMINIO: LISTA X ELEMENTO

select_pix_x([X|_],X).

%SELECT_PIX_Y
% UNIFICA EL SEGUNDO ELEMENTO DE UNA LISTA CON UN ELEMENTO Y.
% DOMINIO: LISTA X ELEMENTO

select_pix_y([_,Y|_],Y).

%SELECT_PIX_CONTENT
% UNIFICA EL TERCER ELEMENTO DE UNA LISTA CON UN ELEMENTO CONTENT.
% DOMINIO: LISTA X ELEMENTO

select_pix_content([_,_,Content|_],Content).

%SELECT_PIX_END
% UNIFICA LA COLA POSTERIOR AL TERCER ELEMENTO DE UNA LISTA CON UN
% ELEMENTO END.
% DOMINIO: LISTA X LISTA

select_pix_end([_,_,_|End],End).

%SELECT_PIX_DEPTH
% UNIFICA EL CUARTO ELEMENTO DE UNA LISTA CON UN ELEMENTO D.
% DOMINIO: LISTA X ELEMENTO

select_pix_depth([_,_,_,D],D).

%MOD_PIX_X
% UNIFICA UN ELEMENTO Y LA COLA LUEGO DEL PRIMER ELEMENTO DE UNA LISTA,
% CON UNA SEGUNDA LISTA, CUYO PRIMER ELEMENTO CORRESPONDE AL ELEMENTO
% INDEPENDIENTE MENCIONADO, EN TANTO SUS OTROS ELEMENTOS CORRESPONDEN A
% LOS DE LA LISTA INICIAL.
% DOMINIO: LISTA X ELEMENTO X LISTA.

mod_pix_x([_|T],New_X,[New_X|T]).

%MOD_PIX_Y
% UNIFICA EL PRIMER ELEMENTO Y LA COLA LUEGO DEL SEGUNDO ELEMENTO DE UNA
% LISTA, JUNTO A UN ELEMENTO INDEPENDIENTE, CON UNA SEGUNDA LISTA, CUYO
% SEGUNDO ELEMENTO CORRESPONDE AL ELEMENTO INDEPENDIENTE MENCIONADO, EN
% TANTO SUS OTROS ELEMENTOS CORRESPONDEN A LOS DE LA LISTA INICIAL.
% DOMINIO: LISTA X ELEMENTO X LISTA.

mod_pix_y([X,_|T],New_Y,[X,New_Y|T]).

%FLIPHREC
% UNIFICA UN ENTERO (XSIZE), Y DOS LISTAS DE TDA:PIX, DONDE LAS CABEZAS
% DE DICHAS LISTAS POSEEN SU PRIMER ELEMENTO (X1,X2) RELACIONADOS SEGUN
% LA ECUACION X2 = XSIZE - 1 - X. EN TANTO TODOS SUS OTROS ELEMENTOS
% COINCIDEN.
%
%IMAGEFLIPH
% UNIFICA DOS IMAGENES CON ALTO Y ANCHO IGUALES ENTRE ELLAS, LUEGO DE
% INGRESAR SU PRIMER ELEMENTO(X) Y SUS CONTENIDOS CON PREDICADO FLIPHREC.
%
% DOMINIO: FLIPHREC: ENTERO X LISTA X LISTA
%          IMAGEFLIPH: LISTA X LISTA
% RECURSION: DE PILA.

flipHRec(_,[],[]).
flipHRec(X,[H|T],[H2|T2]):- select_pix_x(H,H_X), select_pix_x(H2,H_X2), X_aux is X-1, H_X2 is X_aux-H_X, mod_pix_x(H,H_X2,H2), flipHRec(X,T,T2).

imageFlipH([X,Y,Content],[X,Y,Content_2]):- flipHRec(X,Content,Content_2).

%FLIPVREC
% UNIFICA UN ENTERO (YSIZE), Y DOS LISTAS DE TDA:PIX, DONDE LAS CABEZAS
% DE DICHAS LISTAS POSEEN SU SEGUNDO ELEMENTO (Y1,Y2) RELACIONADOS SEGUN
% LA ECUACION Y2 = YSIZE - 1 - Y. EN TANTO TODOS SUS OTROS ELEMENTOS
% COINCIDEN.
%
%IMAGEFLIPH
% UNIFICA DOS IMAGENES CON ALTO Y ANCHO IGUALES ENTRE ELLAS, LUEGO DE
% INGRESAR SU SEGUNDO ELEMENTO(Y) Y SUS CONTENIDOS CON PREDICADO FLIPVREC.
%
% DOMINIO: FLIPVREC: ENTERO X LISTA X LISTA
%          IMAGEFLIPV: LISTA X LISTA
% RECURSION: DE PILA.

flipVRec(_,[],[]).
flipVRec(Y,[H|T],[H2|T2]):- select_pix_y(H,H_Y), select_pix_y(H2,H_Y2), Y_aux is Y-1, H_Y2 is Y_aux-H_Y, mod_pix_y(H,H_Y2,H2), flipVRec(Y,T,T2).

imageFlipV([X,Y,Content],[X,Y,Content_2]):- flipVRec(Y,Content,Content_2).

%CROPREC
%
% DETERMINA SI LA CABEZA DE UNA LISTA INICIAL SE ENCUENTRA DENTRO DE LOS
% PARAMETROS DE COORDENADA ENTREGADOS. DE SER ASI, UNIFICA LA CABEZA CON
% LA CABEZA DE UNA SEGUNDA LISTA, Y EVALUA DICHO PROTOCOLO CON LAS COLAS
% DE AMBAS. EN CASO CONTRARIO, UNIFICA LA COLA DE AMBAS LISTAS, Y APLICA
% ESTE PROTOCOLO A LAS COLAS DE ESTOS.
%
%IMAGECROP
%
% UNIFICA UNA LISTA DE TDA:PIX, CON CUATRO ENTEROS, CORRESPONDIENTES A
% DOS COORDENADAS, Y UNA NUEVA LISTA DE TDA:PIX, DONDE SE ENCUENTREN LOS
% ELEMENTOS DE LA LISTA INICIAL QUE SE ENCUENTREN DENTRO DE LOS
% PARAMETROS ENTREGADOS.
%
% DOMINIO: CROPREC: ENTERO X ENTERO X ENTERO X ENTERO X LISTA X LISTA
%          IMAGECROP: LISTA X ENTERO X ENTERO X ENTERO X ENTERO X LISTA
%
% RECURSION: DE PILA.

cropRec(_,_,_,_,[],[]).
cropRec(X_1,Y_1,X_2,Y_2,[H|T],[H|T_2]):- select_pix_x(H,H_X), select_pix_y(H,H_Y), X_1-1 < H_X, X_2+1 > H_X, Y_1-1 < H_Y, Y_2+1 > H_Y, cropRec(X_1,Y_1,X_2,Y_2,T,T_2).
cropRec(X_1,Y_1,X_2,Y_2,[_|T],T_2):- cropRec(X_1,Y_1,X_2,Y_2,T,T_2).

imageCrop([X,Y,Content_in],X_1,Y_1,X_2,Y_2,[X,Y,Content_out]):- cropRec(X_1,Y_1,X_2,Y_2,Content_in,Content_out).

%RECPIXLISTRGBTOHEX
% UNIFICA UNA LISTA DE TDA:PIXRGB CON SUS HOMOLOGOS DE TDA:PIXHEX POR
% MEDIO DE EL PREDICADO RGBSTRINGTOHEX IMPORTADO DESDE MODULO
% TDA:HEXSTRING.
%
%IMAGERGBTOHEX
% UNIFICA DOS IMAGENES CON LARGO Y ANCHO (X,Y) IGUALES, Y SUS CONTENIDOS
% EVALUADOS SEGUN PREDICADO RECPIXLISTRGBTOHEX.
%
% DOMINIO: LISTA (PIXRGB) X LISTA (PIXHEX)
% RECURSION: PILA.

recPixListRGBtoHex([],[]).
recPixListRGBtoHex([[X,Y,R,G,B,D]|T_RGB],[[X,Y,HEX,D]|T_HEX]):- rgbStringToHex(R,G,B,HEX), recPixListRGBtoHex(T_RGB,T_HEX).

imageRGBtoHex([X,Y,Content_in],[X,Y,Content_out]):- recPixListRGBtoHex(Content_in,Content_out).

%RECPIXLISTHEXTORGB
% UNIFICA UNA LISTA DE TDA:PIXHEX CON SUS HOMOLOGOS DE TDA:PIXRGB POR
% MEDIO DE EL PREDICADO HEXSTRINGTO IMPORTADO DESDE MODULO
% TDA:HEXSTRING.
%
%IMAGEHEXTORGB
% UNIFICA DOS IMAGENES CON LARGO Y ANCHO (X,Y) IGUALES, Y SUS CONTENIDOS
% EVALUADOS SEGUN PREDICADO RECPIXLISTHEXTORGB.
%
% DOMINIO: LISTA (PIXHEX) X LISTA (PIXRGB)
% RECURSION: PILA.

recPixListHexToRGB([],[]).
recPixListHexToRGB([[X,Y,HEX_IN,D]|T_HEX],[[X,Y,R,G,B,D]|T_RGB]):- hexStringTo(HEX_IN,[R,G,B]), recPixListHexToRGB(T_HEX,T_RGB).

imageHextoRGB([X,Y,Content_in],[X,Y,Content_out]):- recPixListHexToRGB(Content_in,Content_out).

%IMGTOHISTOGRAM

%IS_BIN_IN_LIST
% DETERMINA SI UN ENTERO (1/0) SE ENCUENTRA EN UNA LISTA
% ASOCIADA.
% DOMINIO: LISTA X ENTERO
% RECURSION: PILA

is_BIN_in_List([[BIN,_]|[]],BIN).
is_BIN_in_List([[BIN,_]|[_|_]],BIN).
is_BIN_in_List([_|T],BIN):- is_BIN_in_List(T,BIN).

%ADD_BIN_VALUE
% UNIFICA UNA LISTA Y UN ENTERO (1/0) CON UNA LISTA CUYA CABEZA
% ES UN PAR DE DICHO ENTERO Y EL ENTERO 1, Y SU COLA ES LA LISTA
% INICIAL.
% DOMINIO: LISTA X TDA:PIXBIT X LISTA

add_BIN_value(List_in,BIN,[[BIN,1]|List_in]).

%UP_BIN_VALUE
% AUMENTA EL VALOR ASOCIADO A UN ENTERO (1/0) EN 1.
% DOMINIO: ENTERO X LISTA X LISTA
% RECURSION: PILA

up_BIN_value(BIN,[[BIN,A]|T],[[BIN,A_up]|T]):-A_up is A+1.
up_BIN_value(BIN,[H|T1],[H|T2]):- up_BIN_value(BIN,T1,T2).

%RUN_BIN_LIST
% DETERMINA SI UN VALOR DE TDA:PIXBIT (0/1) EXISTE EN UNA LISTA
% AUXILIAR. DE NO EXISTIR, LO AGREGA JUNTO A UN CONTADOR 1. DE EXISTIR,
% BUSCA SU UBICACION Y AUMENTA SU CONTADOR ASOCIADO EN 1.
%
% DOMINIO: LISTA (TDA:PIXBIT) X LISTA X LISTA
% RECURSION: COLA

run_BIN_List([],List_out,List_out).
run_BIN_List([PixBIT|T],List_aux,List_out):- select_pixbit_value(PixBIT,BIN), is_BIN_in_List(List_aux,BIN), up_BIN_value(BIN,List_aux,List_aux2),run_BIN_List(T,List_aux2,List_out).
run_BIN_List([PixBIT|T],List_aux,List_out):- select_pixbit_value(PixBIT,BIN), add_BIN_value(List_aux,BIN,List_aux2), run_BIN_List(T,List_aux2,List_out).

%RGB COUNTER
%
%%IS_RGB_IN_LIST
% DETERMINA SI UN TRIO DE ENTEROS SE ENCUENTRA EN UNA LISTA
% ASOCIADA.
% DOMINIO: LISTA X ENTERO X ENTERO X ENTERO
% RECURSION: PILA

is_RGB_in_List([[R,G,B,_]|[]],R,G,B).
is_RGB_in_List([[R,G,B,_]|[_|_]],R,G,B).
is_RGB_in_List([_|T],R,G,B):- is_RGB_in_List(T,R,G,B).

%ADD_RGB_VALUE
% UNIFICA UNA LISTA Y TRES ENTEROS, CON UNA LISTA CUYA CABEZA ES UNA
% LISTA DE DICHOS ENTEROS Y EL ENTERO 1, Y SU COLA ES LA LISTA INICIAL.
% DOMINIO: LISTA X TDA:PIXBIT X LISTA

add_RGB_value(List_in,R,G,B,[[R,G,B,1]|List_in]).

%UP_RGB_VALUE
% AUMENTA EL VALOR ASOCIADO A UN TRIO DE ENTEROS EN 1.
% DOMINIO: ENTERO X ENTERO X ENTERO X LISTA X LISTA
% RECURSION: PILA

up_RGB_value(R,G,B,[[R,G,B,A]|T],[[R,G,B,A_up]|T]):- A_up is A+1.
up_RGB_value(R,G,B,[H|T1],[H|T2]):- up_RGB_value(R,G,B,T1,T2).

%RUN_RGB_LIST
% DETERMINA SI LOS VALORES DE UN TDA:PIXRGB EXISTEN EN UNA LISTA
% AUXILIAR. DE NO EXISTIR, LOS AGREGA JUNTO A UN CONTADOR 1. DE EXISTIR,
% BUSCA SU UBICACION Y AUMENTA SU CONTADOR ASOCIADO EN 1.
%
% DOMINIO: LISTA (TDA:PIXRGB) X LISTA X LISTA
% RECURSION: COLA

run_RGB_List([],List_out,List_out).
run_RGB_List([PixRGB|T],List_aux,List_out):- select_pixrgb_red(PixRGB,R), select_pixrgb_green(PixRGB,G), select_pixrgb_blue(PixRGB,B), is_RGB_in_List(List_aux,R,G,B), up_RGB_value(R,G,B,List_aux,List_aux2),run_RGB_List(T,List_aux2,List_out).
run_RGB_List([PixRGB|T],List_aux,List_out):- select_pixrgb_red(PixRGB,R), select_pixrgb_green(PixRGB,G), select_pixrgb_blue(PixRGB,B), add_RGB_value(List_aux,R,G,B,List_aux2), run_RGB_List(T,List_aux2,List_out).

%IMAGETOHISTOGRAM
% DETERMINA EL TIPO DE UNA IMAGEN, Y LO UNIFICA CON UNA LISTA QUE
% CORRESPONDE AL TERCER ARGUMENTO DEL PREDICADO
% RUN_BIN_LIST/RUN_RGB_LIST.
% DE TRATARSE DE UN TDA:HEXMAP, LO TRANSFORMA EN UN TDA:RGBMAP ANTES DE
% INGRESARLO AL PREDICADO CORRESPONDIENTE.
%
% DOMINIO: TDA:IMAGE X LISTA

imageToHistogram(Image,List_out):- imageIsBitmap(Image), select_pix_content(Image,Bit_list), run_BIN_List(Bit_list,[],List_out).

imageToHistogram(Image,List_out):- imageIsPixmap(Image), select_pix_content(Image,Pix_list), run_RGB_List(Pix_list,[],List_out).

imageToHistogram(Image_in,List_out):- imageIsHexmap(Image_in), imageHextoRGB(Image_in,Image_out), select_pix_content(Image_out,Pix_list), run_RGB_List(Pix_list,[],List_out).

%IMAGEROTATE90REC
% UNIFICA LAS CABEZAS DE UN ENTERO (YSIZE) Y DOS LISTAS DE TDA:PIX, DE
% FORMA QUE LA COORDENADA Y DE LA SEGUNDA CABEZA CORRESPONDA A LA
% COORDENADA X DE LA PRIMERA. POR OTRO LADO, LA COORDENADA X DE LA
% SEGUNDA CABEZA, DEBE CORRESPONDER AL OPUESTO ADITIVO DE LA COORDENADA
% Y DE LA SEGUNDA, DISMINUIDO EN UNO, MAS EL ENTERO YSIZE ASOCIADO.
%
%IMAGEROTATE90
% UNIFICA DOS TDA:IMAGE CUYOS ANCHO Y ALTO COINCIDEN, EN TANTO SUS
% CONTENIDOS SE RELACIONAN SEGUN EL PREDICADO IMAGEROTATE90REC.
%
% DOMINIO: IMAGEROTATE90DEC: ENTERO X LISTA X LISTA
%          IMAGEROTATE90:    TDA:IMAGE X TDA:IMAGE
%
% RECURSION: PILA.

imageRotate90Rec(_,[],[]).
imageRotate90Rec(Y,[H|T],[H2|T2]):- select_pix_x(H,H_X), select_pix_y(H,H_Y), mod_pix_y(H,H_X,H_AUX), X_AUX is Y-1, Y_AUX is -H_Y+X_AUX, mod_pix_x(H_AUX,Y_AUX,H2), imageRotate90Rec(Y,T,T2).

imageRotate90([X,Y,Content],[Y,X,Content_2]):- imageRotate90Rec(Y,Content,Content_2).

%CREATECOMPRESSEDIMAGE
% UNIFICA UN TDA:IMAGE, UNA LISTA DE TDA:PIX, Y UNA LISTA COMPRIMIDA,
% CON UNA IMAGEN NUEVA CREADA CON ESTOS ELEMENTOS, SIENDO LA LISTA
% COMPRIMIDA LA COLA DESPUES DEL TERCER ELEMENTO DE LA TDA:IMAGE.

createCompressedImage(Image_in,Compressed_List,Clear_List,[X_out,Y_out,Clear_List|[Compressed_List|Old_compress]]):- select_pix_x(Image_in,X_out), select_pix_y(Image_in,Y_out), select_pix_end(Image_in,Old_compress).


%RECMOSTFREQUENTBINHISTO
% DETERMINA EL PAR CUYO SEGUNDO ELEMENTO SEA EL MAYOR ENTERO DE UNA
% LISTA. LUEGO UNIFICA EL PRIMER ELEMENTO DE ESTE PAR CON UNA LISTA DE
% UN SOLO ELEMENTO.
%
%MOSTFREQUENTBINHISTO
% EVALUA UNA LISTA CON UN PAR CUYO SEGUNDO ELEMENTO ES 0, A TRAVES DEL
% PREDICADO RECMOSTFREQUENTBINHISTO.
%
% DOMINIO: RECMOSTFREQUENTBINHISTO: LISTA X PAR X LISTA
%          MOSTFREQUENTBINHISTO: LISTA X LISTA
% RECURSION: PILA

recMostFrequentBINHisto([[BIN,A]|[]],[_,A2],[BIN]):- A > A2.
recMostFrequentBINHisto([[_,A]|[]],[BIN,A2],[BIN]):- A =< A2.
recMostFrequentBINHisto([[BIN,A]|T],[_,A2],Color_out):- A > A2, recMostFrequentBINHisto(T,[BIN,A],Color_out).
recMostFrequentBINHisto([[_,A]|T],[BIN,A2],Color_out):- A =< A2, recMostFrequentBINHisto(T,[BIN,A2],Color_out).

mostFrequentBINHisto(List_in,Color_out):- recMostFrequentBINHisto(List_in,[_,0],Color_out).

%RECCOMPRESSBINLIST_NEWLIST
% UNIFICA UNA LISTA Y UNA LISTA UNITARIA CON VALOR (0/1), CON UNA LISTA
% CUYOS ELEMENTOS SON AQUELLOS DE LA PRIMERA LISTA CUYO VALOR NO
% COINCIDA CON EL VALOR INICIAL ENTREGADO.
%
%COMPRESSBINLIST_NEWLIST
% EVALUA SEGUN PREDICADO RECCOMPRESSBINLIST_NEWLIST TRES LISTAS.
%
% DOMINIO: RECCOMPRESS_NEWLIST: LISTA X LISTA X LISTA X LISTA
%          COMPRESS_NEWLIST: LISTA X LISTA X LISTA
% RECURSION: COLA

recCompressBINList_newList([],_,List_out,List_out).
recCompressBINList_newList([H|T],[BIN],List_aux,List_out):- select_pixbit_value(H,BIN), select_pixbit_x(H,X), select_pixbit_y(H,Y), select_pixbit_depth(H,D), recCompressBINList_newList(T,[BIN],[[X,Y,D]|List_aux],List_out).
recCompressBINList_newList([_|T],Color_in,List_aux,List_out):- recCompressBINList_newList(T,Color_in,List_aux,List_out).

compressBINList_newList(List_in,Color_in,List_out):- recCompressBINList_newList(List_in,Color_in,[],List_out).

%RECCOMPRESSBINLIST_CLEAR
% UNIFICA UNA LISTA Y UNA LISTA UNITARIA CON VALOR (0/1), CON UNA LISTA
% CUYOS ELEMENTOS SON AQUELLOS DE LA PRIMERA LISTA CUYO VALOR
% COINCIDA CON EL VALOR INICIAL ENTREGADO.
%
%COMPRESSBINLIST_CLEAR
% EVALUA, SEGUN PREDICADO RECCOMPRESSBINLIST_CLEAR, TRES LISTAS.
%
% DOMINIO: RECCOMPRESS_CLEAR: LISTA X LISTA X LISTA
%          COMPRESS_CLEAR: LISTA X LISTA X LISTA
% RECURSION: PILA

recCompressBINList_clear([],[],_).
recCompressBINList_clear([H|T],T2,[BIN]):-  select_pixbit_value(H,BIN), recCompressBINList_clear(T,T2,[BIN]).
recCompressBINList_clear([H|T],[H|T2],Color_in):- recCompressBINList_clear(T,T2,Color_in).

compressBINList_clear(List_in,Color_in,List_out):- recCompressBINList_clear(List_in,List_out,Color_in).

%COMPRESSBITMAP
% DADA UN TDA:IMAGE INICIAL, DETERMINA EL VALOR BINARIO MAS FRECUENTE EN
% ESTA. LUEGO CREA UNA LISTA CON AQUELLOS TDA:PIXBIT CUYO VALOR COINCIDA
% CON EL MAS FRECUENTE. FINALMENTE CREA UN TDA:IMAGE CUYO ULTIMA COLA
% CORRESPONDA A LA LISTA CREADA CON LA ULTIMA COLA DEL TDA:IMAGE
% INICIAL, AL IGUAL QUE ELIMINANDO DICHOS TDA:PIXBIT DEL CONTENIDO DE LA
% TDA:IMAGE INICIAL.
%
% DOMINIO: TDA:IMAGE X TDA:IMAGE(COMPRESSED)

compressBitmap(Image_in,Compressed_Image_out):- imageToHistogram(Image_in,Histo_out), mostFrequentBINHisto(Histo_out,Color_out), select_pix_content(Image_in,Content_out), compressBINList_newList(Content_out,Color_out,New_content), compressBINList_clear(Content_out,Color_out,Clear_content), createCompressedImage(Image_in,[Color_out|New_content],Clear_content,Compressed_Image_out).

%COMPRESS RGB

%RECMOSTFREQUENTRGBHISTO
% DETERMINA LA LISTA CUYO ULTIMO ELEMENTO SEA EL MAYOR ENTERO DE UNA
% LISTA. LUEGO UNIFICA LOS TRES PRIMEROS DE ESTA LISTA INTERIOR CON UNA
% LISTA DE UN SOLO ELEMENTO.
%
%MOSTFREQUENTRGBHISTO
% EVALUA UNA LISTA CON UNA LISTA CUYO CUARTO ELEMENTO ES 0, A TRAVES
% DEL PREDICADO RECMOSTFREQUENTRGBHISTO.
%
% DOMINIO: RECMOSTFREQUENTRGBHISTO: LISTA X LISTA X LISTA
%          MOSTFREQUENTRGBHISTO: LISTA X LISTA
% RECURSION: PILA

recMostFrequentRGBHisto([[R,G,B,A]|[]],[_,_,_,A2],[R,G,B]):- A > A2.
recMostFrequentRGBHisto([[_,_,_,A]|[]],[R,G,B,A2],[R,G,B]):- A =< A2.
recMostFrequentRGBHisto([[R,G,B,A]|T],[_,_,_,A2],Color_out):- A > A2, recMostFrequentRGBHisto(T,[R,G,B,A],Color_out).
recMostFrequentRGBHisto([[_,_,_,A]|T],[R,G,B,A2],Color_out):- A =< A2, recMostFrequentRGBHisto(T,[R,G,B,A2],Color_out).

mostFrequentRGBHisto(List_in,Color_out):- recMostFrequentRGBHisto(List_in,[_,_,_,0],Color_out).

%RECCOMPRESSRGBLIST_NEWLIST
% UNIFICA UNA LISTA Y UNA LISTA DE VALORES R,G,B, CON UNA LISTA
% CUYOS ELEMENTOS SON AQUELLOS DE LA PRIMERA LISTA CUYOS VALORES NO
% COINCIDAN CON LOS VALORES INICIALES ENTREGADOS.
%
%COMPRESSRGBLIST_NEWLIST
% EVALUA SEGUN PREDICADO RECCOMPRESSRGBLIST_NEWLIST TRES LISTAS.
%
% DOMINIO: RECCOMPRESS_NEWLIST: LISTA X LISTA X LISTA X LISTA
%          COMPRESS_NEWLIST: LISTA X LISTA X LISTA
% RECURSION: COLA

recCompressRGBList_newList([],_,List_out,List_out).
recCompressRGBList_newList([H|T],[R,G,B],List_aux,List_out):- select_pixrgb_red(H,R), select_pixrgb_green(H,G), select_pixrgb_blue(H,B), select_pixrgb_x(H,X), select_pixrgb_y(H,Y), select_pixrgb_depth(H,D), recCompressRGBList_newList(T,[R,G,B],[[X,Y,D]|List_aux],List_out).
recCompressRGBList_newList([_|T],Color_in,List_aux,List_out):- recCompressRGBList_newList(T,Color_in,List_aux,List_out).

compressRGBList_newList(List_in,Color_in,List_out):- recCompressRGBList_newList(List_in,Color_in,[],List_out).

%RECCOMPRESSRGBLIST_CLEAR
% UNIFICA UNA LISTA Y UNA LISTA DE ELEMENTOS R,G,B, CON UNA LISTA
% CUYOS ELEMENTOS SON AQUELLOS DE LA PRIMERA LISTA CUYOS VALORES
% COINCIDAN CON LOS VALORES INICIALES ENTREGADOS.
%
%COMPRESSRGBLIST_CLEAR
% EVALUA, SEGUN PREDICADO RECCOMPRESSRGBLIST_CLEAR, TRES LISTAS.
%
% DOMINIO: RECCOMPRESS_CLEAR: LISTA X LISTA X LISTA
%          COMPRESS_CLEAR: LISTA X LISTA X LISTA
% RECURSION: PILA

recCompressRGBList_clear([],[],_).
recCompressRGBList_clear([H|T],T2,[R,G,B]):-  select_pixrgb_red(H,R), select_pixrgb_green(H,G), select_pixrgb_blue(H,B), recCompressRGBList_clear(T,T2,[R,G,B]).
recCompressRGBList_clear([H|T],[H|T2],Color_in):- recCompressRGBList_clear(T,T2,Color_in).

compressRGBList_clear(List_in,Color_in,List_out):- recCompressRGBList_clear(List_in,List_out,Color_in).

%COMPRESSRGBMAP
% DADA UN TDA:IMAGE INICIAL, DETERMINA EL VALOR RGB MAS FRECUENTE EN
% ESTA. LUEGO CREA UNA LISTA CON AQUELLOS TDA:PIXRGB CUYO VALOR COINCIDA
% CON EL MAS FRECUENTE. FINALMENTE CREA UN TDA:IMAGE CUYO ULTIMA COLA
% CORRESPONDA A LA LISTA CREADA CON LA ULTIMA COLA DEL TDA:IMAGE
% INICIAL, AL IGUAL QUE ELIMINANDO DICHOS TDA:PIXRGB DEL CONTENIDO DE LA
% TDA:IMAGE INICIAL.
%
% DOMINIO: TDA:IMAGE X TDA:IMAGE(COMPRESSED)

compressPixmap(Image_in,Compressed_Image_out):- imageToHistogram(Image_in,Histo_out), mostFrequentRGBHisto(Histo_out,Color_out), select_pix_content(Image_in,Content_out), compressRGBList_newList(Content_out,Color_out,New_content), compressRGBList_clear(Content_out,Color_out,Clear_content), createCompressedImage(Image_in,[Color_out|New_content],Clear_content,Compressed_Image_out).

%COMPRESS HEX

%MOSTFREQUENTHEXHISTO
% EVALUA UNA LISTA CON UNA LISTA CUYO SEGUNDO ELEMENTO ES 0, A TRAVES
% DEL PREDICADO RECMOSTFREQUENTRECHISTO.
%
% DOMINIO: RECMOSTFREQUENTHEXHISTO: LISTA X LISTA X LISTA
%          MOSTFREQUENTHEXHISTO: LISTA X LISTA
% RECURSION: PILA

recMostFrequentHEXHisto([[H,A]|[]],[_,_,_,A2],[H]):- A > A2.
recMostFrequentHEXHisto([[_,A]|[]],[H,A2],[H]):- A =< A2.
recMostFrequentHEXHisto([[H,A]|T],[_,A2],Color_out):- A > A2, recMostFrequentRGBHisto(T,[H,A],Color_out).
recMostFrequentHEXHisto([[_,A]|T],[H,A2],Color_out):- A =< A2, recMostFrequentRGBHisto(T,[H,A2],Color_out).

mostFrequentHEXHisto(List_in,Color_out):- recMostFrequentHEXHisto(List_in,[_,0],Color_out).

%RECCOMPRESSHEXLIST_NEWLIST
% UNIFICA UNA LISTA Y UNA LISTA DE UN ELEMENTO, CON UNA LISTA
% CUYOS ELEMENTOS SON AQUELLOS DE LA PRIMERA LISTA CUYOS VALORES NO
% COINCIDAN CON EL VALOR INICIAL ENTREGADO.
%
%COMPRESSHEXLIST_NEWLIST
% EVALUA SEGUN PREDICADO RECCOMPRESSHEXLIST_NEWLIST TRES LISTAS.
%
% DOMINIO: RECCOMPRESS_NEWLIST: LISTA X LISTA X LISTA X LISTA
%          COMPRESS_NEWLIST: LISTA X LISTA X LISTA
% RECURSION: COLA

recCompressHEXList_newList([],_,List_out,List_out).
recCompressHEXList_newList([H|T],[HEX],List_aux,List_out):- select_pixhex_hex(H,HEX),select_pixhex_x(H,X),select_pixhex_y(H,Y), select_pixhex_depth(H,D), recCompressHEXList_newList(T,[HEX],[[X,Y,D]|List_aux],List_out).
recCompressHEXList_newList([_|T],Color_in,List_aux,List_out):- recCompressHEXList_newList(T,Color_in,List_aux,List_out).

compressHEXList_newList(List_in,Color_in,List_out):- recCompressHEXList_newList(List_in,Color_in,[],List_out).

%RECCOMPRESSHEXLIST_CLEAR
% UNIFICA UNA LISTA Y UNA LISTA DE UN ELEMENTO HEX, CON UNA LISTA
% CUYOS ELEMENTOS SON AQUELLOS DE LA PRIMERA LISTA CUYO VALOR
% COINCIDA CON EL VALOR INICIAL ENTREGADO.
%
%COMPRESSHEXBLIST_CLEAR
% EVALUA, SEGUN PREDICADO RECCOMPRESSHEXLIST_CLEAR, TRES LISTAS.
%
% DOMINIO: RECCOMPRESS_CLEAR: LISTA X LISTA X LISTA
%          COMPRESS_CLEAR: LISTA X LISTA X LISTA
% RECURSION: PILA

recCompressHEXList_clear([],[],_).
recCompressHEXList_clear([H|T],T2,[HEX]):-  select_pixhex_hex(H,HEX),recCompressHEXList_clear(T,T2,[HEX]).
recCompressHEXList_clear([H|T],[H|T2],Color_in):- recCompressHEXList_clear(T,T2,Color_in).

compressHEXList_clear(List_in,Color_in,List_out):- recCompressHEXList_clear(List_in,List_out,Color_in).

%COMPRESSHEXMAP
% DADA UN TDA:IMAGE INICIAL, DETERMINA EL VALOR HEX MAS FRECUENTE EN
% ESTA. LUEGO CREA UNA LISTA CON AQUELLOS TDA:PIXHEX CUYO VALOR COINCIDA
% CON EL MAS FRECUENTE. FINALMENTE CREA UN TDA:IMAGE CUYO ULTIMA COLA
% CORRESPONDA A LA LISTA CREADA CON LA ULTIMA COLA DEL TDA:IMAGE
% INICIAL, AL IGUAL QUE ELIMINANDO DICHOS TDA:PIXHEX DEL CONTENIDO DE
% LA TDA:IMAGE INICIAL.
%
% DOMINIO: TDA:IMAGE X TDA:IMAGE(COMPRESSED)

compressHexmap(Image_in,Compressed_Image_out):- imageToHistogram(Image_in,Histo_out),mostFrequentHEXHisto(Histo_out,[R,G,B]), rgbStringToHex(R,G,B,HEX_color), select_pix_content(Image_in,Content_out), compressHEXList_newList(Content_out,[HEX_color],New_content), compressHEXList_clear(Content_out,[HEX_color],Clear_content), createCompressedImage(Image_in,[[HEX_color]|New_content],Clear_content,Compressed_Image_out).

%COMPRESS
% DETERMINA EL TIPO DE TDA:IMAGE QUE SE LE ENTREGO, Y LUEGO APLICA EL
% PREDICADO DE COMPRESION DETERMINADO.
%
% DOMINIO: TDA:IMAGE X TDA:IMAGE(COMPRESSED)

compress(Image_in,Compressed_Image_out):- imageIsBitmap(Image_in), compressBitmap(Image_in,Compressed_Image_out).
compress(Image_in,Compressed_Image_out):- imageIsPixmap(Image_in), compressPixmap(Image_in,Compressed_Image_out).
compress(Image_in,Compressed_Image_out):- imageIsHexmap(Image_in), compressHexmap(Image_in,Compressed_Image_out).

%IMAGECHANGEPIXELREC
% UNIFICA UNA LISTA Y UN TDA:PIX, CON UNA NUEVA LISTA EN LA CUAL LA
% POSICION CORRESPONDIENTE AL TDA:PIX INICIAL, ES REEMPLAZADA POR ESTE.
%
% DOMINIO: LISTA X TDA:PIX X LISTA
% RECURSION: PILA

imageChangePixelRec([],New_pix,[New_pix|[]]).
imageChangePixelRec([H|T],New_pix,[New_pix|T]):- select_pix_x(H,X), select_pix_x(New_pix,X), select_pix_y(H,Y), select_pix_y(New_pix,Y).
imageChangePixelRec([H|T],New_pix,[H|T2]):- imageChangePixelRec(T,New_pix,T2).

%VALIDATE_ENTRIES_ICP
% LUEGO DE DETERMINAR EL TIPO DE TDA:IMAGE Y TDA:PIX QUE SE LE
% ENTREGA, EVALUA EL CONTENIDO DE DICHO TDA:IMAGE Y EL TDA:PIX CON EL
% PREDICADO IMAGECHANGEPIXELREC. FINALMENTE, LO UNIFICA CON UNA IMAGEN
% IDENTICA A LA INICIAL, EN LA CUAL SE REEMPLAZO EL TDA:PIX
% CORRESPONDIENTE.
%
% DOMINIO: TDA:IMAGE X TDA:PIXBIT/TDA:PIXRGB/TDA:PIXHEX X IMAGE

validate_entries_ICP(Image_in,New_pix,Image_out):- imageIsBitmap(Image_in), isPixbit(New_pix), select_pix_content(Image_in,Content_in),imageChangePixelRec(Content_in,New_pix,Content_out),select_pix_x(Image_in,X),select_pix_y(Image_in,Y),image(X,Y,Content_out,Image_out).
validate_entries_ICP(Image_in,New_pix,Image_out):- imageIsPixmap(Image_in), isPixrgb(New_pix), select_pix_content(Image_in,Content_in),imageChangePixelRec(Content_in,New_pix,Content_out),select_pix_x(Image_in,X),select_pix_y(Image_in,Y),image(X,Y,Content_out,Image_out).
validate_entries_ICP(Image_in,New_pix,Image_out):- imageIsHexmap(Image_in), isPixhex(New_pix), select_pix_content(Image_in,Content_in),imageChangePixelRec(Content_in,New_pix,Content_out),select_pix_x(Image_in,X),select_pix_y(Image_in,Y),image(X,Y,Content_out,Image_out).

%IMAGECHANGEPIXEL
% UNIFICA UN TDA:IMAGE Y UN TDA:PIX, CON UN TDA:IMAGE NUEVO SEGUN LO
% EVALUADO POR EL PREDICADO VALIDATE_ENTRIES_ICP.
%
% DOMINIO: TDA:IMAGE X TDA:PIXBIT/TDA:PIXRGB/TDA:PIXHEX X TDA:IMAGE

imageChangePixel(Image_in,New_pix,Image_out):- select_pix_x(Image_in,X_in), select_pix_y(Image_in,Y_in), select_pix_x(New_pix,XPix_in), select_pix_y(New_pix,YPix_in), X_in > XPix_in, Y_in > YPix_in, validate_entries_ICP(Image_in,New_pix,Image_out).

%IMAGEINVERTCOLORRGBREC
% DADA UNA LISTA DE TDA:PIXRGB, UNIFICA LOS ELEMENTOS DE ESTA CON UNA
% LISTA DE TDA:RGB CON SUS VALORES INVERTIDOS (255 - VALOR ASOCIADO).
%
% DOMINIO: IMAGEINVET...REC: LISTA (TDA:PIXRGB) X LISTA (TDA:PIXRGB)
%          IMAGEINVERTCOLORRGB: TDA:IMAGE X TDA:IMAGE
% RECURSION: PILA

imageInvertColorRGBRec([],[]).
imageInvertColorRGBRec([H|T],[H2|T2]):-select_pixrgb_red(H,R), select_pixrgb_green(H,G), select_pixrgb_blue(H,B), R_2 is 255-R, G_2 is 255-G, B_2 is 255-B, mod_pixrgb_red(H,R_2,H_R), mod_pixrgb_green(H_R,G_2,H_RG), mod_pixrgb_blue(H_RG,B_2,H2), imageInvertColorRGBRec(T,T2).

imageInvertColorRGB([X,Y,Content_in],[X,Y,Content_out]):- imageInvertColorRGBRec(Content_in,Content_out).


%IMAGE->STRING

%GETPIX_OUT
% DADOS DOS ENTEROS X,Y, Y UNA LISTA DE TDA:PIX, UNIFICA LA CABEZA
% ACTUAL DE DICHA LISTA CUANDO SUS COORDENADAS X,Y COINCIDEN CON EL X,Y
% INGRESADO.
%
% DOMINIO: ENTERO X ENTERO X LISTA X ELEMENTO
% RECURSION: COLA

getPix_out(CurrentX,CurrentY,[H|_],H):- select_pix_x(H,CurrentX), select_pix_y(H,CurrentY).
getPix_out(CurrentX,CurrentY,[_|T],Pix_out):- getPix_out(CurrentX,CurrentY,T,Pix_out).

%GETPIX_CLEAR
% DADOS DOS ENTEROS X,Y, Y DOS LISTAS DE TDA:PIX, UNIFICA LAS CABEZAS DE
% DICHAS LISTAS, EN TANTO LAS COORDENADAS X,Y, DE DICHA CABEZA NO
% COINCIDAN CON EL X,Y, INGRESADO.
%
% DOMINIO: ENTERO X ENTERO X LISTA X LISTA
% RECURSION: PILA

getPix_clear(_,_,[],[]).
getPix_clear(CurrentX,CurrentY,[H|T],T):- select_pix_x(H,CurrentX),select_pix_y(H,CurrentY).
getPix_clear(CurrentX,CurrentY,[H|T1],[H|T2]):- getPix_clear(CurrentX,CurrentY,T1,T2).

%SORT_CONTENT
% ORDENA SEGUN POSICION X,Y, LOS ELEMENTOS DE UNA LISTA DE TDA:PIX.
%
% DOMINIO: ENTERO X ENTERO X ENTERO X ENTERO X LISTA X LISTA
% RECURSION: PILA

sort_Content(XSize,YSize,XSize,YSize,_,[]).
sort_Content(CurrentX,YSize,XSize,YSize,List_in,List_out):- sort_Content(CurrentX,0,XSize,YSize,List_in,List_out).
sort_Content(CurrentX,YSize,XSize,YSize,List_in,List_out):- NextX is CurrentX+1, sort_Content(NextX,YSize,XSize,YSize,List_in,List_out).
sort_Content(CurrentX,CurrentY,XSize,YSize,List_in,[Pix_out|List_out]):- getPix_out(CurrentX,CurrentY,List_in,Pix_out), getPix_clear(CurrentX,CurrentY,List_in,Clear_List), Y_up is CurrentY+1, sort_Content(CurrentX,Y_up,XSize,YSize,Clear_List,List_out).

%SORT_IMAGE
% UNIFICA DOS TDA:IMAGE CON ANCHO Y ALTO IDENTICOS, Y CUYOS CONTENT
% HAN SIDO EVALUADOS POR EL PREDICADO SORT_CONTENT.
%
% DOMINIO: TDA:IMAGE X TDA:IMAGE

sort_Image(Image_in,Image_out):- select_pix_x(Image_in,X), select_pix_y(Image_in,Y), select_pix_content(Image_in,Content), sort_Content(0,0,X,Y,Content,New_content), image(X,Y,New_content,Image_out).

%BITMAP->STRING
%
%BITLISTTOSTRING
% CREA UN STRING QUE CONTIENE LOS VALORES ORDENADOS DE UNA LISTA DE
% TDA:PIXBIT.
%
% DOMINIO: ENTERO X LISTA X STRING X STRING
% RECURSION: COLA

bitListToString(_,[],String_out,String_out).
bitListToString(Y,[H|T],String_aux,String_out):- select_pixbit_y(H,H_Y), Y is H_Y+1, select_pixbit_value(H,H_BIN), string_concat(String_aux,H_BIN,String_aux2), string_concat(String_aux2,"\n",String_aux3), bitListToString(Y,T,String_aux3,String_out).
bitListToString(Y,[H|T],String_aux,String_out):- select_pixbit_value(H,H_BIN), string_concat(String_aux,H_BIN,String_aux2), bitListToString(Y,T,String_aux2,String_out).

%BITMAPTOSTRING
% CREA UN STRING QUE CONTIENE LOS ELEMENTOS DE UN TDA:IMAGE TIPO BITMAP.
%
% DOMINIO: TDA:IMAGE X STRING

bitmapToString(Image_In,String_out):- select_pix_y(Image_In,Y),select_pix_content(Image_In,Content_out),bitListToString(Y,Content_out,"",String_out).

%PIXMAP->STRING
%
%PIXLISTTOSTRING
% CREA UN STRING QUE CONTIENE LOS VALORES ORDENADOS DE UNA LISTA DE
% TDA:PIXRGB.
%
% DOMINIO: ENTERO X LISTA X STRING X STRING
% RECURSION: COLA

pixListToString(_,[],String_out,String_out).
pixListToString(Y,[H|T],String_aux,String_out):- select_pixrgb_y(H,H_Y), Y is H_Y+1, select_pixrgb_red(H,H_RED),select_pixrgb_green(H,H_GREEN), select_pixrgb_blue(H,H_BLUE),string_concat(String_aux,"R:",String_aux2), string_concat(String_aux2,H_RED,String_aux3), string_concat(String_aux3,",G:",String_aux4),string_concat(String_aux4,H_GREEN,String_aux5),string_concat(String_aux5,"B:",String_aux6),string_concat(String_aux6,H_BLUE,String_aux7),string_concat(String_aux7,"\n",String_aux8),pixListToString(Y,T,String_aux8,String_out).
pixListToString(Y,[H|T],String_aux,String_out):- select_pixrgb_red(H,H_RED),select_pixrgb_green(H,H_GREEN), select_pixrgb_blue(H,H_BLUE),string_concat(String_aux,"R:",String_aux2), string_concat(String_aux2,H_RED,String_aux3), string_concat(String_aux3," G:",String_aux4),string_concat(String_aux4,H_GREEN,String_aux5),string_concat(String_aux5," B:",String_aux6),string_concat(String_aux6,H_BLUE,String_aux7),string_concat(String_aux7,"\t",String_aux8),pixListToString(Y,T,String_aux8,String_out).

%PIXMAPTOSTRING
% CREA UN STRING QUE CONTIENE LOS ELEMENTOS DE UN TDA:IMAGE TIPO PIXMAP.
%
% DOMINIO: TDA:IMAGE X STRING

pixmapToString(Image_In,String_out):- select_pix_y(Image_In,Y),select_pix_content(Image_In,Content_out),pixListToString(Y,Content_out,"",String_out).

%HEXMAP->STRING
%
%HEXLISTTOSTRING
% CREA UN STRING QUE CONTIENE LOS VALORES ORDENADOS DE UNA LISTA DE
% TDA:PIXHEX.
%
% DOMINIO: ENTERO X LISTA X STRING X STRING
% RECURSION: COLA

hexListToString(_,[],String_out,String_out).
hexListToString(Y,[H|T],String_aux,String_out):- select_pixhex_y(H,H_Y), Y is H_Y+1, select_pixhex_hex(H,H_HEX),string_concat(String_aux,H_HEX,String_aux2),string_concat(String_aux2,"\n",String_aux8),hexListToString(Y,T,String_aux8,String_out).
hexListToString(Y,[H|T],String_aux,String_out):- select_pixhex_hex(H,H_HEX),string_concat(String_aux,H_HEX,String_aux2),string_concat(String_aux2," ",String_aux8),hexListToString(Y,T,String_aux8,String_out).

%HEXMAPTOSTRING
% CREA UN STRING QUE CONTIENE LOS ELEMENTOS DE UN TDA:IMAGE TIPO HEXMAP.
%
% DOMINIO: TDA:IMAGE X STRING

hexmapToString(Image_In,String_out):- select_pix_y(Image_In,Y),select_pix_content(Image_In,Content_out),hexListToString(Y,Content_out,"",String_out).

%IMAGETOSTRING_BACK
% CREA UN STRING QUE CONTIENE LOS ATRIBUTOS DE UNA IMAGEN.
%
% DOMINIO: TDA:IMAGE X STRING

imageToString_back(Image_In,String_out):-  select_pix_x(Image_In,X), select_pix_y(Image_In,Y), string_concat("Alto(X):",X,String_1), string_concat(";Ancho(Y):",Y,String_2), string_concat(String_1,String_2,String_3), string_concat(String_3,"\n\n",String_out).

%IMAGETOSTRING
% DETERMINA EL TIPO DE TDA:IMAGE QUE SE LE ENTREGA, Y LUEGO DE ORDENAR
% LA IMAGEN, UNIFICA UN STRING DE SALIDA CON LO ENTREGADO POR LA FUNCION
% DE X-MAPTOSTRING CORRESPONDIENTE.
%
% DOMINIO: TDA:IMAGE X STRING

imageToString(Image_in,String_out):- imageIsBitmap(Image_in),sort_Image(Image_in,Image_out),imageToString_back(Image_in,String_1),bitmapToString(Image_out,String_2),string_concat(String_1,String_2,String_out).
imageToString(Image_in,String_out):- imageIsPixmap(Image_in),sort_Image(Image_in,Image_out),imageToString_back(Image_in,String_1),pixmapToString(Image_out,String_2),string_concat(String_1,String_2,String_out).
imageToString(Image_in,String_out):- imageIsHexmap(Image_in),sort_Image(Image_in,Image_out),imageToString_back(Image_in,String_1),hexmapToString(Image_out,String_2),string_concat(String_1,String_2,String_out).

%CREATEBASEIMAGE
% CREA UNA IMAGEN DE DIMENSIONES X,Y, CON UN TDA:PIX BASICO ASOCIADO.
%
% DOMINIO: ENTERO X ENTERO X ENTERO X ENTERO X TDA:PIXBIT/TDA:PIXHEX X
% ENTERO X LISTA X TDA:IMAGE
% RECURSION: COLA

createBaseImage(XSize,0,XSize,YSize,_,_,Image_out,[XSize,YSize,Image_out]).
createBaseImage(CurrentX,YSize,XSize,YSize,BasePix,Depth,Image_aux,Image_out):- NextX is CurrentX+1, createBaseImage(NextX,0,XSize,YSize,BasePix,Depth,Image_aux,Image_out).
createBaseImage(CurrentX,CurrentY,XSize,YSize,BasePix,Depth,Image_aux,Image_out):- create_pix(CurrentX,CurrentY,[BasePix|[Depth]],Pix_out), NextY is CurrentY+1, createBaseImage(CurrentX,NextY,XSize,YSize,BasePix,Depth,[Pix_out|Image_aux],Image_out).

%CREATEBASERGBIMAGE
% CREA UNA IMAGEN DE DIMENSIONES X,Y, CON UN TDA:PIX BASICO ASOCIADO.
%
% DOMINIO: ENTERO X ENTERO X ENTERO X ENTERO X TDA:PIXRGB X ENTERO X LISTA X TDA:IMAGE
% RECURSION: COLA

createBaseRGBImage(XSize,0,XSize,YSize,_,_,_,_,Image_out,[XSize,YSize,Image_out]).
createBaseRGBImage(CurrentX,YSize,XSize,YSize,R,G,B,Depth,Image_aux,Image_out):- NextX is CurrentX+1, createBaseRGBImage(NextX,0,XSize,YSize,R,G,B,Depth,Image_aux,Image_out).
createBaseRGBImage(CurrentX,CurrentY,XSize,YSize,R,G,B,Depth,Image_aux,Image_out):- pixrgb(CurrentX,CurrentY,R,G,B,Depth,Pix_out), NextY is CurrentY+1, createBaseRGBImage(CurrentX,NextY,XSize,YSize,R,G,B,Depth,[Pix_out|Image_aux],Image_out).


%GETNDEPTH(HEX/BIT)
%
%GETNDEPTH_LIST
% UNIFICA DOS LISTAS, DONDE LA SEGUNDA ES LA RECOLECCION DE TODOS LOS
% ELEMENTOS CON UNA PROFUNDIDAD ASOCIADA IGUAL A LA ENTREGADA AL
% PREDICADO.
%
% GETNDEPTH_CLEAR
% UNIFICA DOS LISTAS, DONDE LA SEGUNDA ES LA RECOLECCION DE TODOS LOS
% ELEMENTOS QUE NO POSEEN UNA PROFUNDIDAD ASOCIADA IGUAL A LA ENTREGADA
% AL PREDICADO.
%
% DOMINIO: _LIST: LISTA X ENTERO X LISTA X LISTA
%          _CLEAR: LISTA X ENTERO X LISTA X LISTA
%
% RECURSION: COLA

getNDepth_list([],_,List_out,List_out).
getNDepth_list([H|T],NDepth,List_aux,List_out):- select_pix_depth(H,NDepth),getNDepth_list(T,NDepth,[H|List_aux],List_out).
getNDepth_list([_|T],NDepth,List_aux,List_out):- getNDepth_list(T,NDepth,List_aux,List_out).

getNDepth_clear([],_,List_out,List_out).
getNDepth_clear([H|T],NDepth,List_aux,List_out):- select_pix_depth(H,NDepth),getNDepth_clear(T,NDepth,List_aux,List_out).
getNDepth_clear([H|T],NDepth,List_aux,List_out):- getNDepth_clear(T,NDepth,[H|List_aux],List_out).

%GETNDEPTH_RGB
%
%GETNDEPTHRGB_LIST
% UNIFICA DOS LISTAS, DONDE LA SEGUNDA ES LA RECOLECCION DE TODOS LOS
% ELEMENTOS CON UNA PROFUNDIDAD ASOCIADA IGUAL A LA ENTREGADA AL
% PREDICADO.
%
% GETNDEPTHRGB_CLEAR
% UNIFICA DOS LISTAS, DONDE LA SEGUNDA ES LA RECOLECCION DE TODOS LOS
% ELEMENTOS QUE NO POSEEN UNA PROFUNDIDAD ASOCIADA IGUAL A LA ENTREGADA
% AL PREDICADO.
%
% DOMINIO: _LIST: LISTA X ENTERO X LISTA X LISTA
%          _CLEAR: LISTA X ENTERO X LISTA X LISTA
%
% RECURSION: COLA

getNDepthRGB_list([],_,List_out,List_out).
getNDepthRGB_list([H|T],NDepth,List_aux,List_out):- select_pixrgb_depth(H,NDepth),getNDepthRGB_list(T,NDepth,[H|List_aux],List_out).
getNDepthRGB_list([_|T],NDepth,List_aux,List_out):- getNDepthRGB_list(T,NDepth,List_aux,List_out).

getNDepthRGB_clear([],_,List_out,List_out).
getNDepthRGB_clear([H|T],NDepth,List_aux,List_out):- select_pixrgb_depth(H,NDepth),getNDepthRGB_clear(T,NDepth,List_aux,List_out).
getNDepthRGB_clear([H|T],NDepth,List_aux,List_out):- getNDepthRGB_clear(T,NDepth,[H|List_aux],List_out).

%DEPTHLAYERS_REC
%
%INSERTPIXLIST
% UNO POR UNO, REEMPLAZA LOS ELEMENTOS DE UN TDA:IMAGE ENTREGADO, POR
% LOS ELEMENTOS ASOCIADOS CORRESPONDIENTES RECOLECTADOS EN UNA LISTA.
%
% DOMINIO: LISTA X TDA:IMAGE X TDA:IMAGE
% RECURSION: COLA

insertPixList([],Image_out,Image_out).
insertPixList([H|T],Image_in,Image_out):- imageChangePixel(Image_in,H,Image_aux),insertPixList(T,Image_aux,Image_out).

%BITDEPTHLAYERS
% CREA UNA LISTA DE TDA:IMAGE, CON TDA:PIXBIT QUE COMPARTEN LA MISMA
% PROFUNDIDAD EN CADA UNA.
%
% DOMINIO: ENTERO X ENTERO X LISTA X LISTA X LISTA
% RECURSION: COLA

bitDepthLayers(_,_,[],List_out,List_out).
bitDepthLayers(X,Y,[H|T],List_in,List_out):- select_pixbit_depth(H,D),createBaseImage(0,0,X,Y,1,D,[],Image_aux),getNDepth_list([H|T],D,[],List_aux),insertPixList(List_aux,Image_aux,Image_out),getNDepth_clear([H|T],D,[],List_aux2),bitDepthLayers(X,Y,List_aux2,[Image_out|List_in],List_out).

%RGBDEPTHLAYERS
% CREA UNA LISTA DE TDA:IMAGE, CON TDA:PIXRGB QUE COMPARTEN LA MISMA
% PROFUNDIDAD EN CADA UNA.
%
% DOMINIO: ENTERO X ENTERO X LISTA X LISTA X LISTA
% RECURSION: COLA

rgbDepthLayers(_,_,[],List_out,List_out).
rgbDepthLayers(X,Y,[H|T],List_in,List_out):- select_pixrgb_depth(H,D),createBaseRGBImage(0,0,X,Y,255,255,255,D,[],Image_aux),getNDepthRGB_list([H|T],D,[],List_aux),insertPixList(List_aux,Image_aux,Image_out),getNDepthRGB_clear([H|T],D,[],List_aux2),rgbDepthLayers(X,Y,List_aux2,[Image_out|List_in],List_out).

%HEXDEPTHLAYERS
% CREA UNA LISTA DE TDA:IMAGE, CON TDA:PIXHEX QUE COMPARTEN LA MISMA
% PROFUNDIDAD EN CADA UNA.
%
% DOMINIO: ENTERO X ENTERO X LISTA X LISTA X LISTA
% RECURSION: COLA

hexDepthLayers(_,_,[],List_out,List_out).
hexDepthLayers(X,Y,[H|T],List_in,List_out):- select_pixhex_depth(H,D),createBaseImage(0,0,X,Y,"FFFFFF",D,[],Image_aux),getNDepth_list([H|T],D,[],List_aux),insertPixList(List_aux,Image_aux,Image_out),getNDepth_clear([H|T],D,[],List_aux2),hexDepthLayers(X,Y,List_aux2,[Image_out|List_in],List_out).

%IMAGEDEPTHLAYERS
% DETERMINA EL TIPO DE TDA:IMAGE QUE SE LE ESTA ENTREGANDO, Y LUEGO LO
% UNIFICA CON UNA LISTA DE TDA:IMAGE QUE RECOLECTA Y COMPILA LOS
% DISTINTOS TDA:PIX SEGUN SU PROFUNDIDAD.
%
% DOMINIO: TDA:IMAGE X LISTA

imageDepthLayers(Image_in,List_out):- isBitmap(Image_in),select_pix_x(Image_in,X), select_pix_y(Image_in,Y), select_pix_content(Image_in,Content),bitDepthLayers(X,Y,Content,[],List_out).
imageDepthLayers(Image_in,List_out):- isPixmap(Image_in),select_pix_x(Image_in,X), select_pix_y(Image_in,Y), select_pix_content(Image_in,Content),rgbDepthLayers(X,Y,Content,[],List_out).
imageDepthLayers(Image_in,List_out):- isHexmap(Image_in),select_pix_x(Image_in,X), select_pix_y(Image_in,Y), select_pix_content(Image_in,Content),hexDepthLayers(X,Y,Content,[],List_out).

%DECOMPRESSBITMAP

%UNPACK_COMPRESSEDBIT
% UNIFICA UNA LISTA DE TDA:PIXBIT(COMPRIMIDO) CON SU HOMOLOGO,
% DESCOMPRIMIDO (CREA TDA: PIXBIT CON VALOR [0/1] COMPARTIDO, Y VALORES
% X,Y,DEPTH DE CADA ELEMENTO).
%
% DOMINIO: ENTERO X LISTA X LISTA X LISTA
% RECURSION: COLA

unpack_CompressedBit(_,[],List_out,List_out).
unpack_CompressedBit(-1,[[A]|T],List_aux,List_out):- integer(A), unpack_CompressedBit(A,T,List_aux,List_out).
unpack_CompressedBit(A,[[X,Y,D]|T],List_aux,List_out):- pixbit(X,Y,A,D,Pixbit), unpack_CompressedBit(A,T,[Pixbit|List_aux],List_out).

%UNPACK_COMPRESSEDBITMAP
% UNIFICA UNA IMAGEN COMPRIMIDA CON EL PRIMER ELEMENTO DE SU END
% DESCOMPRIMIDO.
%
% DOMINIO: TDA:IMAGE X LISTA

unpack_CompressedBitmap(Image_in,Image_out):- imageIsCompressed(Image_in),select_pix_end(Image_in,[H|_]), unpack_CompressedBit(-1,H,[],Image_out).

%CONCAT_PIXLIST
% UNIFICA DOS LISTAS CON UNA LISTA QUE ES LA CONCATENACION DE AMBAS
% LISTAS INICIALES.
%
% DOMINIO: LISTA X LISTA X LISTA
% RECURSION: PILA

concat_PixList([],List_out,List_out).
concat_PixList([H|T],List_2,[H|T2]):- concat_PixList(T,List_2,T2).

%DECOMPRESSBITMAP
% UNIFICA UNA TDA:IMAGE BITMAP, CON SU HOMOLOGO DESCOMPRIMIDO.
%
% DOMINIO: TDA:IMAGE X TDA:IMAGE

decompressBitmap(Image_in,[X,Y,List_out|T]):- select_pix_x(Image_in,X),select_pix_y(Image_in,Y),unpack_CompressedBitmap(Image_in,List_aux),select_pix_content(Image_in,Content_out),select_pix_end(Image_in,[_|T]),concat_PixList(Content_out,List_aux,List_out).

%DECOMPRESSPIXMAP
%
%UNPACK_COMPRESSEDPIX
% UNIFICA UNA LISTA DE TDA:PIXRGB(COMPRIMIDO) CON SU HOMOLOGO,
% DESCOMPRIMIDO (CREA TDA: PIXRGB CON VALORES RGB COMPARTIDO, Y VALORES
% X,Y,DEPTH DE CADA ELEMENTO).
%
% DOMINIO: ENTERO X ENTERO X ENTERO X LISTA X LISTA X LISTA
% RECURSION: COLA

unpack_CompressedPix(_,_,_,[],List_out,List_out).
unpack_CompressedPix(-1,-1,-1,[[A,B,C]|T],List_aux,List_out):- integer(A), integer(B), integer(C), unpack_CompressedPix(A,B,C,T,List_aux,List_out).
unpack_CompressedPix(A,B,C,[[X,Y,D]|T],List_aux,List_out):- pixrgb(X,Y,A,B,C,D,Pixbit), unpack_CompressedPix(A,B,C,T,[Pixbit|List_aux],List_out).


%UNPACK_COMPRESSEDPIXMAP
% UNIFICA UNA IMAGEN COMPRIMIDA CON EL PRIMER ELEMENTO DE SU END
% DESCOMPRIMIDO.
%
% DOMINIO: TDA:IMAGE X LISTA

unpack_CompressedPixmap(Image_in,Image_out):- imageIsCompressed(Image_in),select_pix_end(Image_in,[H|_]), unpack_CompressedPix(-1,-1,-1,H,[],Image_out).

%DECOMPRESSPIXMAP
% UNIFICA UNA TDA:IMAGE PIXMAP, CON SU HOMOLOGO DESCOMPRIMIDO.
%
% DOMINIO: TDA:IMAGE X TDA:IMAGE

decompressPixmap(Image_in,[X,Y,List_out|T]):- select_pix_x(Image_in,X),select_pix_y(Image_in,Y),unpack_CompressedPixmap(Image_in,List_aux),select_pix_content(Image_in,Content_out),select_pix_end(Image_in,[_|T]),concat_PixList(Content_out,List_aux,List_out).


%DECOMPRESSHEXMAP
%
%UNPACK_COMPRESSEDHEX
% UNIFICA UNA LISTA DE TDA:PIXHEX(COMPRIMIDO) CON SU HOMOLOGO,
% DESCOMPRIMIDO (CREA TDA: PIXHEX CON VALOR HEX COMPARTIDO, Y VALORES
% X,Y,DEPTH DE CADA ELEMENTO).
%
% DOMINIO: ENTERO X ENTERO X ENTERO X LISTA X LISTA X LISTA
% RECURSION: COLA

unpack_CompressedHex(_,[],List_out,List_out).
unpack_CompressedHex(-1,[[A]|T],List_aux,List_out):- string(A), unpack_CompressedHex(A,T,List_aux,List_out).
unpack_CompressedHex(A,[[X,Y,D]|T],List_aux,List_out):- pixhex(X,Y,A,D,Pixbit), unpack_CompressedHex(A,T,[Pixbit|List_aux],List_out).

%UNPACK_COMPRESSEDPIXMAP
% UNIFICA UNA IMAGEN COMPRIMIDA CON EL PRIMER ELEMENTO DE SU END
% DESCOMPRIMIDO.
%
% DOMINIO: TDA:IMAGE X LISTA

unpack_CompressedHexmap(Image_in,Image_out):- imageIsCompressed(Image_in),select_pix_end(Image_in,[H|_]), unpack_CompressedHex(-1,H,[],Image_out).

%DECOMPRESSPIXMAP
% UNIFICA UNA TDA:IMAGE HEXMAP, CON SU HOMOLOGO DESCOMPRIMIDO.
%
% DOMINIO: TDA:IMAGE X TDA:IMAGE

decompressHexmap(Image_in,[X,Y,List_out|T]):- select_pix_x(Image_in,X),select_pix_y(Image_in,Y),unpack_CompressedHexmap(Image_in,List_aux),select_pix_content(Image_in,Content_out),select_pix_end(Image_in,[_|T]),concat_PixList(Content_out,List_aux,List_out).

%DECOMPRESS
% DETERMINA EL TIPO DE TDA:IMAGE QUE SE LE ESTA ENTREGANDO, Y EVALUA CON
% EL PREDICADO ASOCIADO DE DESCOMPRESION APROPIADO.
%
% DOMINIO: TDA:IMAGE X TDA:IMAGE

decompress(Image_in,Compressed_Image_out):- imageIsBitmap(Image_in), decompressBitmap(Image_in,Compressed_Image_out).
decompress(Image_in,Compressed_Image_out):- imageIsPixmap(Image_in), decompressPixmap(Image_in,Compressed_Image_out).
decompress(Image_in,Compressed_Image_out):- imageIsHexmap(Image_in), decompressHexmap(Image_in,Compressed_Image_out).



