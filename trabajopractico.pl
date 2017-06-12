propiedad(tinsmithCircle17741, 700).
propiedad(avMoreno708, 2000).
propiedad(avSiempreViva742, 1000).
propiedad(calleFalsa123, 200).

tiene(tinsmithCircle17741, jardin).
tiene(tinsmithCircle17741,ambientes(3)).
tiene(tinsmithCircle17741,instalaciones([ac,extractor,calefaccionGas])).
tiene(avMoreno708, jardin).
tiene(avMoreno708, piscina(30)).
tiene(avMoreno708,ambientes(7)).
tiene(avMoreno708,instalaciones([ac,extractor,calefaccionLoza,vidriosDobles])).
tiene(avSiempreViva742, jardin).
tiene(avSiempreViva742,ambientes(4)).
tiene(avSiempreViva742,instalaciones([calefaccionGas])).
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
busca(ana, instalaciones([ac,vidriosDobles])).
busca(maria, ambientes(2)).
busca(maria, piscina(15)).
busca(pedro, UnRequerimiento) :-
      busca(maria, UnRequerimiento).
busca(pedro, instalaciones([calefaccionLoza,vidriosDobles])).
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

cumpleTodo(Persona,Propiedad) :-
    persona(Persona),
    propiedad(Propiedad,_),
    posiblePropiedad(Propiedad,Persona).

mejorOpcion(Persona,Propiedad) :-
    cumpleTodo(Persona,Propiedad),
    propiedad(Propiedad,Precio),
    forall((cumpleTodo(Persona,OtraPropiedad),OtraPropiedad \= Propiedad),(propiedad(OtraPropiedad,OtroPrecio),Precio < OtroPrecio)).

estaSatisfecho(Persona) :-
    persona(Persona),
    findall(Propiedad,cumpleTodo(Persona,Propiedad),Propiedades),
    length(Propiedades,Cantidad),
    Cantidad >= 1.

efectividad(Efectividad) :-
    findall(Persona,persona(Persona),Personas),
    findall(PersonaSatisfecha,estaSatisfecho(PersonaSatisfecha),PersonasSatisfechas),
    list_to_set(Personas,PersonasSinRepetidos),
    list_to_set(PersonasSatisfechas,PersonasSatisfechasSinRepetidos),
    length(PersonasSinRepetidos,PersonasTotales),
    length(PersonasSatisfechasSinRepetidos,PersonasSatisfechasTotales),
    Efectividad is PersonasSatisfechasTotales / PersonasTotales * 100.

tieneInstalaciones(_,[]).
tieneInstalaciones(Propiedad, [UnaInstalacion|RestoInstalaciones]) :-
    propiedad(Propiedad,_),
    tiene(Propiedad,instalaciones(Instalaciones)),
    member(UnaInstalacion,Instalaciones),
    tieneInstalaciones(Propiedad,RestoInstalaciones).

esUnaPropiedadTop(Propiedad) :-
    propiedad(Propiedad,_),
    not(esPropiedadChica(Propiedad)),
    tieneInstalaciones(Propiedad,[ac]).

esPropiedadChica(Propiedad) :-
    tiene(Propiedad,ambientes(1)).
esPropiedadChica(Propiedad) :-
    not(tiene(Propiedad,ambientes(_))).





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

% 8. Qué persona se relaciona con cuál propiedad mediante ese predicado.
% ?- cumpleTodo(UnaPersona, UnaPropiedad).
% UnaPersona = carlos,
% UnaPropiedad = tinsmithCircle17741 ;
% UnaPersona = carlos,
% UnaPropiedad = tinsmithCircle17741 ;
% UnaPersona = carlos,
% UnaPropiedad = avMoreno708 ;
% UnaPersona = carlos,
% UnaPropiedad = avMoreno708 ;
% UnaPersona = carlos,
% UnaPropiedad = avSiempreViva742 ;
% UnaPersona = carlos,
% UnaPropiedad = avSiempreViva742 ;
% UnaPersona = carlos,
% UnaPropiedad = calleFalsa123 ;
% UnaPersona = maria,
% UnaPropiedad = tinsmithCircle17741 ;
% UnaPersona = maria,
% UnaPropiedad = avMoreno708 ;
% UnaPersona = maria,
% UnaPropiedad = avMoreno708 ;
% UnaPersona = maria,
% UnaPropiedad = avSiempreViva742 ;
% UnaPersona = maria,
% UnaPropiedad = calleFalsa123 ;
% UnaPersona = pedro,
% UnaPropiedad = tinsmithCircle17741 ;
% UnaPersona = pedro,
% UnaPropiedad = avMoreno708 ;
% UnaPropiedad = avMoreno708 ;
% UnaPersona = pedro,
% UnaPersona = pedro,
% UnaPropiedad = avSiempreViva742 ;
% UnaPersona = pedro,
% UnaPropiedad = calleFalsa123 ;
% UnaPersona = chamaleon,
% UnaPropiedad = tinsmithCircle17741 ;
% UnaPersona = chamaleon,
% UnaPropiedad = tinsmithCircle17741 ;
% UnaPersona = chamaleon,
% UnaPropiedad = tinsmithCircle17741 ;
% UnaPersona = chamaleon,
% UnaPropiedad = tinsmithCircle17741 ;
% UnaPersona = chamaleon,
% UnaPropiedad = avMoreno708 ;
% UnaPersona = chamaleon,
% UnaPropiedad = avMoreno708 ;
% UnaPersona = chamaleon,
% UnaPropiedad = avMoreno708 ;
% UnaPersona = chamaleon,
% UnaPropiedad = avMoreno708 ;
% UnaPersona = chamaleon,
% UnaPersona = chamaleon,
% UnaPropiedad = avMoreno708 ;
% UnaPropiedad = avMoreno708 ;
% UnaPersona = chamaleon,
% UnaPropiedad = avSiempreViva742 ;
% UnaPersona = chamaleon,
% UnaPropiedad = avSiempreViva742 ;
% UnaPersona = chamaleon,
% UnaPropiedad = avSiempreViva742 ;
% UnaPersona = chamaleon,
% UnaPropiedad = avSiempreViva742 ;
% UnaPersona = chamaleon,
% UnaPropiedad = calleFalsa123 ;
% UnaPersona = chamaleon,
% UnaPropiedad = calleFalsa123 ;
% UnaPersona = chamaleon,
% UnaPropiedad = calleFalsa123.

% 9. Qué persona se relaciona con cuál propiedad (asegurarse de que ambas alternativas encuentren las mismas soluciones, ya sean en el mismo orden o no).
% ?- mejorOpcion(Alguien,UnaPropiedad).
% Alguien = carlos,
% UnaPropiedad = calleFalsa123 ;
% Alguien = maria,
% UnaPropiedad = calleFalsa123 ;
% Alguien = pedro,
% UnaPropiedad = calleFalsa123 ;
% Alguien = chamaleon,
% UnaPropiedad = calleFalsa123 ;
% Alguien = chamaleon,
% UnaPropiedad = calleFalsa123 ;
% Alguien = chamaleon,
% UnaPropiedad = calleFalsa123.

% 10. Qué efectividad tiene nuestro sistema.
% ?- efectividad(Efectividad).
% Efectividad = 80.0.

% Al agregar lo de las instalaciones agregamos el concepto de listas, y nos facilita la modificacion de codigo
% porque mediante recurisvidad podemos evaluar que tenga todas las instalaciones deseadas, en caso de que
% se agreguen nuevas instalaciones, o que alguna persona desee una instalacion nueva, solo hace falta agregarla a la lista.

% 11. Determinar cuáles son las propiedades top.
% ?- esUnaPropiedadTop(Cual).
% Cual = tinsmithCircle17741 ;
% Cual = avMoreno708.
