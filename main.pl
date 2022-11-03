:-use_module('TDA-pixbit').
:-use_module('TDA-pixrgb').
:-use_module('TDA-pixhex').
:-use_module('TDA-hexString').
:-use_module('TDA-image').

%CONSTRUCTOR
%
%TDA: IMAGE
% ENTERO X ENTERO X LISTA X TDA:IMAGE

image(X,Y,Content,[X,Y,Content]).

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

%IMAGEFLIPH
% UNIFICA DOS IMAGENES CON ALTO Y ANCHO IGUALES ENTRE ELLAS, LUEGO DE
% INGRESAR SU PRIMER ELEMENTO(X) Y SUS CONTENIDOS CON PREDICADO FLIPHREC.
%
% DOMINIO: LISTA X LISTA

imageFlipH([X,Y,Content],[X,Y,Content_2]):- flipHRec(X,Content,Content_2).

%IMAGEFLIPH
% UNIFICA DOS IMAGENES CON ALTO Y ANCHO IGUALES ENTRE ELLAS, LUEGO DE
% INGRESAR SU SEGUNDO ELEMENTO(Y) Y SUS CONTENIDOS CON PREDICADO FLIPVREC.
%
% DOMINIO: LISTA X LISTA

imageFlipV([X,Y,Content],[X,Y,Content_2]):- flipVRec(Y,Content,Content_2).

%IMAGECROP
%
% UNIFICA UNA LISTA DE TDA:PIX, CON CUATRO ENTEROS, CORRESPONDIENTES A
% DOS COORDENADAS, Y UNA NUEVA LISTA DE TDA:PIX, DONDE SE ENCUENTREN LOS
% ELEMENTOS DE LA LISTA INICIAL QUE SE ENCUENTREN DENTRO DE LOS
% PARAMETROS ENTREGADOS.
%
% DOMINIO: LISTA X ENTERO X ENTERO X ENTERO X ENTERO X LISTA
%

imageCrop([X,Y,Content_in],X_1,Y_1,X_2,Y_2,[X,Y,Content_out]):- cropRec(X_1,Y_1,X_2,Y_2,Content_in,Content_out).

%IMAGERGBTOHEX
% UNIFICA DOS IMAGENES CON LARGO Y ANCHO (X,Y) IGUALES, Y SUS CONTENIDOS
% EVALUADOS SEGUN PREDICADO RECPIXLISTRGBTOHEX.
%
% DOMINIO: LISTA (PIXRGB) X LISTA (PIXHEX)
% RECURSION: PILA.

imageRGBtoHex([X,Y,Content_in],[X,Y,Content_out]):- recPixListRGBtoHex(Content_in,Content_out).

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

%IMAGEROTATE90
% UNIFICA DOS TDA:IMAGE CUYOS ANCHO Y ALTO COINCIDEN, EN TANTO SUS
% CONTENIDOS SE RELACIONAN SEGUN EL PREDICADO IMAGEROTATE90REC,
% ROTANDOLO EN 90 GRADOS ANTIHORARIO.
%
% DOMINIO: TDA:IMAGE X TDA:IMAGE

imageRotate90([X,Y,Content],[Y,X,Content_2]):- imageRotate90Rec(Y,Content,Content_2).

%COMPRESS
% DETERMINA EL TIPO DE TDA:IMAGE QUE SE LE ENTREGO, Y LUEGO APLICA EL
% PREDICADO DE COMPRESION DETERMINADO.
%
% DOMINIO: TDA:IMAGE X TDA:IMAGE(COMPRESSED)

compress(Image_in,Compressed_Image_out):- imageIsBitmap(Image_in), compressBitmap(Image_in,Compressed_Image_out).
compress(Image_in,Compressed_Image_out):- imageIsPixmap(Image_in), compressPixmap(Image_in,Compressed_Image_out).
compress(Image_in,Compressed_Image_out):- imageIsHexmap(Image_in), compressHexmap(Image_in,Compressed_Image_out).

%IMAGECHANGEPIXEL
% UNIFICA UN TDA:IMAGE Y UN TDA:PIX, CON UN TDA:IMAGE NUEVO SEGUN LO
% EVALUADO POR EL PREDICADO VALIDATE_ENTRIES_ICP.
%
% DOMINIO: TDA:IMAGE X TDA:PIXBIT/TDA:PIXRGB/TDA:PIXHEX X TDA:IMAGE

imageChangePixel(Image_in,New_pix,Image_out):- select_pix_x(Image_in,X_in), select_pix_y(Image_in,Y_in), select_pix_x(New_pix,XPix_in), select_pix_y(New_pix,YPix_in), X_in > XPix_in, Y_in > YPix_in, validate_entries_ICP(Image_in,New_pix,Image_out).

%IMAGEINVERTCOLORRGBREC
% DADA UN TDA:IMAGE, UNIFICA CON IMAGEN QUE RECOLECTE SUS VALORES
% INVERTIDOS (255 - VALOR ASOCIADO).

imageInvertColorRGB([X,Y,Content_in],[X,Y,Content_out]):- imageInvertColorRGBRec(Content_in,Content_out).

%IMAGETOSTRING
% DETERMINA EL TIPO DE TDA:IMAGE QUE SE LE ENTREGA, Y LUEGO DE ORDENAR
% LA IMAGEN, UNIFICA UN STRING DE SALIDA CON LO ENTREGADO POR LA FUNCION
% DE X-MAPTOSTRING CORRESPONDIENTE.
%
% DOMINIO: TDA:IMAGE X STRING

imageToString(Image_in,String_out):- imageIsBitmap(Image_in),sort_Image(Image_in,Image_out),imageToString_back(Image_in,String_1),bitmapToString(Image_out,String_2),string_concat(String_1,String_2,String_out).
imageToString(Image_in,String_out):- imageIsPixmap(Image_in),sort_Image(Image_in,Image_out),imageToString_back(Image_in,String_1),pixmapToString(Image_out,String_2),string_concat(String_1,String_2,String_out).
imageToString(Image_in,String_out):- imageIsHexmap(Image_in),sort_Image(Image_in,Image_out),imageToString_back(Image_in,String_1),hexmapToString(Image_out,String_2),string_concat(String_1,String_2,String_out).

%IMAGEDEPTHLAYERS
% DETERMINA EL TIPO DE TDA:IMAGE QUE SE LE ESTA ENTREGANDO, Y LUEGO LO
% UNIFICA CON UNA LISTA DE TDA:IMAGE QUE RECOLECTA Y COMPILA LOS
% DISTINTOS TDA:PIX SEGUN SU PROFUNDIDAD.
%
% DOMINIO: TDA:IMAGE X LISTA

imageDepthLayers(Image_in,List_out):- isBitmap(Image_in),select_pix_x(Image_in,X), select_pix_y(Image_in,Y), select_pix_content(Image_in,Content),bitDepthLayers(X,Y,Content,[],List_out).
imageDepthLayers(Image_in,List_out):- isPixmap(Image_in),select_pix_x(Image_in,X), select_pix_y(Image_in,Y), select_pix_content(Image_in,Content),rgbDepthLayers(X,Y,Content,[],List_out).
imageDepthLayers(Image_in,List_out):- isHexmap(Image_in),select_pix_x(Image_in,X), select_pix_y(Image_in,Y), select_pix_content(Image_in,Content),hexDepthLayers(X,Y,Content,[],List_out).

%DECOMPRESS
% DETERMINA EL TIPO DE TDA:IMAGE QUE SE LE ESTA ENTREGANDO, Y EVALUA CON
% EL PREDICADO ASOCIADO DE DESCOMPRESION APROPIADO.
%
% DOMINIO: TDA:IMAGE X TDA:IMAGE

decompress(Image_in,Compressed_Image_out):- imageIsBitmap(Image_in), decompressBitmap(Image_in,Compressed_Image_out).
decompress(Image_in,Compressed_Image_out):- imageIsPixmap(Image_in), decompressPixmap(Image_in,Compressed_Image_out).
decompress(Image_in,Compressed_Image_out):- imageIsHexmap(Image_in), decompressHexmap(Image_in,Compressed_Image_out).
