CREATE TABLE `Usuario` (
  `ID_Usuario` int PRIMARY KEY,
  `Nombre` varchar(80),
  `Password` varchar(50),
  `ID_Role` int,
  `Admin` bool COMMENT 'True: Es administrador, False: No es'
);

CREATE TABLE `Permiso` (
  `ID_Permiso` int PRIMARY KEY,
  `Nombre` varchar(50)
);

CREATE TABLE `UsuarioPermiso` (
  `ID_UsuarioPermiso` int PRIMARY KEY,
  `ID_Usuario` int,
  `ID_Permiso` int
);

CREATE TABLE `AuditoriaItems` (
  `ID_Auditoria` int PRIMARY KEY,
  `ID_Item` int,
  `Fecha_Accion` date,
  `Tipo_Accion` varchar(20) COMMENT 'Creacion, Modificacion',
  `ID_Usuario_Accion` int COMMENT 'Usuario que hizo la modificación'
);

CREATE TABLE `OrdenDeServicio` (
  `ID_OS` int PRIMARY KEY,
  `ID_Usuario` int,
  `Fecha_creacion` date,
  `Descripcion` varchar(255)
);

CREATE TABLE `Item` (
  `ID_Item` int PRIMARY KEY,
  `ID_OS` int,
  `ID_Item_Padre` int,
  `Nombre` varchar(20),
  `Clasificacion` varchar(20) COMMENT 'Evaluado, Repuesto, Base, Compra Local',
  `Ubicacion` varchar(7) COMMENT 'Bloque, Columna, Fila, Lado',
  `Estado` varchar(20) COMMENT 'Almacenado o Entregado',
  `Eliminado` bool COMMENT 'Borrado logico'
);

CREATE TABLE `ItemEntregado` (
  `ID_Entre` int PRIMARY KEY,
  `ID_Item` int,
  `Fecha_despacho` date
);

CREATE TABLE `ItemArchivado` (
  `ID_Arch` int PRIMARY KEY,
  `ID_Entre` int,
  `Fecha_archivado` date
);

ALTER TABLE `Item` ADD FOREIGN KEY (`ID_Item`) REFERENCES `AuditoriaItems` (`ID_Item`);

ALTER TABLE `Usuario` ADD FOREIGN KEY (`ID_Usuario`) REFERENCES `AuditoriaItems` (`ID_Usuario_Accion`);

ALTER TABLE `Usuario` ADD FOREIGN KEY (`ID_Usuario`) REFERENCES `UsuarioPermiso` (`ID_Usuario`);

ALTER TABLE `Permiso` ADD FOREIGN KEY (`ID_Permiso`) REFERENCES `UsuarioPermiso` (`ID_Permiso`);

ALTER TABLE `OrdenDeServicio` ADD FOREIGN KEY (`ID_Usuario`) REFERENCES `Usuario` (`ID_Usuario`);

ALTER TABLE `Item` ADD FOREIGN KEY (`ID_OS`) REFERENCES `OrdenDeServicio` (`ID_OS`);

ALTER TABLE `Item` ADD FOREIGN KEY (`ID_Item`) REFERENCES `Item` (`ID_Item_Padre`);

ALTER TABLE `ItemEntregado` ADD FOREIGN KEY (`ID_Item`) REFERENCES `Item` (`ID_Item`);

ALTER TABLE `ItemArchivado` ADD FOREIGN KEY (`ID_Entre`) REFERENCES `ItemEntregado` (`ID_Entre`);
