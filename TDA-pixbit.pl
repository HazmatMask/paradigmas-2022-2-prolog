%TDA-PIXBIT
%ENTERO X ENTERO X BINARIO X ENTERO

pixbit(X,Y,B,D,[X,Y,B,D]).

isPixbit([X,Y,0,D|[]]):-integer(X),integer(Y),X > -1,Y > -1,integer(D).
isPixbit([X,Y,1,D|[]]):-integer(X),integer(Y),X > -1,Y > -1,integer(D).

select_pixbit_value([X,Y,B|PB],B):- isPixbit([X,Y,B|PB]).
select_pixbit_depth([X,Y,B,D|PB],D):- isPixbit([X,Y,B,D|PB]).

mod_pixbit_x([X|PB],New_X,[New_X|PB]):- isPixbit([X|PB]),integer(New_X),New_X > -1.
mod_pixbit_y([X,Y|PB],New_Y,[X,New_Y|PB]):- isPixbit([X,Y|PB]),integer(New_Y),New_Y > -1.

mod_pixbit_value([X,Y,0|PB],[X,Y,1|PB]):- isPixbit([X,Y,0|PB]).
mod_pixbit_value([X,Y,1|PB],[X,Y,0|PB]):- isPixbit([X,Y,1|PB]).

mod_pixbit_depth([X,Y,B,D|PB],New_D,[X,Y,B,New_D|PB]):- isPixbit([X,Y,B,D|PB]),integer(New_D).
