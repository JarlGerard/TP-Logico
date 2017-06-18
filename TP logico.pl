%pareja(Persona, Persona)
pareja(marsellus, mia).
pareja(pumkin,    honeyBunny).
pareja(bernardo, charo).
pareja(bernardo, bianca).

%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).
trabajaPara(Empleador, bernardo):-
	trabajaPara(marsellus, Empleador),
	Empleador \= jules.
trabajaPara(Empleador, george):-
	saleCon(Empleador,bernardo).

saleCon(Persona, OtraPersona):-
	pareja(Persona, OtraPersona).
saleCon(Persona, OtraPersona):-
	pareja(OtraPersona, Persona).


esFiel(Persona):-
	saleCon(Persona,_),
	findall(SuPareja, saleCon(Persona, SuPareja),SusParejas),
	length(SusParejas, Cantidad),
	Cantidad=1.

acataOrden(Empleador, Empleado):-
	trabajaPara(Empleador, Empleado).
acataOrden(Empleador,Empleado):-
	trabajaPara(OtroEmpleado, Empleado),
	acataOrden(Empleador, OtroEmpleado).

% personaje(Nombre, Ocupacion)
personaje(pumkin,     ladron([estacionesDeServicio, licorerias])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent,    mafioso(maton)).
personaje(jules,      mafioso(maton)).
personaje(marsellus,  mafioso(capo)).
personaje(winston,    mafioso(resuelveProblemas)).
personaje(mia,        actriz([foxForceFive])).
personaje(butch,      boxeador).
personaje(bernardo,   mafioso(cerebro)).
personaje(bianca,     actriz([elPadrino1])).
personaje(elVendedor, vender([humo, iphone])).
personaje(jimmie,     vender([auto])).

% encargo(Solicitante, Encargado, Tarea). 
% las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).
encargo(bernardo, vincent, buscar(jules, fuerteApache)).
encargo(bernardo, winston, buscar(jules, sanMartin)).
encargo(bernardo, winston, buscar(jules, lugano)).

amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

esPeligroso(Personaje):-
	personaje(Personaje, ladron(Lista)),
	member(licorerias, Lista).
esPeligroso(Personaje):-
	personaje(Personaje, mafioso(maton)).
esPeligroso(Personaje):-
	trabajaPara(Jefe, Personaje),
	esPeligroso(Jefe).
	
sanCayetano(Personaje):-
	tieneCerca(Personaje, _),
	forall(tieneCerca(Personaje, AlguienCercano), encargo(Personaje, AlguienCercano, _)).
	
sonAmigos(Persona, OtraPersona):-
	amigo(Persona, OtraPersona).
sonAmigos(Persona,OtraPersona):-
	amigo(OtraPersona,Persona).

trabajanJuntos(Persona, OtraPersona):-
	trabajaPara(Persona, OtraPersona).
trabajanJuntos(Persona, OtraPersona):-
	trabajaPara(OtraPersona, Persona).

tieneCerca(Personaje, AlguienCercano):-
	sonAmigos(Personaje,AlguienCercano).
tieneCerca(Personaje, AlguienCercano):-
	trabajanJuntos(Personaje, AlguienCercano).

nivelRespeto(vincent,15).
nivelRespeto(Personaje,Nivel):-
	personaje(Personaje, actriz(Lista)),
	length(Lista,Largo),
	Nivel is Largo/10.
nivelRespeto(Personaje,Nivel):-
	personaje(Personaje, mafioso(resuelveProblemas)),
	Nivel is 10.
nivelRespeto(Personaje,Nivel):-
	personaje(Personaje,mafioso(capo)),
	Nivel is 20.

respetabilidad(Respetables, NoRespetables):-
	losRespetables(Respetables),
	losNoRespetables(NoRespetables).

losRespetables(Respetables):-
	findall(Personaje, personajeRespetable(Personaje), PersonajesRespetables),
	length(PersonajesRespetables, Respetables).

losNoRespetables(NoRespetables):-
	findall(Personaje, not(personajeRespetable(Personaje)), PersonajesNoRespetables),
	length(PersonajesNoRespetables, NoRespetables).

personajeRespetable(Personaje):-
	nivelRespeto(Personaje, Nivel),
	Nivel > 9.
