propiedad(avMoreno7082, 2000, 7).
propiedad(avSiempreViva742, 1000, 4).
propiedad(calleFalsa123, 200, 3).

tieneJardin(tinsmithCircle17741).
tieneJardin(avMoreno7082).
tieneJardin(avSiempreViva742).
tienePiscina(avMoreno7082, 30).

cliente(carlos).
cliente(ana).
cliente(maria).
cliente(pedro).
cliente(chamaleon).

tiene(tinsmithCircle17741, jardin).
tiene(avMoreno7082, jardin).
tiene(avSiempreViva742, jardin).
tiene(avMoreno7082, piscina(30)).

tieneMismosAmbientes(UnaPropiedad, OtraPropiedad) :-
       propiedad(UnaPropiedad, _, Ambientes),
       propiedad(OtraPropiedad, _, Ambientes),
       UnaPropiedad \= OtraPropiedad.

busca(carlos, jardin).
busca(carlos, ambientes(3)).
busca(ana, piscina(100)).
busca(maria, ambientes(2)).
busca(maria, piscina(15)).
busca(pedro, UnRequerimiento) :-
       busca(maria, UnRequerimiento).
busca(chamaleon, UnRequerimiento) :-
       busca(UnCliente, UnRequerimiento),
       UnCliente \= chamaleon.



% Consultas
% 1 Si existe alguna propiedad con una piscina de 30 metros. Y si es que existe, cuál es.
% ?- tienePiscina(X, 30).
% X = avMoreno708
% 2 Si existe alguna propiedad que tenga la misma cantidad de ambientes que otra. Y si existen, cuáles son.
% ?- tieneMismosAmbientes(X,Y).
% X = tinsmithCircle17741,
% Y = calleFalsa123 .
