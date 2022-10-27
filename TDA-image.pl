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

imageIsBitmap([X,Y,Content]):-integer(X),integer(Y),X > -1, Y > -1, isBitList(Content).
imageIsPixmap([X,Y,Content]):-integer(X),integer(Y),X > -1, Y > -1, isRgbList(Content).
imageIsHexmap([X,Y,Content]):-integer(X),integer(Y),X > -1, Y > -1, isHexList(Content).

%IMAGE IS COMPRESSED: PENDIENTE
%

select_pix_x([X|_],X).
select_pix_y([_,Y|_],Y).
select_pix_content([_,_,Content],Content).

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

recCountBinFromList([],_,Sum_out,Sum_out).
recCountBinFromList([H|T],Color_in,Sum_in,Sum_out):- select_pixbit_value(H,Color_out), Color_in == Color_out, Sum_aux is Sum_in+1, recCountBinFromList(T,Color_in,Sum_aux,Sum_out).
recCountBinFromList([_|T],Color_in,Sum_in,Sum_out):- recCountBinFromList(T,Color_in,Sum_in,Sum_out).

countBinFromList(List,Color,[Color,Sum_out]):-recCountBinFromList(List,Color,0,Sum_out).

recCountAllBinFromList(_,It,It,List_out,List_out).
recCountAllBinFromList(List_in,Current_It,Finish_It,List_aux,List_out):- countBinFromList(List_in,Current_It,Sum_out), List_aux2 = [Sum_out|List_aux], It_up is Current_It+1, recCountAllBinFromList(List_in,It_up,Finish_It,List_aux2,List_out).

countAllBinFromList(List_in,List_out):- recCountAllBinFromList(List_in,0,2,[],List_out).

%RED COUNTER

recCountRedFromList([],_,Sum_out,Sum_out).
recCountRedFromList([H|T],Color_in,Sum_in,Sum_out):- select_pixrgb_red(H,Color_out), Color_in == Color_out, Sum_aux is Sum_in+1, recCountRedFromList(T,Color_in,Sum_aux,Sum_out).
recCountRedFromList([_|T],Color_in,Sum_in,Sum_out):- recCountRedFromList(T,Color_in,Sum_in,Sum_out).

countRedFromList(List,Color,[Color,Sum_out]):-recCountRedFromList(List,Color,0,Sum_out).

recCountAllRedFromList(_,It,It,List_out,List_out).
recCountAllRedFromList(List_in,Current_It,Finish_It,List_aux,List_out):- countRedFromList(List_in,Current_It,Sum_out), List_aux2 = [Sum_out|List_aux], It_up is Current_It+1, recCountAllRedFromList(List_in,It_up,Finish_It,List_aux2,List_out).

countAllRedFromList(List_in,List_out):- recCountAllRedFromList(List_in,0,256,[],List_out).

%GREEN COUNTER

recCountGreenFromList([],_,Sum_out,Sum_out).
recCountGreenFromList([H|T],Color_in,Sum_in,Sum_out):- select_pixrgb_green(H,Color_out), Color_in == Color_out, Sum_aux is Sum_in+1, recCountGreenFromList(T,Color_in,Sum_aux,Sum_out).
recCountGreenFromList([_|T],Color_in,Sum_in,Sum_out):- recCountGreenFromList(T,Color_in,Sum_in,Sum_out).

countGreenFromList(List,Color,[Color,Sum_out]):-recCountGreenFromList(List,Color,0,Sum_out).

recCountAllGreenFromList(_,It,It,List_out,List_out).
recCountAllGreenFromList(List_in,Current_It,Finish_It,List_aux,List_out):- countGreenFromList(List_in,Current_It,Sum_out), List_aux2 = [Sum_out|List_aux], It_up is Current_It+1, recCountAllGreenFromList(List_in,It_up,Finish_It,List_aux2,List_out).

countAllGreenFromList(List_in,List_out):- recCountAllGreenFromList(List_in,0,256,[],List_out).

%BLUE COUNTER

recCountBlueFromList([],_,Sum_out,Sum_out).
recCountBlueFromList([H|T],Color_in,Sum_in,Sum_out):- select_pixrgb_blue(H,Color_out), Color_in == Color_out, Sum_aux is Sum_in+1, recCountBlueFromList(T,Color_in,Sum_aux,Sum_out).
recCountBlueFromList([_|T],Color_in,Sum_in,Sum_out):- recCountBlueFromList(T,Color_in,Sum_in,Sum_out).

countBlueFromList(List,Color,[Color,Sum_out]):-recCountBlueFromList(List,Color,0,Sum_out).

recCountAllBlueFromList(_,It,It,List_out,List_out).
recCountAllBlueFromList(List_in,Current_It,Finish_It,List_aux,List_out):- countBlueFromList(List_in,Current_It,Sum_out), List_aux2 = [Sum_out|List_aux], It_up is Current_It+1, recCountAllBlueFromList(List_in,It_up,Finish_It,List_aux2,List_out).

countAllBlueFromList(List_in,List_out):- recCountAllBlueFromList(List_in,0,256,[],List_out).

%IMAGETOHISTOGRAM
%
imageToHistogram(Image,Histogram):- imageIsBitmap(Image), select_pix_content(Image,Bit_list), countAllBinFromList(Bit_list,Histogram).

imageToHistogram(Image,[Red,Green,Blue]):- imageIsPixmap(Image), select_pix_content(Image,Pix_list), countAllRedFromList(Pix_list,Red), countAllGreenFromList(Pix_list,Green), countAllBlueFromList(Pix_list,Blue).

imageToHistogram(Image_in,[Red,Green,Blue]):- imageIsHexmap(Image_in), imageHextoRGB(Image_in,Image_out), select_pix_content(Image_out,Pix_list), countAllRedFromList(Pix_list,Red), countAllGreenFromList(Pix_list,Green), countAllBlueFromList(Pix_list,Blue).


%ROTATE90

imageRotate90Rec(_,[],[]).
imageRotate90Rec(Y,[H|T],[H2|T2]):- select_pix_x(H,H_X), select_pix_y(H,H_Y), mod_pix_y(H,H_X,H_AUX), X_AUX is Y-1, Y_AUX is -H_Y+X_AUX, mod_pix_x(H_AUX,Y_AUX,H2), imageRotate90Rec(Y,T,T2).

imageRotate90([X,Y,Content],[Y,X,Content_2]):- imageRotate90Rec(Y,Content,Content_2).

%COMPRESS: PENDIENTE

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





