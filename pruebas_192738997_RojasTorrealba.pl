:-use_module('TDA-pixbit').
:-use_module('TDA-pixrgb').
:-use_module('TDA-pixhex').
:-use_module('TDA-hexString').
:-use_module('TDA-image').

image(2,2,[[0,0,1,1],[0,1,0,1],[1,0,1,1],[1,1,0,1]],Image_out).
image(1,2,[[0,0,0,1],[0,1,1,1]],Image_out).
image(2,1,[[0,0,1,1],[1,0,0,1]],Image_out).


imageIsBitmap([2,1,[[0, 0, 1, 1],[1, 0, 0, 1]]]). %-> VERDADERO
imageIsBitmap([2,1,[[0,0,10,20,30,1],[1,0,30,20,10,1]]]). %-> FALSO
imageIsBitmap([2,1,[[0,0,"AABBCC",1],[1,0,"CCBBAA",1]]]). %-> FALSO

imageIsPixmap([2,1,[[0, 0, 1, 1],[1, 0, 0, 1]]]). %-> FALSO
imageIsPixmap([2,1,[[0,0,10,20,30,1],[1,0,30,20,10,1]]]). %-> VERDADERO
imageIsPixmap([2,1,[[0,0,"AABBCC",1],[1,0,"CCBBAA",1]]]). %-> FALSO

imageIsHexmap([2,1,[[0, 0, 1, 1],[1, 0, 0, 1]]]). %-> FALSO
imageIsHexmap([2,1,[[0,0,10,20,30,1],[1,0,30,20,10,1]]]). %-> FALSO
imageIsHexmap([2,1,[[0,0,"AABBCC",1],[1,0,"CCBBAA",1]]]). %-> VERDADERO

imageIsCompressed([2,1,[[0,0,"AABBCC",1],[1,0,"CCBBAA",1]]]). %-> FALSO
imageIsCompressed([2,1,[[0,0,0,1]],[[1],[1,0,1]]]). %-> VERDADERO
imageIsCompressed([2,1,[],[[1],[1,0,1]],[[0],[0,0,1]]]) %-> VERDADERO

imageFlipH([2,1,[[0, 0, 1, 1],[1, 0, 0, 1]]],Image_out).
imageFlipH([2,1,[[0,0,10,20,30,1],[1,0,30,20,10,1]]],Image_out).
imageFlipH([2,1,[[0,0,"AABBCC",1],[1,0,"CCBBAA",1]]],Image_out).

imageFlipV([1,2,[[0, 0, 1, 1],[0, 1, 0, 1]]],Image_out).
imageFlipV([1,2,[[0,0,10,20,30,1],[0,1,30,20,10,1]]],Image_out).
imageFlipV([1,2,[[0,0,"AABBCC",1],[0,1,"CCBBAA",1]]],Image_out).

imageCrop([2,3,[[0,0,0,1],[0,1,1,1],[0,2,0,1],[1,0,1,1],[1,1,0,1],[1,2,1,1]]],0,0,1,0,Image_out).
imageCrop([2,3,[[0,0,0,1],[0,1,1,1],[0,2,0,1],[1,0,1,1],[1,1,0,1],[1,2,1,1]]],0,0,0,1,Image_out).
imageCrop([2,3,[[0,0,0,1],[0,1,1,1],[0,2,0,1],[1,0,1,1],[1,1,0,1],[1,2,1,1]]],0,0,0,2,Image_out).

A = [2,3,[[0,0,0,1],[0,1,1,1],[0,2,0,1],[1,0,1,1],[1,1,0,1],[1,2,1,1]]]
B = [2,3,[[0,0,10,20,30,1],[0,1,0,10,20,1],[0,2,10,20,30,1],[1,0,0,10,20,1],[1,1,10,20,30,1],[1,2,0,10,20,1]]]
C = [2,3,[[0,0,"AABBCC",1],[0,1,"DDEEFF",1],[0,2,"AABBCC",1],[1,0,"DDEEFF",1],[1,1,"AABBCC",1],[1,2,"DDEEFF",1]]]

imageRGBtoHex([2,3,[[0,0,10,20,30,1],[0,1,0,10,20,1],[0,2,10,20,30,1],[1,0,0,10,20,1],[1,1,10,20,30,1],[1,2,0,10,20,1]]],Image_out).
imageRGBtoHex([2,3,[[0,0,"AABBCC",1],[0,1,"DDEEFF",1],[0,2,"AABBCC",1],[1,0,"DDEEFF",1],[1,1,"AABBCC",1],[1,2,"DDEEFF",1]]],Image_out). % -> FALSO
imageRGBtoHex([2,3,[[0,0,0,1],[0,1,1,1],[0,2,0,1],[1,0,1,1],[1,1,0,1],[1,2,1,1]]],Image_out). %-> FALSO

imageToHistogram([2,3,[[0,0,10,20,30,1],[0,1,10,20,30,1],[0,2,10,20,30,1],[1,0,0,10,20,1],[1,1,10,20,30,1],[1,2,0,10,20,1]]],List_out).
imageToHistogram([2,3,[[0,0,"AABBCC",1],[0,1,"AABBCC",1],[0,2,"AABBCC",1],[1,0,"DDEEFF",1],[1,1,"AABBCC",1],[1,2,"DDEEFF",1]]],List_out).
imageToHistogram([2,3,[[0,0,1,1],[0,1,1,1],[0,2,0,1],[1,0,1,1],[1,1,0,1],[1,2,1,1]]],List_out).

imageRotate90([2,3,[[0,0,0,1],[0,1,1,1],[0,2,0,1],[1,0,1,1],[1,1,0,1],[1,2,1,1]]],Image_out).
imageRotate90([2,3,[[0,0,10,20,30,1],[0,1,0,10,20,1],[0,2,10,20,30,1],[1,0,0,10,20,1],[1,1,10,20,30,1],[1,2,0,10,20,1]]],Image_out).
imageRotate90([2,3,[[0,0,"AABBCC",1],[0,1,"AABBCC",1],[0,2,"AABBCC",1],[1,0,"DDEEFF",1],[1,1,"AABBCC",1],[1,2,"DDEEFF",1]]],Image_out).

compress([2,3,[[0,0,10,20,30,1],[0,1,0,10,20,1],[0,2,10,20,30,1],[1,0,0,10,20,1],[1,1,10,20,30,1],[1,2,0,10,20,1]]],Image_out).
compress([2,3,[[0,0,"AABBCC",1],[0,1,"DDEEFF",1],[0,2,"AABBCC",1],[1,0,"DDEEFF",1],[1,1,"AABBCC",1],[1,2,"DDEEFF",1]]],Image_out).
compress([2,3,[[0,0,0,1],[0,1,1,1],[0,2,0,1],[1,0,1,1],[1,1,0,1],[1,2,1,1]]],Image_out).

imageChangePixel([2,3,[[0,0,10,20,30,1],[0,1,0,10,20,1],[0,2,10,20,30,1],[1,0,0,10,20,1],[1,1,10,20,30,1],[1,2,0,10,20,1]]],[0,0,0,10,20,1],Image_out).
imageChangePixel([2,3,[[0,0,"AABBCC",1],[0,1,"DDEEFF",1],[0,2,"AABBCC",1],[1,0,"DDEEFF",1],[1,1,"AABBCC",1],[1,2,"DDEEFF",1]]],[0,0,"DDEEFF",1],Image_out).
imageChangePixel([2,3,[[0,0,0,1],[0,1,1,1],[0,2,0,1],[1,0,1,1],[1,1,0,1],[1,2,1,1]]],[0,0,1,1],Image_out).

imageInvertColorRGB([2,3,[[0,0,10,20,30,1],[0,1,0,10,20,1],[0,2,10,20,30,1],[1,0,0,10,20,1],[1,1,10,20,30,1],[1,2,0,10,20,1]]],Image_out).
imageInvertColorRGB([2,3,[[0,0,"AABBCC",1],[0,1,"DDEEFF",1],[0,2,"AABBCC",1],[1,0,"DDEEFF",1],[1,1,"AABBCC",1],[1,2,"DDEEFF",1]]],Image_out). %-> FALSO
imageInvertColorRGB([2,3,[[0,0,0,1],[0,1,1,1],[0,2,0,1],[1,0,1,1],[1,1,0,1],[1,2,1,1]]],Image_out). %->FALSO

imageToString([2,3,[[0,0,10,20,30,1],[0,1,0,10,20,1],[0,2,10,20,30,1],[1,0,0,10,20,1],[1,1,10,20,30,1],[1,2,0,10,20,1]]],Image_out).
imageToString([2,3,[[0,0,"AABBCC",1],[0,1,"DDEEFF",1],[0,2,"AABBCC",1],[1,0,"DDEEFF",1],[1,1,"AABBCC",1],[1,2,"DDEEFF",1]]],Image_out).
imageToString([2,3,[[0,0,0,1],[0,1,1,1],[0,2,0,1],[1,0,1,1],[1,1,0,1],[1,2,1,1]]],Image_out).

imageDepthLayers([2,3,[[0,0,10,20,30,1],[0,1,0,10,20,1],[0,2,10,20,30,1],[1,0,0,10,20,1],[1,1,10,20,30,1],[1,2,0,10,20,1]]],List_out).
imageDepthLayers([2,3,[[0,0,"AABBCC",1],[0,1,"DDEEFF",1],[0,2,"AABBCC",1],[1,0,"DDEEFF",1],[1,1,"AABBCC",1],[1,2,"DDEEFF",1]]],List_out).
imageDepthLayers([2,3,[[0,0,0,1],[0,1,1,1],[0,2,0,1],[1,0,1,1],[1,1,0,1],[1,2,1,1]]],List_out).

decompress([2,3,[[0,0,0,1],[0,2,0,1],[1,1,0,1]],[[1],[1,2,1],[1,0,1],[0,1,1]]],Compressed_Image_out).
decompress([2,3,[[0,0,AABBCC,1],[0,2,AABBCC,1],[1,1,AABBCC,1]],[[DDEEFF],[1,2,1],[1,0,1],[0,1,1]]],Compressed_Image_out).
decompress([2,3,[[0,0,10,20,30,1],[0,2,10,20,30,1],[1,1,10,20,30,1]],[[0,10,20],[1,2,1],[1,0,1],[0,1,1]]],Compressed_Image_out).
