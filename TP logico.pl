%pareja(Persona, Persona)
pareja(marsellus, mia).
pareja(pumkin,    honeyBunny).
pareja(bernardo, charo).
pareja(bernardo, bianca).

%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).


saleCon(Persona, OtraPersona):-
	pareja(Persona, OtraPersona).
saleCon(Persona, OtraPersona):-
	pareja(OtraPersona, Persona).

trabajaPara(Empleador, bernardo):-
	trabajaPara(marsellus, Empleador),
	Empleador \= jules.
trabajaPara(Empleador, george):-
	saleCon(Empleador,bernardo).

esFiel(Persona):-
	saleCon(Persona,_),
	findall(SuPareja, saleCon(Persona, SuPareja),SusParejas),
	length(SusParejas, Cantidad),
	Cantidad=1.
