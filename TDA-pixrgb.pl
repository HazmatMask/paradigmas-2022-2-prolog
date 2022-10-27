%TDA-PIXRGB
%ENTERO X ENTERO X ENTERO X ENTERO X ENTERO

pixrgb(X,Y,R,G,B,D,[X,Y,R,G,B,D]).

isPixrgb([X,Y,R,G,B,D|[]]):-integer(X),integer(Y),X > -1,Y > -1, integer(R), R > -1, R < 256, integer(G), G > -1, G < 256, integer(B), B > -1, B < 256, integer(D).

select_pixrgb_x([X|PB],X):- isPixrgb([X|PB]).
select_pixrgb_y([X,Y|PB],Y):- isPixrgb([X,Y|PB]).

select_pixrgb_red([X,Y,R|PB],R):- isPixrgb([X,Y,R|PB]).
select_pixrgb_green([X,Y,R,G|PB],G):- isPixrgb([X,Y,R,G|PB]).
select_pixrgb_blue([X,Y,R,G,B|PB],B):- isPixrgb([X,Y,R,G,B|PB]).

select_pixrgb_depth([X,Y,R,G,B,D|PB],D):- isPixrgb([X,Y,R,G,B,D|PB]).


mod_pixrgb_x([X|PB],New_X,[New_X|PB]):- isPixrgb([X|PB]),integer(New_X),New_X > -1.
mod_pixrgb_y([X,Y|PB],New_Y,[X,New_Y|PB]):- isPixrgb([X,Y|PB]),integer(New_Y),New_Y > -1.

mod_pixrgb_red([X,Y,R|PB],New_R,[X,Y,New_R|PB]):- isPixrgb([X,Y,R|PB]), integer(New_R), New_R > -1, New_R < 256.
mod_pixrgb_green([X,Y,R,G|PB],New_G,[X,Y,R,New_G|PB]):- isPixrgb([X,Y,R,G|PB]), integer(New_G), New_G > -1, New_G < 256.
mod_pixrgb_blue([X,Y,R,G,B|PB],New_B,[X,Y,R,G,New_B|PB]):- isPixrgb([X,Y,R,G,B|PB]), integer(New_B), New_B > -1, New_B < 256.

mod_pixrgb_depth([X,Y,R,G,B,D|PB],New_D,[X,Y,R,G,B,New_D|PB]):- isPixrgb([X,Y,R,G,B,D|PB]), integer(New_D).
