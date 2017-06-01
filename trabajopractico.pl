propiedad(tinsmithCircle17741, 700, 3).
propiedad(avMoreno7082, 2000, 7).
propiedad(avSiempreViva742, 1000, 4).
propiedad(calleFalsa123, 200, 3).

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

cumplePiscina(Propiedad, MetrosRequeridos) :-
      tiene(Propiedad, piscina(Metros)),
      Metros >= MetrosRequeridos.
cumpleAmbientes(Propiedad, AmbientesRequeridos) :-
      propiedad(Propiedad, _, Ambientes),
      Ambientes >= AmbientesRequeridos.

posiblePropiedad(UnaPropiedad, UnaPersona) :-
      cliente(UnaPersona),
      tiene(UnaPropiedad, jardin),
      busca(UnaPersona, jardin).

posiblePropiedad(UnaPropiedad, UnaPersona) :-
      cliente(UnaPersona),
      busca(UnaPersona, ambientes(UnosAmbientes)),
      cumpleAmbientes(UnaPropiedad, UnosAmbientes).

posiblePropiedad(UnaPropiedad, UnaPersona) :-
      cliente(UnaPersona),
      busca(UnaPersona, piscina(UnosMetros)),
      cumplePiscina(UnaPropiedad, UnosMetros).

% Consultas
% 1 Si existe alguna propiedad con una piscina de 30 metros. Y si es que existe, cuál es.
% ?- tienePiscina(X, 30).
% X = avMoreno708
% 2 Si existe alguna propiedad que tenga la misma cantidad de ambientes que otra. Y si existen, cuáles son.
% ?- tieneMismosAmbientes(X,Y).
% X = tinsmithCircle17741,
% Y = calleFalsa123 .
% 3 Mostrar qué quiere Pedro.
% ?- busca(pedro, Requerimiento).
% Requerimiento = ambientes(2) ;
% Requerimiento = piscina(15).
% 4. Si existe alguna propiedad que tenga 2 ambientes.
% ?- propiedad(Propiedad, Precio, 2).
% false.
% 5. Cuál propiedad tiene algo de lo que quiere Pedro.
% ?- posiblePropiedad(UnaPropiedad, pedro).
% UnaPropiedad = tinsmithCircle17741 ;
% UnaPropiedad = avMoreno7082 ;
% UnaPropiedad = avSiempreViva742 ;
% UnaPropiedad = calleFalsa123 ;
% UnaPropiedad = avMoreno7082.
