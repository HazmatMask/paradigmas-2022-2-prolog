%
%CONSTRUCTOR
%

image(X,Y,Content,[X,Y,Content]).

isBitList([]).
isBitList([H|T]):-isPixbit(H),isBitList(T).

isRgbList([]).
isRgbList([H|T]):-isPixrgb(H),isRgbList(T).

isHexList([]).
isHexList([H|T]):-isPixhex(H),isHexList(T).

imageIsBitmap([X,Y,Content|_]):-integer(X),integer(Y),X > -1, Y > -1, isBitList(Content).
imageIsPixmap([X,Y,Content|_]):-integer(X),integer(Y),X > -1, Y > -1, isRgbList(Content).
imageIsHexmap([X,Y,Content|_]):-integer(X),integer(Y),X > -1, Y > -1, isHexList(Content).
imageIsCompressed([_,_,_|[_|_]]).

create_pix(X,Y,Content,[X,Y|Content]).

select_pix_x([X|_],X).
select_pix_y([_,Y|_],Y).
select_pix_content([_,_,Content|_],Content).
select_pix_end([_,_,_|End],End).
select_pix_depth([_,_,_,D],D).

mod_pix_x([_|T],New_X,[New_X|T]).
mod_pix_y([X,_|T],New_Y,[X,New_Y|T]).

%IMAGEFLIP-H

flipHRec(_,[],[]).
flipHRec(X,[H|T],[H2|T2]):- select_pix_x(H,H_X), select_pix_x(H2,H_X2), X_aux is X-1, H_X2 is X_aux-H_X, mod_pix_x(H,H_X2,H2), flipHRec(X,T,T2).

imageFlipH([X,Y,Content],[X,Y,Content_2]):- flipHRec(X,Content,Content_2).

%IMAGEFLIP-V

flipVRec(_,[],[]).
flipVRec(Y,[H|T],[H2|T2]):- select_pix_y(H,H_Y), select_pix_y(H2,H_Y2), Y_aux is Y-1, H_Y2 is Y_aux-H_Y, mod_pix_y(H,H_Y2,H2), flipVRec(Y,T,T2).

imageFlipV([X,Y,Content],[X,Y,Content_2]):- flipVRec(Y,Content,Content_2).

%IMAGECROP

cropRec(_,_,_,_,[],[]).
cropRec(X_1,Y_1,X_2,Y_2,[H|T],[H|T_2]):- select_pix_x(H,H_X), select_pix_y(H,H_Y), X_1-1 < H_X, X_2+1 > H_X, Y_1-1 < H_Y, Y_2+1 > H_Y, cropRec(X_1,Y_1,X_2,Y_2,T,T_2).
cropRec(X_1,Y_1,X_2,Y_2,[_|T],T_2):- cropRec(X_1,Y_1,X_2,Y_2,T,T_2).

imageCrop([X,Y,Content_in],X_1,Y_1,X_2,Y_2,[X,Y,Content_out]):- cropRec(X_1,Y_1,X_2,Y_2,Content_in,Content_out).

%IMGRGB->IMGHEX

recPixListRGBtoHex([],[]).
recPixListRGBtoHex([[X,Y,R,G,B,D]|T_RGB],[[X,Y,HEX,D]|T_HEX]):- rgbStringToHex(R,G,B,HEX), recPixListRGBtoHex(T_RGB,T_HEX).

imageRGBtoHex([X,Y,Content_in],[X,Y,Content_out]):- recPixListRGBtoHex(Content_in,Content_out).

%IMGHEX->RGB

recPixListHexToRGB([],[]).
recPixListHexToRGB([[X,Y,HEX_IN,D]|T_HEX],[[X,Y,R,G,B,D]|T_RGB]):- hexStringTo(HEX_IN,[R,G,B]), recPixListHexToRGB(T_HEX,T_RGB).

imageHextoRGB([X,Y,Content_in],[X,Y,Content_out]):- recPixListHexToRGB(Content_in,Content_out).

%IMGTOHISTOGRAM

%BIN COUNTER

is_BIN_in_List([[BIN,_]|[]],BIN).
is_BIN_in_List([[BIN,_]|[_|_]],BIN).
is_BIN_in_List([_|T],BIN):- is_BIN_in_List(T,BIN).

add_BIN_value(List_in,BIN,[[BIN,1]|List_in]).

up_BIN_value(BIN,[[BIN,A]|T],[[BIN,A_up]|T]):-A_up is A+1.
up_BIN_value(BIN,[H|T1],[H|T2]):- up_BIN_value(BIN,T1,T2).

run_BIN_List([],List_out,List_out).
run_BIN_List([PixBIT|T],List_aux,List_out):- select_pixbit_value(PixBIT,BIN), is_BIN_in_List(List_aux,BIN), up_BIN_value(BIN,List_aux,List_aux2),run_BIN_List(T,List_aux2,List_out).
run_BIN_List([PixBIT|T],List_aux,List_out):- select_pixbit_value(PixBIT,BIN), add_BIN_value(List_aux,BIN,List_aux2), run_BIN_List(T,List_aux2,List_out).

%RGB COUNTER

is_RGB_in_List([[R,G,B,_]|[]],R,G,B).
is_RGB_in_List([[R,G,B,_]|[_|_]],R,G,B).
is_RGB_in_List([_|T],R,G,B):- is_RGB_in_List(T,R,G,B).

add_RGB_value(List_in,R,G,B,[[R,G,B,1]|List_in]).

up_RGB_value(R,G,B,[[R,G,B,A]|T],[[R,G,B,A_up]|T]):- A_up is A+1.
up_RGB_value(R,G,B,[H|T1],[H|T2]):- up_RGB_value(R,G,B,T1,T2).

run_RGB_List([],List_out,List_out).
run_RGB_List([PixRGB|T],List_aux,List_out):- select_pixrgb_red(PixRGB,R), select_pixrgb_green(PixRGB,G), select_pixrgb_blue(PixRGB,B), is_RGB_in_List(List_aux,R,G,B), up_RGB_value(R,G,B,List_aux,List_aux2),run_RGB_List(T,List_aux2,List_out).
run_RGB_List([PixRGB|T],List_aux,List_out):- select_pixrgb_red(PixRGB,R), select_pixrgb_green(PixRGB,G), select_pixrgb_blue(PixRGB,B), add_RGB_value(List_aux,R,G,B,List_aux2), run_RGB_List(T,List_aux2,List_out).

%IMAGETOHISTOGRAM
%
imageToHistogram(Image,List_out):- imageIsBitmap(Image), select_pix_content(Image,Bit_list), run_BIN_List(Bit_list,[],List_out).

imageToHistogram(Image,List_out):- imageIsPixmap(Image), select_pix_content(Image,Pix_list), run_RGB_List(Pix_list,[],List_out).

imageToHistogram(Image_in,List_out):- imageIsHexmap(Image_in), imageHextoRGB(Image_in,Image_out), select_pix_content(Image_out,Pix_list), run_RGB_List(Pix_list,[],List_out).

%ROTATE90

imageRotate90Rec(_,[],[]).
imageRotate90Rec(Y,[H|T],[H2|T2]):- select_pix_x(H,H_X), select_pix_y(H,H_Y), mod_pix_y(H,H_X,H_AUX), X_AUX is Y-1, Y_AUX is -H_Y+X_AUX, mod_pix_x(H_AUX,Y_AUX,H2), imageRotate90Rec(Y,T,T2).

imageRotate90([X,Y,Content],[Y,X,Content_2]):- imageRotate90Rec(Y,Content,Content_2).

%COMPRESS: PENDIENTE


createCompressedImage(Image_in,Compressed_List,Clear_List,[X_out,Y_out,Clear_List|[Compressed_List|Old_compress]]):- select_pix_x(Image_in,X_out), select_pix_y(Image_in,Y_out), select_pix_end(Image_in,Old_compress).


%COMPRESS BIN

recMostFrequentBINHisto([[BIN,A]|[]],[_,A2],[BIN]):- A > A2.
recMostFrequentBINHisto([[_,A]|[]],[BIN,A2],[BIN]):- A =< A2.
recMostFrequentBINHisto([[BIN,A]|T],[_,A2],Color_out):- A > A2, recMostFrequentBINHisto(T,[BIN,A],Color_out).
recMostFrequentBINHisto([[_,A]|T],[BIN,A2],Color_out):- A =< A2, recMostFrequentBINHisto(T,[BIN,A2],Color_out).

mostFrequentBINHisto(List_in,Color_out):- recMostFrequentBINHisto(List_in,[_,0],Color_out).

recCompressBINList_newList([],_,List_out,List_out).
recCompressBINList_newList([H|T],[BIN],List_aux,List_out):- select_pixbit_value(H,BIN), select_pixbit_x(H,X), select_pixbit_y(H,Y), select_pixbit_depth(H,D), recCompressBINList_newList(T,[BIN],[[X,Y,D]|List_aux],List_out).
recCompressBINList_newList([_|T],Color_in,List_aux,List_out):- recCompressBINList_newList(T,Color_in,List_aux,List_out).

compressBINList_newList(List_in,Color_in,List_out):- recCompressBINList_newList(List_in,Color_in,[],List_out).

recCompressBINList_clear([],[],_).
recCompressBINList_clear([H|T],T2,[BIN]):-  select_pixbit_value(H,BIN), recCompressBINList_clear(T,T2,[BIN]).
recCompressBINList_clear([H|T],[H|T2],Color_in):- recCompressBINList_clear(T,T2,Color_in).

compressBINList_clear(List_in,Color_in,List_out):- recCompressBINList_clear(List_in,List_out,Color_in).

compressBitmap(Image_in,Compressed_Image_out):- imageToHistogram(Image_in,Histo_out), mostFrequentBINHisto(Histo_out,Color_out), select_pix_content(Image_in,Content_out), compressBINList_newList(Content_out,Color_out,New_content), compressBINList_clear(Content_out,Color_out,Clear_content), createCompressedImage(Image_in,[Color_out|New_content],Clear_content,Compressed_Image_out).

%COMPRESS RGB

recMostFrequentRGBHisto([[R,G,B,A]|[]],[_,_,_,A2],[R,G,B]):- A > A2.
recMostFrequentRGBHisto([[_,_,_,A]|[]],[R,G,B,A2],[R,G,B]):- A =< A2.
recMostFrequentRGBHisto([[R,G,B,A]|T],[_,_,_,A2],Color_out):- A > A2, recMostFrequentRGBHisto(T,[R,G,B,A],Color_out).
recMostFrequentRGBHisto([[_,_,_,A]|T],[R,G,B,A2],Color_out):- A =< A2, recMostFrequentRGBHisto(T,[R,G,B,A2],Color_out).

mostFrequentRGBHisto(List_in,Color_out):- recMostFrequentRGBHisto(List_in,[_,_,_,0],Color_out).

recCompressRGBList_newList([],_,List_out,List_out).
recCompressRGBList_newList([H|T],[R,G,B],List_aux,List_out):- select_pixrgb_red(H,R), select_pixrgb_green(H,G), select_pixrgb_blue(H,B), select_pixrgb_x(H,X), select_pixrgb_y(H,Y), select_pixrgb_depth(H,D), recCompressRGBList_newList(T,[R,G,B],[[X,Y,D]|List_aux],List_out).
recCompressRGBList_newList([_|T],Color_in,List_aux,List_out):- recCompressRGBList_newList(T,Color_in,List_aux,List_out).

compressRGBList_newList(List_in,Color_in,List_out):- recCompressRGBList_newList(List_in,Color_in,[],List_out).

recCompressRGBList_clear([],[],_).
recCompressRGBList_clear([H|T],T2,[R,G,B]):-  select_pixrgb_red(H,R), select_pixrgb_green(H,G), select_pixrgb_blue(H,B), recCompressRGBList_clear(T,T2,[R,G,B]).
recCompressRGBList_clear([H|T],[H|T2],Color_in):- recCompressRGBList_clear(T,T2,Color_in).

compressRGBList_clear(List_in,Color_in,List_out):- recCompressRGBList_clear(List_in,List_out,Color_in).

compressPixmap(Image_in,Compressed_Image_out):- imageToHistogram(Image_in,Histo_out), mostFrequentRGBHisto(Histo_out,Color_out), select_pix_content(Image_in,Content_out), compressRGBList_newList(Content_out,Color_out,New_content), compressRGBList_clear(Content_out,Color_out,Clear_content), createCompressedImage(Image_in,[Color_out|New_content],Clear_content,Compressed_Image_out).

%COMPRESS HEX

recMostFrequentHEXHisto([[HEX,A]|[]],[_,A2],[HEX]):- A > A2.
recMostFrequentHEXHisto([[_,A]|[]],[HEX,A2],[HEX]):- A =< A2.
recMostFrequentHEXHisto([[HEX,A]|T],[_,A2],Color_out):- A > A2, recMostFrequentRGBHisto(T,[HEX,A],Color_out).
recMostFrequentHEXHisto([[_,A]|T],[HEX,A2],Color_out):- A =< A2, recMostFrequentRGBHisto(T,[HEX,A2],Color_out).

mostFrequentHEXHisto(List_in,Color_out):- recMostFrequentHEXHisto(List_in,[_,0],Color_out).

recCompressHEXList_newList([],_,List_out,List_out).
recCompressHEXList_newList([H|T],[HEX],List_aux,List_out):- select_pixhex_value(H,HEX),select_pixhex_x(H,X),select_pixhex_y(H,Y), select_pixhex_depth(H,D), recCompressRGBList_newList(T,[HEX],[[X,Y,D]|List_aux],List_out).
recCompressHEXList_newList([_|T],Color_in,List_aux,List_out):- recCompressHEXList_newList(T,Color_in,List_aux,List_out).

compressHEXList_newList(List_in,Color_in,List_out):- recCompressHEXList_newList(List_in,Color_in,[],List_out).

recCompressHEXList_clear([],[],_).
recCompressHEXList_clear([H|T],T2,[HEX]):-  select_pixhex_value(H,HEX),recCompressRGBList_clear(T,T2,[HEX]).
recCompressHEXList_clear([H|T],[H|T2],Color_in):- recCompressHEXList_clear(T,T2,Color_in).

compressHEXList_clear(List_in,Color_in,List_out):- recCompressHEXList_clear(List_in,List_out,Color_in).


compressHexmap(Image_in,Compressed_Image_out):- imageToHistogram(Image_in,Histo_out),mostFrequentHEXHisto(Histo_out,Color_out), select_pix_content(Image_in,Content_out), compressHEXList_newList(Content_out,Color_out,New_content), compressHEXList_clear(Content_out,Color_out,Clear_content), createCompressedImage(Image_in,[Color_out|New_content],Clear_content,Compressed_Image_out).

compress(Image_in,Compressed_Image_out):- imageIsBitmap(Image_in), compressBitmap(Image_in,Compressed_Image_out).
compress(Image_in,Compressed_Image_out):- imageIsPixmap(Image_in), compressPixmap(Image_in,Compressed_Image_out).
compress(Image_in,Compressed_Image_out):- imageIsHexmap(Image_in), compressHexmap(Image_in,Compressed_Image_out).

%CHANGEPIXEL

imageChangePixelRec([],New_pix,[New_pix|[]]).
imageChangePixelRec([H|T],New_pix,[New_pix|T]):- select_pix_x(H,X), select_pix_x(New_pix,X), select_pix_y(H,Y), select_pix_y(New_pix,Y).
imageChangePixelRec([H|T],New_pix,[H|T2]):- imageChangePixelRec(T,New_pix,T2).

validate_entries_ICP(Image_in,New_pix,Image_out):- imageIsBitmap(Image_in), isPixbit(New_pix), select_pix_content(Image_in,Content_in),imageChangePixelRec(Content_in,New_pix,Content_out),select_pix_x(Image_in,X),select_pix_y(Image_in,Y),image(X,Y,Content_out,Image_out).
validate_entries_ICP(Image_in,New_pix,Image_out):- imageIsPixmap(Image_in), isPixrgb(New_pix), select_pix_content(Image_in,Content_in),imageChangePixelRec(Content_in,New_pix,Content_out),select_pix_x(Image_in,X),select_pix_y(Image_in,Y),image(X,Y,Content_out,Image_out).
validate_entries_ICP(Image_in,New_pix,Image_out):- imageIsHexmap(Image_in), isPixhex(New_pix), select_pix_content(Image_in,Content_in),imageChangePixelRec(Content_in,New_pix,Content_out),select_pix_x(Image_in,X),select_pix_y(Image_in,Y),image(X,Y,Content_out,Image_out).


imageChangePixel(Image_in,New_pix,Image_out):- select_pix_x(Image_in,X_in), select_pix_y(Image_in,Y_in), select_pix_x(New_pix,XPix_in), select_pix_y(New_pix,YPix_in), X_in > XPix_in, Y_in > YPix_in, validate_entries_ICP(Image_in,New_pix,Image_out).

%INVERTCOLORRGB

imageInvertColorRGBRec([],[]).
imageInvertColorRGBRec([H|T],[H2|T2]):-select_pixrgb_red(H,R), select_pixrgb_green(H,G), select_pixrgb_blue(H,B), R_2 is 255-R, G_2 is 255-G, B_2 is 255-B, mod_pixrgb_red(H,R_2,H_R), mod_pixrgb_green(H_R,G_2,H_RG), mod_pixrgb_blue(H_RG,B_2,H2), imageInvertColorRGBRec(T,T2).

imageInvertColorRGB([X,Y,Content_in],[X,Y,Content_out]):- imageInvertColorRGBRec(Content_in,Content_out).


%IMAGE->STRING

%SORT

getPix_out(CurrentX,CurrentY,[H|_],H):- select_pix_x(H,CurrentX), select_pix_y(H,CurrentY).
getPix_out(CurrentX,CurrentY,[_|T],Pix_out):- getPix_out(CurrentX,CurrentY,T,Pix_out).

getPix_clear(_,_,[],[]).
getPix_clear(CurrentX,CurrentY,[H|T],T):- select_pix_x(H,CurrentX),select_pix_y(H,CurrentY).
getPix_clear(CurrentX,CurrentY,[H|T1],[H|T2]):- getPix_clear(CurrentX,CurrentY,T1,T2).

sort_Content(XSize,YSize,XSize,YSize,_,[]).
sort_Content(CurrentX,YSize,XSize,YSize,List_in,List_out):- sort_Content(CurrentX,0,XSize,YSize,List_in,List_out).
sort_Content(CurrentX,YSize,XSize,YSize,List_in,List_out):- NextX is CurrentX+1, sort_Content(NextX,YSize,XSize,YSize,List_in,List_out).
sort_Content(CurrentX,CurrentY,XSize,YSize,List_in,[Pix_out|List_out]):- getPix_out(CurrentX,CurrentY,List_in,Pix_out), getPix_clear(CurrentX,CurrentY,List_in,Clear_List), Y_up is CurrentY+1, sort_Content(CurrentX,Y_up,XSize,YSize,Clear_List,List_out).

sort_Image(Image_in,Image_out):- select_pix_x(Image_in,X), select_pix_y(Image_in,Y), select_pix_content(Image_in,Content), sort_Content(0,0,X,Y,Content,New_content), image(X,Y,New_content,Image_out).

%BITMAP->STRING

bitListToString(_,[],String_out,String_out).
bitListToString(Y,[H|T],String_aux,String_out):- select_pixbit_y(H,H_Y), Y is H_Y+1, select_pixbit_value(H,H_BIN), string_concat(String_aux,H_BIN,String_aux2), string_concat(String_aux2,"\n",String_aux3), bitListToString(Y,T,String_aux3,String_out).
bitListToString(Y,[H|T],String_aux,String_out):- select_pixbit_value(H,H_BIN), string_concat(String_aux,H_BIN,String_aux2), bitListToString(Y,T,String_aux2,String_out).


bitmapToString(Image_In,String_out):- select_pix_y(Image_In,Y),select_pix_content(Image_In,Content_out),bitListToString(Y,Content_out,"",String_out).

%PIXMAP->STRING

pixListToString(_,[],String_out,String_out).
pixListToString(Y,[H|T],String_aux,String_out):- select_pixrgb_y(H,H_Y), Y is H_Y+1, select_pixrgb_red(H,H_RED),select_pixrgb_green(H,H_GREEN), select_pixrgb_blue(H,H_BLUE),string_concat(String_aux,"R:",String_aux2), string_concat(String_aux2,H_RED,String_aux3), string_concat(String_aux3,",G:",String_aux4),string_concat(String_aux4,H_GREEN,String_aux5),string_concat(String_aux5,"B:",String_aux6),string_concat(String_aux6,H_BLUE,String_aux7),string_concat(String_aux7,"\n",String_aux8),pixListToString(Y,T,String_aux8,String_out).
pixListToString(Y,[H|T],String_aux,String_out):- select_pixrgb_red(H,H_RED),select_pixrgb_green(H,H_GREEN), select_pixrgb_blue(H,H_BLUE),string_concat(String_aux,"R:",String_aux2), string_concat(String_aux2,H_RED,String_aux3), string_concat(String_aux3," G:",String_aux4),string_concat(String_aux4,H_GREEN,String_aux5),string_concat(String_aux5," B:",String_aux6),string_concat(String_aux6,H_BLUE,String_aux7),string_concat(String_aux7,"\t",String_aux8),pixListToString(Y,T,String_aux8,String_out).

pixmapToString(Image_In,String_out):- select_pix_y(Image_In,Y),select_pix_content(Image_In,Content_out),pixListToString(Y,Content_out,"",String_out).

%HEXMAP->STRING

hexListToString(_,[],String_out,String_out).
hexListToString(Y,[H|T],String_aux,String_out):- select_pixhex_y(H,H_Y), Y is H_Y+1, select_pixhex_hex(H,H_HEX),string_concat(String_aux,H_HEX,String_aux2),string_concat(String_aux2,"\n",String_aux8),hexListToString(Y,T,String_aux8,String_out).
hexListToString(Y,[H|T],String_aux,String_out):- select_pixhex_hex(H,H_HEX),string_concat(String_aux,H_HEX,String_aux2),string_concat(String_aux2," ",String_aux8),hexListToString(Y,T,String_aux8,String_out).

hexmapToString(Image_In,String_out):- select_pix_y(Image_In,Y),select_pix_content(Image_In,Content_out),hexListToString(Y,Content_out,"",String_out).


imageToString_back(Image_In,String_out):-  select_pix_x(Image_In,X), select_pix_y(Image_In,Y), string_concat("Alto(X):",X,String_1), string_concat(";Ancho(Y):",Y,String_2), string_concat(String_1,String_2,String_3), string_concat(String_3,"\n\n",String_out).

imageToString(Image_in,String_out):- imageIsBitmap(Image_in),sort_Image(Image_in,Image_out),imageToString_back(Image_in,String_1),bitmapToString(Image_out,String_2),string_concat(String_1,String_2,String_out).
imageToString(Image_in,String_out):- imageIsPixmap(Image_in),sort_Image(Image_in,Image_out),imageToString_back(Image_in,String_1),pixmapToString(Image_out,String_2),string_concat(String_1,String_2,String_out).
imageToString(Image_in,String_out):- imageIsHexmap(Image_in),sort_Image(Image_in,Image_out),imageToString_back(Image_in,String_1),hexmapToString(Image_out,String_2),string_concat(String_1,String_2,String_out).

%DEPTHLAYERS: PENDIENTE

createBaseImage(XSize,0,XSize,YSize,_,_,Image_out,[XSize,YSize,Image_out]).
createBaseImage(CurrentX,YSize,XSize,YSize,BasePix,Depth,Image_aux,Image_out):- NextX is CurrentX+1, createBaseImage(NextX,0,XSize,YSize,BasePix,Depth,Image_aux,Image_out).
createBaseImage(CurrentX,CurrentY,XSize,YSize,BasePix,Depth,Image_aux,Image_out):- create_pix(CurrentX,CurrentY,[BasePix|[Depth]],Pix_out), NextY is CurrentY+1, createBaseImage(CurrentX,NextY,XSize,YSize,BasePix,Depth,[Pix_out|Image_aux],Image_out).

createBaseRGBImage(XSize,0,XSize,YSize,_,_,_,_,Image_out,[XSize,YSize,Image_out]).
createBaseRGBImage(CurrentX,YSize,XSize,YSize,R,G,B,Depth,Image_aux,Image_out):- NextX is CurrentX+1, createBaseRGBImage(NextX,0,XSize,YSize,R,G,B,Depth,Image_aux,Image_out).
createBaseRGBImage(CurrentX,CurrentY,XSize,YSize,R,G,B,Depth,Image_aux,Image_out):- pixrgb(CurrentX,CurrentY,R,G,B,Depth,Pix_out), NextY is CurrentY+1, createBaseRGBImage(CurrentX,NextY,XSize,YSize,R,G,B,Depth,[Pix_out|Image_aux],Image_out).


%GETNDEPTH(HEX/BIT)

getNDepth_list([],_,List_out,List_out).
getNDepth_list([H|T],NDepth,List_aux,List_out):- select_pix_depth(H,NDepth),getNDepth_list(T,NDepth,[H|List_aux],List_out).
getNDepth_list([_|T],NDepth,List_aux,List_out):- getNDepth_list(T,NDepth,List_aux,List_out).

getNDepth_clear([],_,List_out,List_out).
getNDepth_clear([H|T],NDepth,List_aux,List_out):- select_pix_depth(H,NDepth),getNDepth_clear(T,NDepth,List_aux,List_out).
getNDepth_clear([H|T],NDepth,List_aux,List_out):- getNDepth_clear(T,NDepth,[H|List_aux],List_out).

%GETNDEPTH_RGB

getNDepthRGB_list([],_,List_out,List_out).
getNDepthRGB_list([H|T],NDepth,List_aux,List_out):- select_pixrgb_depth(H,NDepth),getNDepthRGB_list(T,NDepth,[H|List_aux],List_out).
getNDepthRGB_list([_|T],NDepth,List_aux,List_out):- getNDepthRGB_list(T,NDepth,List_aux,List_out).

getNDepthRGB_clear([],_,List_out,List_out).
getNDepthRGB_clear([H|T],NDepth,List_aux,List_out):- select_pixrgb_depth(H,NDepth),getNDepthRGB_clear(T,NDepth,List_aux,List_out).
getNDepthRGB_clear([H|T],NDepth,List_aux,List_out):- getNDepthRGB_clear(T,NDepth,[H|List_aux],List_out).

%DEPTHLAYERS_REC

insertPixList([],Image_out,Image_out).
insertPixList([H|T],Image_in,Image_out):- imageChangePixel(Image_in,H,Image_aux),insertPixList(T,Image_aux,Image_out).

bitDepthLayers(_,_,[],List_out,List_out).
bitDepthLayers(X,Y,[H|T],List_in,List_out):- select_pixbit_depth(H,D),createBaseImage(0,0,X,Y,1,D,[],Image_aux),getNDepth_list([H|T],D,[],List_aux),insertPixList(List_aux,Image_aux,Image_out),getNDepth_clear([H|T],D,[],List_aux2),bitDepthLayers(X,Y,List_aux2,[Image_out|List_in],List_out).

rgbDepthLayers(_,_,[],List_out,List_out).
rgbDepthLayers(X,Y,[H|T],List_in,List_out):- select_pixrgb_depth(H,D),createBaseRGBImage(0,0,X,Y,255,255,255,D,[],Image_aux),getNDepthRGB_list([H|T],D,[],List_aux),insertPixList(List_aux,Image_aux,Image_out),getNDepthRGB_clear([H|T],D,[],List_aux2),rgbDepthLayers(X,Y,List_aux2,[Image_out|List_in],List_out).

hexDepthLayers(_,_,[],List_out,List_out).
hexDepthLayers(X,Y,[H|T],List_in,List_out):- select_pixhex_depth(H,D),createBaseImage(0,0,X,Y,"FFFFFF",D,[],Image_aux),getNDepth_list([H|T],D,[],List_aux),insertPixList(List_aux,Image_aux,Image_out),getNDepth_clear([H|T],D,[],List_aux2),hexDepthLayers(X,Y,List_aux2,[Image_out|List_in],List_out).

imageDepthLayers(Image_in,List_out):- isBitmap(Image_in),select_pix_x(Image_in,X), select_pix_y(Image_in,Y), select_pix_content(Image_in,Content),bitDepthLayers(X,Y,Content,[],List_out).
imageDepthLayers(Image_in,List_out):- isPixmap(Image_in),select_pix_x(Image_in,X), select_pix_y(Image_in,Y), select_pix_content(Image_in,Content),rgbDepthLayers(X,Y,Content,[],List_out).
imageDepthLayers(Image_in,List_out):- isHexmap(Image_in),select_pix_x(Image_in,X), select_pix_y(Image_in,Y), select_pix_content(Image_in,Content),hexDepthLayers(X,Y,Content,[],List_out).

%DECOMPRESS

%DECOMPRESSBITMAP

unpack_CompressedBit(_,[],List_out,List_out).
unpack_CompressedBit(-1,[[A]|T],List_aux,List_out):- integer(A), unpack_CompressedBit(A,T,List_aux,List_out).
unpack_CompressedBit(A,[[X,Y,D]|T],List_aux,List_out):- pixbit(X,Y,A,D,Pixbit), unpack_CompressedBit(A,T,[Pixbit|List_aux],List_out).

unpack_CompressedBitmap(Image_in,Image_out):- imageIsCompressed(Image_in),select_pix_end(Image_in,[H|_]), unpack_CompressedBit(-1,H,[],Image_out).

concat_PixList([],List_out,List_out).
concat_PixList([H|T],List_2,[H|T2]):- concat_PixList(T,List_2,T2).

decompressBitmap(Image_in,[X,Y,List_out|T]):- select_pix_x(Image_in,X),select_pix_y(Image_in,Y),unpack_CompressedBitmap(Image_in,List_aux),select_pix_content(Image_in,Content_out),select_pix_end(Image_in,[_|T]),concat_PixList(Content_out,List_aux,List_out).

%DECOMPRESSPIXMAP

unpack_CompressedPix(_,_,_,[],List_out,List_out).
unpack_CompressedPix(-1,-1,-1,[[A,B,C]|T],List_aux,List_out):- integer(A), integer(B), integer(C), unpack_CompressedPix(A,B,C,T,List_aux,List_out).
unpack_CompressedPix(A,B,C,[[X,Y,D]|T],List_aux,List_out):- pixrgb(X,Y,A,B,C,D,Pixbit), unpack_CompressedPix(A,B,C,T,[Pixbit|List_aux],List_out).

unpack_CompressedPixmap(Image_in,Image_out):- imageIsCompressed(Image_in),select_pix_end(Image_in,[H|_]), unpack_CompressedPix(-1,-1,-1,H,[],Image_out).

decompressPixmap(Image_in,[X,Y,List_out|T]):- select_pix_x(Image_in,X),select_pix_y(Image_in,Y),unpack_CompressedPixmap(Image_in,List_aux),select_pix_content(Image_in,Content_out),select_pix_end(Image_in,[_|T]),concat_PixList(Content_out,List_aux,List_out).

%DECOMPRESSHEXMAP

unpack_CompressedHex(_,[],List_out,List_out).
unpack_CompressedHex(-1,[[A]|T],List_aux,List_out):- string(A), unpack_CompressedHex(A,T,List_aux,List_out).
unpack_CompressedHex(A,[[X,Y,D]|T],List_aux,List_out):- pixhex(X,Y,A,D,Pixbit), unpack_CompressedHex(A,T,[Pixbit|List_aux],List_out).

unpack_CompressedHexmap(Image_in,Image_out):- imageIsCompressed(Image_in),select_pix_end(Image_in,[H|_]), unpack_CompressedHex(-1,H,[],Image_out).

decompressHexmap(Image_in,[X,Y,List_out|T]):- select_pix_x(Image_in,X),select_pix_y(Image_in,Y),unpack_CompressedHexmap(Image_in,List_aux),select_pix_content(Image_in,Content_out),select_pix_end(Image_in,[_|T]),concat_PixList(Content_out,List_aux,List_out).

%DECOMPRESS

decompress(Image_in,Compressed_Image_out):- imageIsBitmap(Image_in), decompressBitmap(Image_in,Compressed_Image_out).
decompress(Image_in,Compressed_Image_out):- imageIsPixmap(Image_in), decompressPixmap(Image_in,Compressed_Image_out).
decompress(Image_in,Compressed_Image_out):- imageIsHexmap(Image_in), decompressHexmap(Image_in,Compressed_Image_out).



