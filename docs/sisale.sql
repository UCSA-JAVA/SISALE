CREATE TABLE roles (
  id INTEGER   NOT NULL ,
  nombre TEXT    ,
  descripcion LONGTEXT      ,
PRIMARY KEY(id));




CREATE TABLE prioridad (
  id INTEGER   NOT NULL ,
  nombre TEXT    ,
  descripcion LONGTEXT      ,
PRIMARY KEY(id));




CREATE TABLE niveles_de_bloqueo (
  id INTEGER   NOT NULL ,
  nombre TEXT    ,
  descripcion LONGTEXT      ,
PRIMARY KEY(id));




CREATE TABLE recursos (
  id INTEGER   NOT NULL ,
  nombre TEXT    ,
  descripcion LONGTEXT    ,
  tipo TEXT    ,
  costo_x_hora DOUBLE    ,
  fecha_ingreso DATETIME      ,
PRIMARY KEY(id));

COMMENT ON COLUMN recursos.tipo IS 'humano,hardware,etc';



CREATE TABLE empresa (
  ruc INTEGER   NOT NULL ,
  razon_social LONGTEXT    ,
  direccion LONGTEXT    ,
  telefono TEXT    ,
  actividad LONGTEXT      ,
PRIMARY KEY(ruc));




CREATE TABLE estados (
  id INTEGER   NOT NULL ,
  nombre TEXT    ,
  descripcion LONGTEXT      ,
PRIMARY KEY(id));




CREATE TABLE proyectos (
  id INTEGER   NOT NULL ,
  empresa_ruc INTEGER   NOT NULL ,
  titulo LONGTEXT    ,
  descripcion LONGTEXT    ,
  fecha_creacion DATETIME    ,
  fecha_inicio DATETIME    ,
  fecha_fin DATETIME    ,
  fecha_limite DATETIME    ,
  version_mayor INTEGER    ,
  version_menor INTEGER    ,
  version_micro INTEGER      ,
PRIMARY KEY(id)  ,
  FOREIGN KEY(empresa_ruc)
    REFERENCES empresa(ruc));


CREATE INDEX proyecto_FKIndex1 ON proyectos (empresa_ruc);

COMMENT ON COLUMN proyectos.version_mayor IS 'Grandes cambios y mejoras';
COMMENT ON COLUMN proyectos.version_menor IS 'Grandes cambios y mejoras';
COMMENT ON COLUMN proyectos.version_micro IS 'Grandes cambios y mejoras';

CREATE INDEX IFK_empresa_proyecto ON proyectos (empresa_ruc);


CREATE TABLE usuarios (
  cedula INTEGER   NOT NULL ,
  recursos_id INTEGER   NOT NULL ,
  nombres LONGTEXT    ,
  apellidos LONGTEXT    ,
  direccion LONGTEXT    ,
  usuario_acceso TEXT    ,
  contrasena_acceso VARCHAR(20)      ,
PRIMARY KEY(cedula)  ,
  FOREIGN KEY(recursos_id)
    REFERENCES recursos(id));


CREATE INDEX usuarios_FKIndex1 ON usuarios (recursos_id);


CREATE INDEX IFK_recursos_usuarios ON usuarios (recursos_id);


CREATE TABLE modulos (
  id INTEGER   NOT NULL ,
  proyectos_id INTEGER   NOT NULL ,
  nombre LONGTEXT    ,
  descripcion LONGTEXT    ,
  fecha_creacion DATETIME    ,
  fecha_inicio DATETIME    ,
  fecha_fin DATETIME    ,
  fecha_limite DATETIME      ,
PRIMARY KEY(id)  ,
  FOREIGN KEY(proyectos_id)
    REFERENCES proyectos(id));


CREATE INDEX modulos_FKIndex1 ON modulos (proyectos_id);


CREATE INDEX IFK_proyectos_modulos ON modulos (proyectos_id);


CREATE TABLE roles_has_recursos (
  roles_id INTEGER   NOT NULL ,
  recursos_id INTEGER   NOT NULL   ,
PRIMARY KEY(roles_id, recursos_id)    ,
  FOREIGN KEY(roles_id)
    REFERENCES roles(id),
  FOREIGN KEY(recursos_id)
    REFERENCES recursos(id));


CREATE INDEX roles_has_recursos_FKIndex1 ON roles_has_recursos (roles_id);
CREATE INDEX roles_has_recursos_FKIndex2 ON roles_has_recursos (recursos_id);


CREATE INDEX IFK_roles_recursos ON roles_has_recursos (roles_id);
CREATE INDEX IFK_recursos_roles ON roles_has_recursos (recursos_id);


CREATE TABLE modulos_has_recursos (
  modulos_id INTEGER   NOT NULL ,
  recursos_id INTEGER   NOT NULL   ,
PRIMARY KEY(modulos_id, recursos_id)    ,
  FOREIGN KEY(modulos_id)
    REFERENCES modulos(id),
  FOREIGN KEY(recursos_id)
    REFERENCES recursos(id));


CREATE INDEX modulos_has_recursos_FKIndex1 ON modulos_has_recursos (modulos_id);
CREATE INDEX modulos_has_recursos_FKIndex2 ON modulos_has_recursos (recursos_id);


CREATE INDEX IFK_modulos_recursos ON modulos_has_recursos (modulos_id);
CREATE INDEX IFK_recursos_modulos ON modulos_has_recursos (recursos_id);


CREATE TABLE incidencias (
  id INTEGER   NOT NULL ,
  estados_id INTEGER   NOT NULL ,
  prioridad_id INTEGER   NOT NULL ,
  recursos_id INTEGER   NOT NULL ,
  modulos_id INTEGER   NOT NULL ,
  nombre TEXT    ,
  descripcion LONGTEXT    ,
  fecha DATETIME      ,
PRIMARY KEY(id)        ,
  FOREIGN KEY(modulos_id)
    REFERENCES modulos(id),
  FOREIGN KEY(recursos_id)
    REFERENCES recursos(id),
  FOREIGN KEY(prioridad_id)
    REFERENCES prioridad(id),
  FOREIGN KEY(estados_id)
    REFERENCES estados(id));


CREATE INDEX incidencias_FKIndex1 ON incidencias (modulos_id);
CREATE INDEX incidencias_FKIndex2 ON incidencias (recursos_id);
CREATE INDEX incidencias_FKIndex3 ON incidencias (prioridad_id);
CREATE INDEX incidencias_FKIndex4 ON incidencias (estados_id);


CREATE INDEX IFK_modulos_incidencias ON incidencias (modulos_id);
CREATE INDEX IFK_recursos_incidencias ON incidencias (recursos_id);
CREATE INDEX IFK_incidencias_prioridad ON incidencias (prioridad_id);
CREATE INDEX IFK_incidencias_estados ON incidencias (estados_id);


CREATE TABLE comentarios (
  id INTEGER   NOT NULL ,
  incidencias_id INTEGER   NOT NULL ,
  descripcion LONGTEXT      ,
PRIMARY KEY(id)  ,
  FOREIGN KEY(incidencias_id)
    REFERENCES incidencias(id));


CREATE INDEX comentarios_FKIndex1 ON comentarios (incidencias_id);


CREATE INDEX IFK_incidencias_comentarios ON comentarios (incidencias_id);


CREATE TABLE incidencias_has_niveles_de_bloqueo (
  incidencias_id INTEGER   NOT NULL ,
  niveles_de_bloqueo_id INTEGER   NOT NULL   ,
PRIMARY KEY(incidencias_id, niveles_de_bloqueo_id)    ,
  FOREIGN KEY(incidencias_id)
    REFERENCES incidencias(id),
  FOREIGN KEY(niveles_de_bloqueo_id)
    REFERENCES niveles_de_bloqueo(id));


CREATE INDEX incidencias_has_niveles_de_bloqueo_FKIndex1 ON incidencias_has_niveles_de_bloqueo (incidencias_id);
CREATE INDEX incidencias_has_niveles_de_bloqueo_FKIndex2 ON incidencias_has_niveles_de_bloqueo (niveles_de_bloqueo_id);


CREATE INDEX IFK_incidencias_bloqueo ON incidencias_has_niveles_de_bloqueo (incidencias_id);
CREATE INDEX IFK_bloqueo_incidencias ON incidencias_has_niveles_de_bloqueo (niveles_de_bloqueo_id);



