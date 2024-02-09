CREATE DATABASE  Practica1
go
use Practica1
go 

create table clientes
(
	clienteId int primary key identity(1,1),
	nombre varchar(50),
	email varchar(50)
)

create table pedidos 
(
	pedidoid int primary key identity (1,1),
	clienteID int,
	FechaPedido date,
	Total decimal(10,2),
	foreign key (clienteID) references clientes(clienteId)
)

  
INSERT INTO clientes (nombre, email) VALUES ( 'Juan P�rez', 'juan@gmail.com');
INSERT INTO clientes (nombre, email) VALUES ('Mar�a Garc�a', 'maria@gmail.com');

INSERT INTO pedidos (clienteID, FechaPedido, Total) VALUES (1, '2024-02-01', 150.00);
INSERT INTO pedidos (clienteID, FechaPedido, Total) VALUES (2, '2024-02-02', 200.50); 

select * from clientes

select * from pedidos as p inner join clientes as cli on p.clienteID = cli.clienteId

select cli.nombre, cli.email, p.FechaPedido, p.Total from pedidos as p inner join clientes as cli on p.clienteID = cli.clienteId

/*EJERCICIO 1 */
/*En este ejercicio, vamos a crear una base de datos llamada "GestionTareas" que servir� como backend para 
una aplicaci�n de gesti�n de tareas. Esta base de datos almacenar� informaci�n sobre usuarios, proyectos y tareas, 
permitiendo a los usuarios organizar, asignar y monitorear el progreso de las tareas dentro de diferentes proyectos.*/
create database GestionTareas
go
use GestionTareas
go

create table Usuarios 
(
	UsuarioID int primary key identity (1,1),
	Nombre varchar(75), 
	Email varchar(75), 
	Departamento varchar(75)
)

create table Proyectos
(
	ProyectoID int primary key identity (1,1), 
	UsuarioId int,
	Nombre varchar(75), 
	Descripcion varchar(75), 
	FechaInicio date, 
	FechaFin date,
	foreign key (UsuarioId) references Usuarios(UsuarioID)
)

create table Tareas 
(
	 TareaID int primary key identity (1,1), 
	 ProyectoID int, 
	 Descripcion varchar(75), 
	 FechaCreacion date, 
	 FechaLimite date, 
	 UsuarioID int, 
	 Estado varchar(10)
	 foreign key (UsuarioID) references Usuarios(UsuarioID),
	 foreign key (ProyectoID) references Proyectos(ProyectoID)
)

/*ACTIVIDAD*/
/*Se esta dise�ando una base de datos para un hospital, el hospital tiene m�ltiples 
departamentos, cada uno con su propio personal m�dico y administrativo.Cada paciente tiene 
un historial m�dico que incluye informaci�n sobre diagn�sticos, tratamientos y medicamentos suministrados.
Los m�dicos pueden realizar m�ltiples consultas y procedimientos m�dicos para cada paciente.*/

create database hospital 
go
use hospital
go

create table Departamento 
(
	Id_Departamento int primary key identity (1,1),
	nm_departamento varchar(75),

)

INSERT INTO Departamento (nm_departamento) VALUES ('Departamento Medico');
INSERT INTO Departamento (nm_departamento) VALUES ('Departamento Administrativo');

create table depMedico
(
	Id_Medico int primary key identity (1,1),
	Id_depMedico int,
	nombre varchar(75),
	especialidad varchar(75)
	foreign key (Id_depMedico) references Departamento (Id_Departamento)
)

INSERT INTO depMedico(Id_depMedico, nombre, especialidad) VALUES (1, 'Maria', 'Cirujana');
INSERT INTO depMedico(Id_depMedico, nombre, especialidad) VALUES (1, 'Juan', 'Dentista');


create table depAdmin
(
	Id_Admin int primary key identity (1,1),
	Id_depAdmin int,
	nombre varchar(75)
	foreign key (id_depAdmin) references Departamento (Id_Departamento)
)

INSERT INTO depAdmin(Id_depAdmin, nombre) VALUES (2, 'Susana');
INSERT INTO depAdmin(Id_depAdmin, nombre) VALUES (2, 'Manuel');

select * from depAdmin

create table Paciente
(
	id_Paciente int primary key identity (1,1), 
	nombre varchar(75),
	apellido varchar(75),
	diagnostico varchar(100),
	tratamiento varchar(100),
	medicamentos_Suministrados varchar(100)
)

INSERT INTO Paciente(nombre, apellido, diagnostico, tratamiento, medicamentos_Suministrados) VALUES ('Pedro', 'Ulloa', 'Favorable', '2 aspirinas c/d 2horas', 'Acetaminofen');
INSERT INTO Paciente(nombre, apellido, diagnostico, tratamiento, medicamentos_Suministrados) VALUES ('Flor', 'Ramos', 'Estable', 'Tomar agua', 'Suero')

create table Procedimientos
(
	Id_Procedimieto int primary key identity (1,1), 
	IdPaciente int,
	IdMedico int,
	nmProcedimiento varchar(75),
	descripcion varchar(100)
	foreign key (IdPaciente) references Paciente(id_Paciente),
	foreign key (IdMedico) references depMedico(Id_Medico)
	
)

INSERT INTO Procedimientos(IdPaciente ,IdMedico, nmProcedimiento, descripcion) VALUES (1, 1, 'TAC', 'Examen solicitado')
INSERT INTO Procedimientos(IdPaciente ,IdMedico, nmProcedimiento, descripcion) VALUES (2, 2, 'Biopsia', 'Confirmar sospechas')

create table consultas 
(
	Id_Consulta int primary key identity (1,1), 
	IdPaciente int,
	IdMedico int,
	IdProcedimieto int,
	descripcion varchar(100)
	foreign key (IdPaciente) references Paciente(id_Paciente),
	foreign key (IdMedico) references depMedico(Id_Medico),
	foreign key (IdProcedimieto) references Procedimientos(Id_Procedimieto)

)

INSERT INTO consultas (IdPaciente, IdMedico, IdProcedimieto, descripcion) VALUES (1, 1, 1, 'El paciente se presenta con sintomas de resfriado');
INSERT INTO consultas (IdPaciente, IdMedico, IdProcedimieto, descripcion) VALUES (2, 2, 2, 'Paciente con quemadura de primer grado');

select * from consultas