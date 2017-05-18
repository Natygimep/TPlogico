propiedad(tinsmithCircle17741, 700, 3).
propiedad(avMoreno7082, 2000, 7).
propiedad(avSiempreViva742, 1000, 4).
propiedad(calleFalsa123, 200, 3).
tieneJardin(tinsmithCircle17741).
tieneJardin(avMoreno7082).
tieneJardin(avSiempreViva742).
tienePiscina(avMoreno7082, 30).
tieneMismosAmbientes(X, Y) :- propiedad(X, _, Ambientes),
                              propiedad(Y, _, Ambientes),
                              X \= Y.
