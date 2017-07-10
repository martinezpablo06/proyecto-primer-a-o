Program Aleatorio;
Uses 
	Libreria,crt;
Var
	Arch: Fichero; // Nombre del Archivo
	ini: Tpuntero; // Puntero a la cabeza de la Lista
	fin: Tpuntero; // Puntero al Final de la Lista
	cant: integer; // Cantidad de Elemento de la Lista
	
Procedure Menu (var q,r:Tpuntero; var cant:Integer; var f:fichero);
Var
	Opcion : char; // opcion menu principal
Begin
	Repeat
		ClrScr;
		TextColor (3);
		Writeln ('     _    _            _             _       ');
		Writeln ('    / \  | | ___  __ _| |_ ___  _ __(_) ___  ');
		Writeln ('   / _ \ | |/ _ \/ _` | __/ _ \| `__| |/ _ \ ');
		Writeln ('  / ___ \| |  __/ (_| | || (_) | |  | | (_) |');
		Writeln (' /_/   \_\_|\___|\__,_|\__\___/|_|  |_|\___/ ');
		TextColor (15);
		writeln;TextColor (15);
		Writeln ('Menu Principal');
		writeln;
		Writeln ('1- Agregar Estudiante');
		Writeln ('2- Borrar Estudiante');
		Writeln ('3- Modificar Estudiante');
		Writeln ('4- Consultar Estudiante');
		Writeln ('5- Consultar Ciudad');
		Writeln ('6- Promedio Edades');
		Writeln ('7- Listado Total');
		Writeln ('8- Salir');
		writeln;
		Write ('Elija una opcion: ');
		Repeat
			opcion := ReadKey
		Until (Opcion in ['1'..'8']);
		clrscr;
		Case (opcion) Of
			'1': LeerRegistro (q,r,cant);
			'2': BorrarElemento (q,cant);
			'3': Modificar (q,r,cant);
			'4': ConsultarElemento (q,f);
			'5': ConsultarCiudad (q,cant);
			'6': PromedioEdad (q,cant);
			'7': Mostrar (q);
		End
	Until (opcion = '8')
End;
Procedure Finish();
	Begin
		Clrscr;
		GoToXY (5,3); Write ('..........Por Favor Aguarde, Guardando Informacion............');
		Barras;
		GoToXY (5,5); Write ('Informacion Guardada Con Exito');
		GoToXY (5,5); Write ('Gracias Por Utilizar Aleatorio, Que Tenga Buen Dia ');
		Delay (2000); Writeln; Writeln;
	End;
	
Begin 
      Inicializar(ini,fin);
      Clrscr;
      Assign (Arch, 'alumnos.dat');
      Activar (Arch);
      CargarLista(ini,fin,Arch,cant);
      Menu (ini,fin,cant,Arch);
      CargarArchivo (ini,Arch);
      Finish;
End.

