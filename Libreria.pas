Unit Libreria;

Interface

Uses 
	Crt;
Type
	Testudiante = Record
		nombre: String [25];
		apellido: String [25];
		dni: Longint;
		calle: String [25];
		ciudad: String [25];
		codigoPostal: LongInt;
		edad: LongInt;
	End;
	Fichero = File Of Testudiante;
	Tpuntero = ^Tnodo;
	Tnodo = Record
		info: Testudiante;
		next: Tpuntero;
		back: Tpuntero;
	End;
	Tdoblete = ^Telem;
	Telem = Record
		info: Integer;
		next: Tdoblete;
	End;
	
Procedure Activar (Var F: Fichero);
Procedure Inicializar (Var q,r: Tpuntero);
Procedure Barras();
Procedure Mostrar (s:Tpuntero);
Procedure LeerRegistro (Var q,r: Tpuntero; Var cant: Integer);
Procedure BorrarElemento (Var q: TPuntero; Var cant: integer);
Procedure ConsultarCiudad (q: Tpuntero; Var cant: integer);
Procedure CargarArchivo (q: Tpuntero; Var F: Fichero);
Procedure ConsultarElemento (q: Tpuntero; var f: fichero);
Procedure Modificar (Var cabeza: Tpuntero; Var r: Tpuntero; cant: integer);
Procedure PromedioEdad (q: Tpuntero; cant: Integer);
Procedure CargarLista (Var q,r: Tpuntero; Var F: Fichero; Var cant: integer);



Implementation
	
Procedure Activar (Var f: Fichero);
Var
	resultado: integer;
Begin
	Clrscr;
	{$I-}
	Reset (f);
	resultado := IOresult;
	{$I+}
	If (resultado <> 0) Then Begin // si el archivo no existe
		Rewrite (f);
	End;
	Close (f)
End;

Procedure Inicializar (Var q,r:Tpuntero);
Begin
	new(q);
	new(r);
	q^.next := r;
	r^.next := Nil;
	r^.back := q;
	q^.back := Nil;
End;

Procedure Insertar(Var pos: TPuntero; Var c: Integer; e: Testudiante;Var p: TPuntero);
Var 
	elem: Tpuntero;
Begin
	New(elem);
	p := elem;
	elem^.info := e;
	elem^.next := pos^.next;
	elem^.back := pos;
	pos^.next  := elem;
	(elem^.next)^.back := elem; 
    c := c+1;
End;
	
	
Procedure Ordenar(x:Testudiante; Var cant:Integer; Var q,r:Tpuntero;Var p: TPuntero); // B MF
Var	
	nuevo: Tpuntero; // Puntero para recorer la Lista	
Begin
	If (cant < 1) Then Begin // si secuencia vacia
		// tratamiento secuencia vacia
		Insertar(q,cant,x,p);
	End
	Else Begin // si secuencia no vacia
		nuevo := q; // inicializacion del tratamiento
		While ((nuevo^.next <> r) And (nuevo^.info.dni < x.dni)) Do Begin // mientras no fin de secuencia y no p elem
			nuevo := nuevo^.next; // obtener sig elemento
		End;
		If (nuevo^.info.dni > x.dni) Then Begin // no fin de secuencia
			// tratamiento elemento hallado
			nuevo:=nuevo^.back;
			Insertar(nuevo,cant,x,p);
		End
		Else Begin
			If  (nuevo^.info.dni < x.dni) Then Begin // fin de secuencia
				// tratamiento elemento no hallado
				Insertar(nuevo,cant,x,p);
			End;
		End;
	End;
End;

Procedure Barras();
Var i: integer;
Begin
	For i:=1 to 2 Do Begin
		TextColor(3);
		GoToXY(5,5); Write ('                   	       <<>>                                  ');Delay(200);
		GoToXY(5,5); Write ('                            <<    >>                                ');Delay(200);
		GoToXY(5,5); Write ('                          <<        >>                              ');Delay(200);
		GoToXY(5,5); Write ('                        <<            >>                            ');Delay(200);
		GoToXY(5,5); Write ('                      <<                >>                          ');Delay(200);
		GoToXY(5,5); Write ('                    <<                    >>                        ');Delay(200);
		GoToXY(5,5); Write ('                  <<                        >>                      ');Delay(200);
		GoToXY(5,5); Write ('                <<                            >>                    ');Delay(200);
		GoToXY(5,5); Write ('              <<                                >>                  ');Delay(200);
		GoToXY(5,5); Write ('            <<                                    >>                ');Delay(200);
		GoToXY(5,5); Write ('          <<                                        >>              ');Delay(200);
		GoToXY(5,5); Write ('        <<                                            >>            ');Delay(200);
		GoToXY(5,5); Write ('      <<                                                >>          ');Delay(200);
		GoToXY(5,5); Write ('    <<                                                    >>        ');Delay(200);
		GoToXY(5,5); Write ('  <<                                                        >>      ');Delay(200);
		GoToXY(5,5); Write ('<<                                                            >>    ');
		GoToXY(5,5); Write ('                                                                    ');
		TextColor(white);
	End;
End;

Procedure CargarLista (Var q,r:Tpuntero; Var F: Fichero; Var cant:integer); // R1 MI
Var
	x: Testudiante; // Lee el Contenido del Archivo.
	p: TPuntero; // variable relleno para ordenar
	Procedure Inicio();
	Begin
		Clrscr;
		GoToXY (5,3); Writeln ('..........Por Favor Aguarde, Recuperando Informacion............');
		Barras;
		GoToXY (5,5); Write ('Informacion Recuperada Con Exito ');
		Delay (2000);
	End;
Begin    
	cant := 0; // inicializacion del tratamiento
	Reset(f); // inicializacion de la adquisicion
	While (not(eof(f))) Do Begin // mientras no fin de secuencia
  	Read(f,x); // obtener siguiente elemento
	Ordenar (x,cant,q,r,p); // tratamiento elemento corriente
    cant := cant+1;
	End;
	Inicio;
	Close(f); // tratamiento final
End;

Procedure CargarArchivo (q:Tpuntero; Var F: Fichero); // R1 MF
Var
	x: Testudiante; // Lee el contenido del archivo.
	
Begin
	Rewrite(f); // inicializacion de la adquisicion
	q := q^.next; // inicializacion del tratamiento
	While (q^.next <> Nil) Do Begin // mientras no fin de secuencia
		x := q^.info; // tratam elemento corriente
		// obtener sig elemento
		Write(f,x);
		q := q^.next; 
	End;
	Close(f); // tratamiento final
End;

Procedure Visualizar (e: Testudiante;i: integer; j: integer);
Begin
	With e Do Begin
		GoToXY(i,j); Writeln ('Nombre: ', nombre);
		GoToXY(i,j+1); Writeln ('Apellido: ', apellido);
		GoToXY(i,j+2); Writeln ('Dni: ', dni);
		GoToXY(i,j+3); Writeln ('Calle: ', calle); 
		GoToXY(i,j+4); Writeln ('Ciudad: ', ciudad); 
		GoToXY(i,j+5); Writeln ('Codigo Postal: ', codigoPostal);
		GoToXY(i,j+6); Writeln ('Edad: ', edad);
	End;
	Writeln;
End;

Procedure Tratamiento (Var i: integer;Var j: Integer;Var cont: Integer;Var b: Boolean;q: TPuntero);
Var c: Char;
Begin
	If (cont < 2) Then Begin
		If (cont mod 2 = 0) Then Begin
			i := 0;
		End
		Else Begin
			i := 45;
		End;
	End
	Else Begin
		If (cont mod 2 = 0) Then Begin
			i := 0;
			j := j+8;
		End
		Else Begin
			i := 45;
		End;
	End;
	Visualizar (q^.info,i,j);
	If (cont = 7) Then Begin
	   Writeln;Write ('Presione "ESC" para salir del listado o cualquier tecla para continuar');
	   c := readkey;
	   If (Ord(c) <> 27) Then Begin
		  ClrScr;
		  GoToXY (25,2);Writeln ('Listado De Estudiantes');Writeln;
		  j := 4;
		  i := 0;
		  cont := -1;
	   End
	   Else Begin
		  b := True;
	   End;
    End;
End;

Procedure Mostrar (s: Tpuntero); // R2 MF
Var
	q: Tpuntero; // Puntero a la Cabeza de la Lista para Recorrer.
    i: integer; // parametro para el gotoxy de tratamiento
    j: integer; // parametro para el gotoxy de tratamiento
    cont: integer; // cantidad estudiantes q muestra por pantalla
	b: Boolean; // bande la logica para no mostrar toda la lista

Begin
	q := s^.next; // inicializacion de la adquisicion
	If (q^.next = Nil) Then Begin // secuencia vacia
		GoToXY(5,2); Writeln; Write ('No Hay Elementos Cargados'); // tratamiento secuencia vacia
		GoToXY(5,4); Writeln; Write ('Presione una tecla para salir ');
		Readkey;
	End
	Else Begin // secuencia no vacia
		GoToXY(25,2);Writeln('Listado De Estudiantes');Writeln;
		j := 4;
		i:=0;
		cont := 0;
		b := false;
		While ((q^.next <> Nil) and (not(b))) Do Begin // mientras no fin secuencia y no p elem
			Tratamiento(i,j,cont,b,q);// tratam elemento corriente
			q := q^.next; // obtener siguiente elemento
			cont := cont+1;
		End;
		If (not(b)) Then Begin // tratam elem no hallado
			Writeln; Write ('Fin Del Listado Presione una tecla para continuar');
			readkey;
		End;
		// tratam elem hallado = 'nada'
	End;
End;

Function EsLetra (c: Char): Boolean;
Begin
	If ((('a' <= c) And (c <= 'z')) Or (('A' < c) And (c < 'Z')) ) Then Begin
		EsLetra := True;
	End
	Else Begin
		EsLetra := False;
	End;
End;

Function EsNum (c: Char): Boolean;
Begin
	If (('0' <= c) And (c <= '9')) Then Begin
		EsNum := True;
	End
	Else Begin
		EsNum := False;
	End;
End;

Procedure SoloLetras (Var x: String);
Var
	cadena: String; // Texto a leer
	c: Char; // digito actual
	b: Boolean; // bandera para caso de ingresar solo 'enter'
	cant:Integer; // control de ciclo
Begin
	cadena := '';
	cant := 0;
	b := True;
	Repeat
		c := readkey;
		If ((Ord(c) = 13) And (cant = 0)) Then Begin // si caracter='enter' y es el primer digito
			b := False;
		End
		Else Begin
			If ((EsLetra(c)) Or ((c = ' ' ) And (cant <> 0))) Then Begin
			// las flechas direccionales, delet, avpag, etc. las lee como letras mayusculas
				cant := cant + 1;
				c := Upcase(c);
				Write (c);
				cadena := cadena + c;
			End;
		End;
	Until ((Ord(c) = 13) And (b) And ( cant > 0));// si caracter='enter' y bandera=true y x>0
	x := cadena;
End;

Procedure SoloNum (var x: longint); // no pueden ingresarse letras
Var
	cadena: string; // Texto Completo 
	c: char; // digito actual
	b:Boolean; // bandera para caso de ingresar solo entre o dni=0
	cant:Integer; // control de ciclo
	Pos: Integer; // control de errores, el compilador la muestra como nota
Begin
	cadena := '';
	pos := 0;
	cant := 0;
	b := True;
	Repeat
		c := readkey;
		If ((ord(c) = 13) And (cant = 0)) Then Begin // si caracter='enter' y es el primer digito no lo toma
			b := False;
		End
		Else Begin
			If (EsNum(c)) Then Begin // si el caracter ingresado esta entre 0 y 9
				If (Not ((c = '0') and (cant = 0)))	Then Begin	// si el primer caracter es 0 no lo cuenta		
					Write (c);
					cadena := cadena + c;
					cant := cant+1;
					b := True
				End;
			End;
		End;
		Val(cadena,x,pos); // convierte la cadena a un longint
	Until ((ord(c) = 13) And (b = True) And (x <> 0)); // si caracter='enter' y bandera=true y dni>0
End;

Procedure NumLetras (Var x: String);
Var
	cadena: String; // codigo postal completo 
	c: Char; // digito actual
	b: Boolean; // bandera para caso de ingresar solo 'enter' o "0"
	cant: Integer; // control de ciclo
Begin
	cadena := '';
	cant := 0;
	b := True;
	Repeat
		c := readkey;
		If ( ((Ord(c) = 13) Or (c = '0') Or (c = ' ')) And (cant = 0)) Then Begin 
		// si el primer caracter es 'enter', "0" o espacio no lo toma
			b := False;
		End
		Else Begin
			If ( ( (EsLetra(c)) Or (EsNum(c)) Or (c = ' ') ) ) Then Begin
			// las flechas direccionales, delet, avpag, etc. las lee como letras mayusculas
				If (EsLetra(c)) Then Begin // si el caracter ingresado es una letra
					c := Upcase(c); // convierte a mayusculas
				End;		
				Write (c);
				cadena := cadena + c;
				cant := cant+1;
				b := True
			End;
		End;	x := cadena;
	Until ((Ord(c) = 13) And (b = True) And ( cant > 0)); // hasta que caracter='enter' y bandera=true y x>0

End;

Procedure BuscarDni(Var Dni: LongInt; Var aux:TPuntero; Var r: Tpuntero); // B MI
Begin
	Writeln;Write ('Dni: '); SoloNum(dni); // inicializacion de la adquisicion
	// el tratamiento por secuencia vacia es 'NADA'	'
	If (aux^.next <> r) Then Begin // si no fin de secuencia
		While ((aux^.next <> r) And (aux^.info.dni<dni)) Do Begin // mientras no fin de secuencia y no p elem
			aux:= aux^.next; // obtener siguiente elemento
		End;
	End;
	If (aux^.info.dni = dni) Then Begin // si lo encontro
		// tratamiento elemento hallado
		Writeln; Write ('DNI YA EXISTENTE. INGRESE OTRO');
		Delay(500);
	End;
	// no hay tratamiento por elemento no hallado
End;

Procedure LeerRegistro (var q,r: Tpuntero; Var cant: Integer);
Var
	e : Testudiante; // Registro del Estudiante
	aux: TPuntero; // Puntero para Recorrer la Lista 
    resp: Char;     // opcion salida
	p: TPuntero; // relleno para la llamada a ordenar	
Begin
	Repeat
		ClrScr;
		GoToXY (25,2); Writeln ('Agregar Estudiante');
		GoToXY(5,4); Writeln ('Presione "ENTER" para Continuar o "ESC" Para Salir');
		Repeat
			resp := readkey;
		Until ((ord(resp) = 13) or (ord(resp) = 27));
		Writeln;
		If (ord(resp) = 13) Then Begin // si desea continuar
			GoToXY(5,6); Writeln ('Nota: Ingrese solo numeros para "DNI", "CODIGO POSTAL" y "Edad"');
			GoToXY(5,7);Writeln ('Ingrese solo letras para "NOMBRE","APELLIDO", "CALLE" y "CIUDAD"');
			With e Do Begin
				Repeat
					aux := q;
					BuscarDni(dni,aux,r);
				Until (aux^.info.dni <> dni);
				Writeln; Write ('Nombre: '); SoloLetras (Nombre);
				Writeln; Write ('Apellido: '); SoloLetras (Apellido);
				Writeln; Write ('Calle: '); NumLetras (Calle);
				Writeln; Write ('Ciudad: '); SoloLetras (Ciudad);
				Writeln; Write ('Codigo Postal: '); SoloNum (CodigoPostal);
				Writeln; Write ('Edad: '); SoloNum (Edad);
				Writeln; 
			End;
			Ordenar (e,cant,q,r,p); // ordena el nuevo elemento en la lsta
			Writeln;Writeln ('La Carga Fue Exitosa');
			Delay (1000);
		End;
	Until (ord(resp) = 27);
End;

Procedure CargarDoblete (var s: Tdoblete; var long: integer; edad: integer);
Var
	aux: Tdoblete; // Puntero para Carga el Doblete
Begin
	new(aux);
	aux^.info := edad;
	aux^.next := s^.next;
	s^.next := aux;
	s := aux;
	long := long+1;
End;

Procedure LeerEdades (Var min,max: Longint);
Begin
	Repeat
		Writeln;
		Write ('Ingrese la edad Minima: ');
		SoloNum (min);
	Until (min > 0);
	Repeat
		Writeln;
		Write ('Ingrese la edad Maxima: ');
		SoloNum (max);
	Until (max > min);
End;

Procedure Borrar (q: TPuntero; dni: longint; var cant: integer; var b:boolean); // B MI
Var	
	aux: Tpuntero; // Puntero a la Cabeza de la Lista para Recorrer
	free: Tpuntero;  // Puntero a eliminar de la Lista.
Begin
	aux := q; // inicializacion de la adquisicion
	If (aux^.next = Nil) Then Begin // si fin de secuencia
		Writeln; Write ('No Hay Elementos Para Eliminar'); // tratamiento secuencia vacia
	End
	Else Begin
		Repeat
			aux := aux^.next;    // obtener siguiente elemento
		Until ((aux^.info.dni = dni)or(aux^.next = nil)); // fin de secuencia 
	End;
	If (aux^.info.dni = dni) Then Begin // si encontro el elemento
	// tratamiento elememto hallado
		free := aux;
		(aux^.back)^.next := aux^.next;
		(aux^.next)^.back := aux^.back;
		free^.next := Nil;
		free^.back := Nil;
		dispose(free);
		cant := cant-1;
		b := True;
	End
	Else Begin // tratamiento elemento no hallado
		Writeln; Writeln; Write ('No Existe El Dni Ingresado ');
		Delay (1000); Writeln;
		b := False;
	End;
End;

Procedure BorrarElemento (Var q: TPuntero; var cant: integer);
Var
	x: Longint;  // Variable para Ingresar el Dni a Borrar.
	resp: Char; // opcion del salida
	b: Boolean;	// bandera logica, informa si borro o no
Begin
	Repeat
		Clrscr;
		GoToXY (25,2); Writeln	('Borrar Estudiante');
		Repeat
			GoToXY(5,4); Write('Presione "ENTER" para Continuar o "ESC" Para Salir ');
			resp := readkey;
		Until ((ord(resp) = 13) Or (ord(resp) = 27));
		If (ord(resp) = 13 ) Then Begin	// si desea continuar
			ClrScr;
			mostrar (q); // muestra la lista
			If ((q^.next)^.next <> Nil) Then Begin // si no fin de secuencia
				ClrScr;
				b := False;
				GoToXY (25,2); Writeln ('Ingrese el Dni del estudiante a eliminar ');
				GoToXY(5,4); Writeln ('Nota: El DNI debe ser Mayor a "0". ');
				Writeln; Write ('Dni: ');
				SoloNum (x); // lee el dni a borrar
				Borrar (q,x,cant, b);
				If (b) Then Begin // si borro
					Writeln; Writeln; Write ('El Estudiante Fue Eliminado Con Exito ');
					Delay (1000);
				End;
			End
			Else Begin // si desea salir
				resp := Chr(27);
			End;
		End;
	Until(ord(resp) = 27);
End;

Procedure BuscarCiudad (q: Tpuntero; var cant: integer); // RP MI
var
	e: boolean;	// verdadero cuando encuentra la ciudad
	b: boolean;	// verdadero cuando encuentra la ciudad
	f: boolean;	// verdadero cuando encuentra la ciudad
	aux: Tpuntero; // recorre la Lista estudiantes
	aux2: Tpuntero; // auxiliar para carga
	w,z:Tpuntero; // puntero a la cabeza y final lista ciudad
	r: Tpuntero; // puntero auxiliar al final de lista ciudad
	ciudad: string; // nombre de la ciudad ingresada
	resp: char; // respuesta menu borrar
	dni: longint; // dni estudiante a eliminar
	i: integer; // cantidad de elementos de la lista ciudades
Begin
	// inicializacion de la adquisicion
	inicializar (z,w);
	r := w;
	aux := q;
 	e := False;
	i := 0;
 	If ((aux^.next)^.next = Nil) Then Begin // si secuencia vacia
		Writeln; Write('No hay ciudades para consultar ');
		Readkey;
	End
	Else Begin // secuencia no vacia
		// inicializacion del tratamiento
		Writeln; Write ('Ingrese la ciudad: ');
		SoloLetras (ciudad); Writeln;
		Repeat
			aux := aux^.next; // obtener siguiente elemento
			//tratamiento elemento corriente
			If (ciudad = aux^.info.ciudad) Then Begin
				new(aux2);
				aux2^.info := aux^.info;
				(r^.back)^.next := aux2;
				aux2^.back := r^.back;
				aux2^.next := r;
				r^.back := aux2;
				e := True;
				i := i+1;
			End;
		Until (((aux^.next)^.next) = Nil);
	End;
	If (not(e)) Then Begin
		If  (cant > 0) Then Begin
			Writeln; Write ('La ciudad no se encuentra ' ); // tratamiento elemento no hallado
			Delay (1000);
		End;
	End
	Else Begin // tratamiento elemento hallado
		Repeat
			ClrScr;
			Mostrar(z);
			Writeln; Writeln; Write ('Presione "E" para eliminar o "Esc" para salir ');
			resp := readkey;
			If ((resp = 'e') Or (resp = 'E')) Then Begin;
				writeln; Writeln; write ('Ingrese el dni a eliminar: ');
				SoloNum (dni);
				b := False;
				f := False;
				Borrar (z,dni,i,b); // borra de la lita ciudades
				If (b) Then Begin
					Borrar (q,dni,cant,f); // borra la lista estudiantes
				End;
				If (b and f) Then Begin
					Writeln; Writeln; Write ('El Estudiante Fue Eliminado Con Exito ');
					Delay (1000);
				End;
			End;
		Until ((ord(resp) = 27) Or (i = 0));
	End;
End;

Procedure ConsultarCiudad (q: Tpuntero; var cant: integer); // RP MI
var
	resp: char; // respuesta menu continuar
Begin
	Repeat
		Clrscr;
		GoToXY (25,2);
		Writeln	('Consultar Ciudad');
			GoToXY(5,4);
			Write('Presione "ENTER" para Continuar o "ESC" Para Salir ');
		Repeat
			resp := readkey;
		Until ((ord(resp) = 13) or (ord(resp) = 27));
		If (ord(resp) = 13) Then Begin
			Writeln;
			BuscarCiudad (q,cant);
			If (cant = 0) Then Begin
				resp := Chr(27);
			End;
		End;
	Until (ord(resp) = 27);
End;

Function Promedio (q: Tdoblete; long,suma: integer): real;
Begin
	If (q = Nil) Then Begin
		Promedio := (suma/long);	
	End
	Else Begin
		Promedio := Promedio(q^.next,long,suma+q^.info);
	End;
End;

Procedure MostrarPromedio (q: Tpuntero); // R2 MF
Var
	r: Tpuntero; // Puntero a la Cabeza de la Lista.
	t: Tdoblete; // Puntero que crea una Lista
	aux: Tdoblete; // Puntero auxiliar a "t"
	long: integer; // Longitud de la Lista edades
	suma: Longint; // almacena suma edades dentro del rango
	max: Longint;  // edad maxima
	min: Longint;  // edad minima
	prom: real;  //  almacena promedio edades
	encontro: boolean; // verdadero Cuando lo Encuentra

Begin
	r := q; // inicializacion de la adquisicion
	LeerEdades (min,max);
	If (r = Nil) Then Begin // si fin de secuencia
		Writeln('No hay alumnos,'); // trat sec vacia
	End
	ELse Begin  // tratamiento secuencia no vacia
		new(t); // inicializacion del tratamiento
		t^.next := Nil;
		aux := t;
		long := 0;
		r := r^.next;
		encontro := False;
		While (r^.next <> Nil) Do Begin // mientras no fin secuencia
			// tratamiento elemento corriente
			If ((min <= r^.info.edad) And (r^.info.edad <= max)) Then Begin;
			CargarDoblete (aux,long,r^.info.edad);
			encontro := True;
			End;
			r := r^.next; // obtener siguiente elememto
		End;
	End;
	Writeln; // tratamiento final
	If (encontro) Then Begin
		suma := 0;
		aux := t^.next;
		prom := Promedio(aux,long,suma);
		Writeln; Write ('El Promedio es: ',prom:0:2);
		Readkey;
	End
	Else Begin
		Writeln; Write ('No hay alumnos con ese rango de edad ');
		Delay (1000);
	End;
End;

Procedure PromedioEdad (q: Tpuntero; cant: integer); // R2 MF
Var
	resp: char; // respuesta menu edad
Begin
	Repeat
		Clrscr;
		GoToXY (25,2); Writeln	('Promedio Edades');
		GoToXY(5,4); Write('Presione "ENTER" para Continuar o "ESC" Para Salir ');
		Repeat
			resp := readkey;
		Until ((ord(resp) = 13) or (ord(resp) = 27));
		If (ord(resp) = 13) Then Begin
			If (cant = 0) Then Begin
				Writeln; Writeln; Write ('No hay alumnos cargados');
				Readkey;
				resp := Chr(27);
			End
			Else Begin
				GoToXY(5,6); Writeln ('Nota: Edad minima debe ser mayor a "0" y edad maxima mayor a edad minima. ');
				MostrarPromedio (q);
			End;
		End;
	Until (ord(resp) = 27);
End;

Procedure ModificarDni (Var cab: Tpuntero; r: Tpuntero; e: Testudiante; cant: integer; Var em: TPuntero ); // R1 MI
Var		
	aux: Tpuntero; // auxiliar para recorrido de lista
	dni: Longint; // campo a cargar
Begin
	Repeat // inicializacion de la adquisicion
		aux := cab;
		BuscarDni (dni,aux,r)
	Until (aux^.info.dni <> dni); 
	
	aux := cab; // inicializacion del tratamiento
	While (aux^.info.dni <> e.dni)  Do Begin
		//Tratamiento elemento corriente = 'Nada'
		aux := aux^.next;
	End;
	// tratamiento final
	em := aux;
	e.dni := dni;
	// aislo el elemento para realizar una insercion ordenada
	(em^.next)^.back := em^.back;
	(em^.back)^.next := em^.next;
	cant := cant-1;
	Ordenar (e,cant,cab,r,em);
End;

Procedure MenuModificar(cabeza: Tpuntero; r: Tpuntero; cant: integer; Var a: TPuntero);
Var
	opcion: Char;
	e: Testudiante;
Begin
	repeat
		ClrScr;
		Writeln ('Menu De Modificacion');
		writeln;
		Writeln ('1- Nombre');
		Writeln ('2- Apellido');
		Writeln ('3- Dni');
		Writeln ('4- Calle');
		Writeln ('5- Ciudad');
		Writeln ('6- Codigo Postal');
		Writeln ('7- Edad');
		Writeln ('8- Salir');
		writeln;
		Writeln; Write ('Seleccione La Opcion Que Corresponda');
		Repeat
			opcion := ReadKey
		until (Opcion in ['1'..'8']);
		Writeln;Writeln;
		case opcion of
			'1': Begin
				Write ('Nombre: ');  SoloLetras(a^.info.Nombre);
			 End;
			'2': Begin
				Write ('Apellido: '); SoloLetras(a^.info.Apellido);
			 End;
			'3': Begin
				e:= a^.info; ModificarDni(cabeza,r,e,cant,a);
			End;
			'4': Begin
				Write ('Calle: '); NumLetras(a^.info.Calle);
			End;
			'5': Begin
				Write ('Ciudad: '); SoloLetras(a^.info.Ciudad);
			End;
			'6': Begin
				Write ('Codigo Postal: '); SoloNum(a^.info.CodigoPostal);
			End;
			'7': Begin
				Write ('Edad: '); SoloNum(a^.info.edad);
			End;
		End;
		If (opcion in ['1'..'7']) Then Begin
			Writeln;Writeln;Write ('La Modificacion Fue Exitosa');
			Delay(1000);
		End;
	Until (opcion = '8')
End;

Procedure BuscarElemento(Var cabeza: TPuntero;Var r: TPuntero;Var x: Longint;Var cant: Integer); // B MI
Var aux: TPuntero; // puntero para recorrer la lista
Begin
	// inicializacion de la adquicicion;
	Writeln;Writeln;Write ('Ingrese el Dni De La Persona Que Desea Modificar: ');
	SoloNum (x);
	aux := cabeza;
	// tratamiento por secuencia vacia = 'NADA'
	If (aux^.next <> r) Then Begin // si secuencia no vacia
		While ((aux^.next <> r) And (aux^.info.dni < x)) Do Begin // no fin de secuencia y no p elem
			aux := aux^.next; // Obtener siguiente elemento
		End;
		If (aux^.info.dni = x)Then Begin // encontroelemento
			MenuModificar(cabeza,r,cant,aux);// tratamiento elemento hallado
		End
		Else Begin // tratamiento elemento no hallado
			Writeln;Writeln; Write('El Dni Ingresado No Existe ');
			Delay (1000);
		End;
	End;
End;

Procedure Modificar (Var cabeza: Tpuntero; Var r: Tpuntero; cant: integer);
var
    resp: char; // opcion de continuacion
    aux: Tpuntero; // auxiliar para recorrido de la lista
    x: longint; // dni del elemento a modificar
Begin
	aux := cabeza;
	If (aux^.next =r) Then Begin // si fin de secuencia
		Writeln;Writeln; Write ('No Hay Elementos Cargados');
		Readkey;
	End
	Else Begin   
		Repeat
			Clrscr;
			Mostrar (cabeza);
			BuscarElemento(cabeza,r,x,cant);
			Writeln;Writeln; Write('Pulse La Tecla "Esc" Para Ir Al Menu Principal ');
			Writeln;Write ('Pulse Cualquier Tecla Para Continuar ');
			resp := readkey;
		Until(ord(resp)=27);
	End;
End;

Procedure BusquedaDicotomica (Var f: fichero);
Var 
	limInf: Testudiante; // primer elemento del archivo
	limSup: Testudiante; // ultimo elemento del archivo
	inf: integer; // posicion inferior
	sup: integer; // posicion superior
	k: integer;	// posicion medio
	dni: longint; // elemento a comparar
	cant: integer; // cantidad de elementos
Begin
	Reset(f);
	Read(f,limInf); // carga elemento inferior
	cant := filesize(f)-1;
	Seek (f,cant);
	Read(f,limSup); // carga elemento superior
	Writeln; Write('Ingrese el dni a Consultar: ');
	SoloNum (dni);
	Writeln;
	If ((dni < limInf.dni) Or (dni > limSup.dni)) Then Begin // si el dni no esta dentro de los limites del archivo
		Writeln;Writeln('El estudiante No Existe');
		Delay (1000);
	End
	Else Begin
		inf := 0;
		sup := cant;
		k := ((inf+sup) div 2);
		Seek (f,k); // posiciona en el medio archivo
		Read(f,limInf); // lee el elemento del medio
		Repeat
			If (dni > limInf.dni) Then Begin // si el elemento a comparar es mayor al elemento del medio
				inf := k+1; // posiciono el inferior en mitad+1 (toma mitad derecha)
			End
			Else Begin		
				sup := k; // posiciona el superior en la mitad (toma mitad izquierda)
			End;
				k := ((inf+sup) div 2); // reasigna la posicion del medio
				Seek (f,k); // posiciona en el medio archivo
			Read(f,limInf);
		Until (not(inf < sup));
		If (dni = limInf.dni) Then Begin // si encontro el elemento
			Writeln;
			Visualizar (limInf,0,11); // lo muestra
			readkey;
		End
		Else Begin
			Writeln; Write ('El estudiante No Existe');
			Delay (1000);
		End;
	End;
End;

Procedure ConsultarElemento (q: Tpuntero; var f: fichero);
Var
	resp: char; // respuesta para continuar
Begin
	Repeat
		Clrscr;
		GoToXY (25,2); Writeln	('Consultar Estudiante');
		GoToXY(5,4); Write('Presione "ENTER" para Continuar o "ESC" Para Salir ');
		Repeat
			resp := readkey;
		Until ((ord(resp) = 13) Or (ord(resp) = 27));
		If (ord(resp) = 13) Then Begin
			writeln;
			If ((q^.next)^.next <> nil) Then Begin // si no fin de secuencia 
				CargarArchivo(q,f); // vuelca la lista en el archivo 
				Writeln;
				BusquedaDicotomica (f);
            End
			Else Begin
				Writeln; Writeln; Write ('No Hay Elementos para consultar ');
				readkey;
				resp := Chr(27);
			End;
		End;
	Until (ord(resp) = 27);
End;

End.
