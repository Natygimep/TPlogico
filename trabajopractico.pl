propiedad(tinsmithCircle17741, 700).
propiedad(avMoreno708, 2000).
propiedad(avSiempreViva742, 1000).
propiedad(calleFalsa123, 200).

tiene(tinsmithCircle17741, jardin).
tiene(avMoreno708, jardin).
tiene(avSiempreViva742, jardin).
tiene(avMoreno708, piscina(30)).
tiene(tinsmithCircle17741,ambientes(3)).
tiene(avMoreno708,ambientes(7)).
tiene(avSiempreViva742,ambientes(4)).
tiene(calleFalsa123,ambientes(3)).

tieneMismosAmbientes(UnaPropiedad, OtraPropiedad) :-
       tiene(UnaPropiedad, ambientes(Ambientes)),
       tiene(OtraPropiedad, ambientes(Ambientes)),
       UnaPropiedad \= OtraPropiedad.

persona(carlos).
persona(aca).
persona(maria).
persona(pedro).
persona(chamaleon).

busca(carlos, jardin).
busca(carlos, ambientes(3)).
busca(ana, piscina(100)).
busca(maria, ambientes(2)).
busca(maria, piscina(15)).
busca(pedro, UnRequerimiento) :-
      busca(maria, UnRequerimiento).
busca(chamaleon, UnRequerimiento) :-
      persona(UnCliente),
      UnCliente \= chamaleon,
      busca(UnCliente, UnRequerimiento).

cumplePiscina(Propiedad, MetrosRequeridos) :-
      tiene(Propiedad, piscina(Metros)),
      Metros >= MetrosRequeridos.
cumpleAmbientes(Propiedad, AmbientesRequeridos) :-
      tiene(Propiedad, ambientes(Ambientes)),
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

noCumpleNinguna(UnRequerimiento) :-
      busca(UnaPersona, UnRequerimiento),
      not(posiblePropiedad(_ , UnaPersona)).

cumpleUnRequerimiento(UnaPropiedad,jardin) :-
    tiene(UnaPropiedad, jardin).
cumpleUnRequerimiento(UnaPropiedad,ambientes(Ambientes)) :-
    cumpleAmbientes(UnaPropiedad,Ambientes).
cumpleUnRequerimiento(UnaPropiedad,piscina(Metros)) :-
    cumplePiscina(UnaPropiedad,Metros).

queSeDeseaDeUnaPropiedad(UnaPropiedad,UnRequerimiento) :-
    propiedad(UnaPropiedad,_),
    busca(_,UnRequerimiento),
    cumpleUnRequerimiento(UnaPropiedad,UnRequerimiento).

% Consultas
% 1 Si existe alguna propiedad con una piscina de 30 metros. Y si es que existe, cuál es.
% ?- cumplePiscina(UnaPropiedad, 30).
% UnaPropiedad = avMoreno708

% 2 Si existe alguna propiedad que tenga la misma cantidad de ambientes que otra. Y si existen, cuáles son.
% ?- tieneMismosAmbientes(UnaPropiedad, OtraPropiedad).
% UnaPropiedad = tinsmithCircle17741,
% OtraPropiedad = calleFalsa123 .

% 3 Mostrar qué quiere Pedro.
% ?- busca(pedro, Requerimiento).
% Requerimiento = ambientes(2) ;
% Requerimiento = piscina(15).

% 4. Si existe alguna propiedad que tenga 2 ambientes.
% ?- ambientes(Propiedad, 2).
% false.

% 5. Cuál propiedad tiene algo de lo que quiere Pedro.
% ?- posiblePropiedad(UnaPropiedad, pedro).
% UnaPropiedad = tinsmithCircle17741 ;
% UnaPropiedad = avMoreno7082 ;
% UnaPropiedad = avSiempreViva742 ;
% UnaPropiedad = calleFalsa123 ;
% UnaPropiedad = avMoreno7082.

% 6. Qué se está deseando de la propiedad de Av. Moreno 708.
% /// no estoy seguro pero yo interpreto en este punto que una propiedad deseada
% es una propiedad que tiene algun requerimiento que alguna persona desea.
% ?- queSeDeseaDeUnaPropiedad(avMoreno708,UnRequerimiento).
% UnRequerimiento = jardin ;
% UnRequerimiento = ambientes(3) ;
% UnRequerimiento = ambientes(2) ;
% UnRequerimiento = piscina(15) ;
% UnRequerimiento = ambientes(2) ;
% UnRequerimiento = piscina(15) ;
% UnRequerimiento = jardin ;
% UnRequerimiento = ambientes(3) ;
% UnRequerimiento = ambientes(2) ;
% UnRequerimiento = piscina(15) ;
% UnRequerimiento = ambientes(2) ;
% UnRequerimiento = piscina(15).

% 7. Determinar qué característica fue solicitada y ninguna propiedad pudo cumplir.
% ?- noCumpleNinguna(UnRequerimiento).
% UnRequerimiento = piscina(100) ;


% ENTREGA 2

% 8.
