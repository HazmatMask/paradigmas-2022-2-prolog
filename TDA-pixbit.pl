:-module('TDA-pixbit',[ pixbit/5,
                     isPixbit/1,
                     select_pixbit_x/2,
                     select_pixbit_y/2,
                     select_pixbit_value/2,
                     select_pixbit_depth/2,
                     mod_pixbit_x/3,
                     mod_pixbit_y/3,
                     mod_pixbit_value/2,
                     mod_pixbit_depth/3
                   ]).

%TDA-PIXBIT
%ENTERO X ENTERO X ENTERO(1/0) X ENTERO


%PIXBIT
% UNIFICA LOS VALORES ENTEROS ENTREGADOS CON UN TDA:PIXBIT CUYO CONTENIDO
% SON DICHOS ENTEROS.
% DOMINIO: ENTERO X ENTERO X ENTERO (1/0) X ENTERO X TDA:PIXBIT

pixbit(X,Y,B,D,[X,Y,B,D]).

%ISPIXBIT
% EVALUA SI UN ELEMENTO INGRESADO ES UN TDA:PIXBIT.
% DOMINIO: ANY

isPixbit([X,Y,0,D|[]]):-integer(X),integer(Y),X > -1,Y > -1,integer(D).
isPixbit([X,Y,1,D|[]]):-integer(X),integer(Y),X > -1,Y > -1,integer(D).

%SELECT_PIXBIT_X
% UNIFICA EL PRIMER ELEMENTO DE UN TDA:PIXBIT CON UN ELEMENTO X, COMO
% PROTOSALIDA.
% DOMINIO: TDA:PIXBIT X ENTERO

select_pixbit_x([X|PB],X):- isPixbit([X|PB]).

%SELECT_PIXBIT_Y
% UNIFICA EL SEGUNDO ELEMENTO DE UN TDA:PIXBIT CON UN ELEMENTO Y, COMO
% PROTOSALIDA.
% DOMINIO: TDA:PIXBIT X ENTERO

select_pixbit_y([X,Y|PB],Y):- isPixbit([X,Y|PB]).

%SELECT_PIXBIT_VALUE
% UNIFICA EL TERCER ELEMENTO DE UN TDA:PIXBIT CON UN ELEMENTO VALUE,
% COMO PROTOSALIDA.
% DOMINIO: TDA:PIXBIT X ENTERO

select_pixbit_value([X,Y,B|PB],B):- isPixbit([X,Y,B|PB]).

%SELECT_PIXBIT_DEPTH
% UNIFICA EL CUARTO ELEMENTO DE UN TDA:PIXBIT CON UN ELEMENTO VALUE,
% COMO PROTOSALIDA.
% DOMINIO: TDA:PIXBIT X ENTERO

select_pixbit_depth([X,Y,B,D|PB],D):- isPixbit([X,Y,B,D|PB]).

%MOD_PIXBIT_X
% UNIFICA LOS ELEMENTOS DE UN TDA:PIXBIT Y UN ENTERO X, CON UN
% TDA:PIXBIT SIMILAR AL PRIMER TDA:PIXBIT, PERO CON SU PRIMER
% ELEMENTO CORRESPONDIENTE AL ENTERO X.
% DOMINIO: TDA:PIXBIT X ENTERO X TDA:PIXBIT

mod_pixbit_x([X|PB],New_X,[New_X|PB]):- isPixbit([X|PB]),integer(New_X),New_X > -1.

%MOD_PIXBIT_Y
% UNIFICA LOS ELEMENTOS DE UN TDA:PIXBIT Y UN ENTERO Y, CON UN
% TDA:PIXBIT SIMILAR AL PRIMER TDA:PIXBIT, PERO CON SU SEGUNDO
% ELEMENTO CORRESPONDIENTE AL ENTERO Y.
% DOMINIO: TDA:PIXBIT X ENTERO X TDA:PIXBIT

mod_pixbit_y([X,Y|PB],New_Y,[X,New_Y|PB]):- isPixbit([X,Y|PB]),integer(New_Y),New_Y > -1.

%MOD_PIXBIT_VALUE
% UNIFICA LOS ELEMENTOS DE DOS TDA:PIXBIT, DONDE EL CUARTO ELEMENTO
% DEL PRIMERO SERA 1 SI EL DEL SEGUNDO ES 0, Y VICEVERSA.
% DOMINIO: TDA:PIXBIT X TDA:PIXBIT

mod_pixbit_value([X,Y,0|PB],[X,Y,1|PB]):- isPixbit([X,Y,0|PB]).
mod_pixbit_value([X,Y,1|PB],[X,Y,0|PB]):- isPixbit([X,Y,1|PB]).

%MOD_PIXBIT_DEPTH
% UNIFICA LOS ELEMENTOS DE UN TDA:PIXBIT Y UN ENTERO DEPTH, CON UN
% TDA:PIXBIT SIMILAR AL PRIMER TDA:PIXBIT, PERO CON SU CUARTO
% ELEMENTO CORRESPONDIENTE AL ENTERO DEPTH.
% DOMINIO: TDA:PIXBIT X ENTERO X TDA:PIXBIT

mod_pixbit_depth([X,Y,B,D|PB],New_D,[X,Y,B,New_D|PB]):- isPixbit([X,Y,B,D|PB]),integer(New_D).
