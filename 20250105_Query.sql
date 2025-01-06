# Consulta de los usuarios con sus correos
SELECT U.nombre, U.apellido, C.email, C.tipo FROM usuario U
JOIN usuario_correo UC ON U.id = UC.usuario_id
JOIN correo C ON UC.correo_id = C.id;