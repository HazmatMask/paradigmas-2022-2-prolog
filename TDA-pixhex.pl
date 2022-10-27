%TDA-PIXHEX
%ENTERO X ENTERO X STRING X ENTERO
%

pixhex(X,Y,Hex,D,[X,Y,Hex,D]).

isPixhex([X,Y,Hex,D|[]]):-integer(X),integer(Y),X > -1,Y > -1, isRGBHex(Hex), integer(D).

select_pixhex_x([X|PB],X):- isPixhex([X|PB]).
select_pixhex_y([X,Y|PB],Y):- isPixhex([X,Y|PB]).
select_pixhex_hex([X,Y,H|PB],H):- isPixhex([X,Y,H|PB]).
select_pixhex_depth([X,Y,H,D|PB],D):- isPixhex([X,Y,H,D|PB]).


mod_pixhex_x([X|PB],New_X,[New_X|PB]):- isPixhex([X|PB]),integer(New_X),New_X > -1.
mod_pixhex_y([X,Y|PB],New_Y,[X,New_Y|PB]):- isPixhex([X,Y|PB]),integer(New_Y),New_Y > -1.
mod_pixhex_hex([X,Y,H|PB],New_H,[X,Y,New_H|PB]):- isPixhex([X,Y,H|PB]), isRGBHex(New_H).

mod_pixhex_depth([X,Y,R,G,B,D|PB],New_D,[X,Y,R,G,B,New_D|PB]):- isPixhex([X,Y,R,G,B,D|PB]), integer(New_D).
