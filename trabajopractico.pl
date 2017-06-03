propiedad(tinsmithCircle17741, 700, 3).
propiedad(avMoreno708, 2000, 7).
propiedad(avSiempreViva742, 1000, 4).
propiedad(calleFalsa123, 200, 3).

tiene(tinsmithCircle17741, jardin).
tiene(avMoreno708, jardin).
tiene(avSiempreViva742, jardin).
tiene(avMoreno708, piscina(30)).

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
      tiene(UnaPropiedad, jardin),
      busca(UnaPersona, jardin).
posiblePropiedad(UnaPropiedad, UnaPersona) :-
      busca(UnaPersona, ambientes(UnosAmbientes)),
      cumpleAmbientes(UnaPropiedad, UnosAmbientes).
posiblePropiedad(UnaPropiedad, UnaPersona) :-
      busca(UnaPersona, piscina(UnosMetros)),
      cumplePiscina(UnaPropiedad, UnosMetros).

noCumpleNinguna(UnaPersona, UnRequerimiento) :-
      busca(UnaPersona, UnRequerimiento),
      not(posiblePropiedad(_ , UnaPersona)).

% cumpleAlgo(UnaPropiedad) :-
%      tiene(UnaPropiedad, jardin),
%      busca(_ , jardin).
% cumpleAlgo(UnaPropiedad) :-
  %    busca(_ , ambientes(UnosAmbientes)),
  %    cumpleAmbientes(UnaPropiedad, UnosAmbientes).
% cumpleAlgo(UnaPropiedad) :-
  %    busca(_ , piscina(UnosMetros)),
  %    cumplePiscina(UnaPropiedad, UnosMetros).



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
% 6. Qué se está deseando de la propiedad de Av. Moreno 708.
% 7. Determinar qué característica fue solicitada y ninguna propiedad pudo cumplir.
% ?- noCumpleNinguna(X, Y).
% X = ana,
% Y = piscina(100) ;
