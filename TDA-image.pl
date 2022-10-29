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

select_pix_x([X|_],X).
select_pix_y([_,Y|_],Y).
select_pix_content([_,_,Content|_],Content).
select_pix_end([_,_,_|End],End).

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

recMostFrequentBINHisto([[BIN,A]|[]],[_,A2],[BIN,A]):- A > A2.
recMostFrequentBINHisto([[_,A]|[]],[BIN,A2],[BIN,A2]):- A =< A2.
recMostFrequentBINHisto([[BIN,A]|T],[_,A2],Color_out):- A > A2, recMostFrequentRGBHisto(T,[BIN,A],Color_out).
recMostFrequentBINHisto([[_,A]|T],[BIN,A2],Color_out):- A =< A2, recMostFrequentRGBHisto(T,[BIN,A2],Color_out).

mostFrequentBINHisto(List_in,Color_out):- recMostFrequentBINHisto(List_in,[_,0],Color_out).

recCompressBINList_newList([],_,List_out,List_out).
recCompressBINList_newList([H|T],[BIN,_],List_aux,List_out):- select_pixbit_value(H,BIN), select_pixbit_x(H,X), select_pixbit_y(H,Y), select_pixbit_depth(H,D), recCompressRGBList_newList(T,[BIN,_],[[X,Y,D]|List_aux],List_out).
recCompressBINList_newList([_|T],Color_in,List_aux,List_out):- recCompressBINList_newList(T,Color_in,List_aux,List_out).

compressBINList_newList(List_in,Color_in,List_out):- recCompressBINList_newList(List_in,Color_in,[],List_out).

recCompressBINList_clear([],[],_).
recCompressBINList_clear([H|T],T2,[BIN,_]):-  select_pixrgb_red(H,BIN), recCompressRGBList_clear(T,T2,[BIN,_]).
recCompressBINList_clear([H|T],[H|T2],Color_in):- recCompressBINList_clear(T,T2,Color_in).

compressBINList_clear(List_in,Color_in,List_out):- recCompressBINList_clear(List_in,List_out,Color_in).

compressBitmap(Image_in,Compressed_Image_out):- imageToHistogram(Image_in,Histo_out), mostFrequentBINHisto(Histo_out,Color_out), select_pix_content(Image_in,Content_out), compressBINList_newList(Content_out,Color_out,New_content), compressBINList_clear(Content_out,Color_out,Clear_content), createCompressedImage(Image_in,[Color_out|New_content],Clear_content,Compressed_Image_out).

%COMPRESS RGB

recMostFrequentRGBHisto([[R,G,B,A]|[]],[_,_,_,A2],[R,G,B,A]):- A > A2.
recMostFrequentRGBHisto([[_,_,_,A]|[]],[R,G,B,A2],[R,G,B,A2]):- A =< A2.
recMostFrequentRGBHisto([[R,G,B,A]|T],[_,_,_,A2],Color_out):- A > A2, recMostFrequentRGBHisto(T,[R,G,B,A],Color_out).
recMostFrequentRGBHisto([[_,_,_,A]|T],[R,G,B,A2],Color_out):- A =< A2, recMostFrequentRGBHisto(T,[R,G,B,A2],Color_out).

mostFrequentRGBHisto(List_in,Color_out):- recMostFrequentRGBHisto(List_in,[_,_,_,0],Color_out).

recCompressRGBList_newList([],_,List_out,List_out).
recCompressRGBList_newList([H|T],[R,G,B,_],List_aux,List_out):- select_pixrgb_red(H,R), select_pixrgb_green(H,G), select_pixrgb_blue(H,B), select_pixrgb_x(H,X), select_pixrgb_y(H,Y), select_pixrgb_depth(H,D), recCompressRGBList_newList(T,[R,G,B,_],[[X,Y,D]|List_aux],List_out).
recCompressRGBList_newList([_|T],Color_in,List_aux,List_out):- recCompressRGBList_newList(T,Color_in,List_aux,List_out).

compressRGBList_newList(List_in,Color_in,List_out):- recCompressRGBList_newList(List_in,Color_in,[],List_out).

recCompressRGBList_clear([],[],_).
recCompressRGBList_clear([H|T],T2,[R,G,B,_]):-  select_pixrgb_red(H,R), select_pixrgb_green(H,G), select_pixrgb_blue(H,B), recCompressRGBList_clear(T,T2,[R,G,B,_]).
recCompressRGBList_clear([H|T],[H|T2],Color_in):- recCompressRGBList_clear(T,T2,Color_in).

compressRGBList_clear(List_in,Color_in,List_out):- recCompressRGBList_clear(List_in,List_out,Color_in).

compressPixmap(Image_in,Compressed_Image_out):- imageToHistogram(Image_in,Histo_out), mostFrequentRGBHisto(Histo_out,Color_out), select_pix_content(Image_in,Content_out), compressRGBList_newList(Content_out,Color_out,New_content), compressRGBList_clear(Content_out,Color_out,Clear_content), createCompressedImage(Image_in,[Color_out|New_content],Clear_content,Compressed_Image_out).

compress(Image_in,Compressed_Image_out):- imageIsPixmap(Image_in), compressPixmap(Image_in,Compressed_Image_out).

%CHANGEPIXEL

imageChangePixelRec([],New_pix,[New_pix|[]]).
imageChangePixelRec([H|T],New_pix,[New_pix|T]):- select_pix_x(H,X), select_pix_x(New_pix,X), select_pix_y(H,Y), select_pix_y(New_pix,Y).
imageChangePixelRec([H|T],New_pix,[H|T2]):- imageChangePixelRec(T,New_pix,T2).

validate_entries_ICP(Image_in,New_pix,Image_out):- imageIsBitmap(Image_in), isPixbit(New_pix), imageChangePixelRec(Image_in,New_pix,Image_out).
validate_entries_ICP(Image_in,New_pix,Image_out):- imageIsPixmap(Image_in), isPixrgb(New_pix), imageChangePixelRec(Image_in,New_pix,Image_out).
validate_entries_ICP(Image_in,New_pix,Image_out):- imageIsHexmap(Image_in), isPixhex(New_pix), imageChangePixelRec(Image_in,New_pix,Image_out).


imageChangePixel(Image_in,New_pix,Image_out):- select_pix_x(Image_in,X_in), select_pix_y(Image_in,Y_in), select_pix_x(New_pix,XPix_in), select_pix_y(New_pix,YPix_in), X_in > XPix_in, Y_in > YPix_in, validate_entries_ICP(Image_in,New_pix,Image_out).

%INVERTCOLORRGB

imageInvertColorRGBRec([],[]).
imageInvertColorRGBRec([H|T],[H2|T2]):-select_pixrgb_red(H,R), select_pixrgb_green(H,G), select_pixrgb_blue(H,B), R_2 is 255-R, G_2 is 255-G, B_2 is 255-B, mod_pixrgb_red(H,R_2,H_R), mod_pixrgb_green(H_R,G_2,H_RG), mod_pixrgb_blue(H_RG,B_2,H2), imageInvertColorRGBRec(T,T2).

imageInvertColorRGB([X,Y,Content_in],[X,Y,Content_out]):- imageInvertColorRGBRec(Content_in,Content_out).





