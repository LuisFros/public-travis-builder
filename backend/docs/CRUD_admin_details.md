## CRUD Admin

Acceso vía `backend_url/admin`. Solo usuarios con atributo `is_admin=true`, podrán acceder al dashboard de la app de admin al hacer login.

Archivo de seeds crea al usuario con id 1 con status de admin. Otros usuarios creados posteriormente pueden ser setados como admin/no_admin al setear el atributo `user.is_admin == true/false` según sea el caso requerido.

Funcionalidades

**CRUD Users**
 - Delete users: Se eliminan los mensajes del usuario eliminado, no así para las salas creadas por este.
 - No se pueden eliminar usuarios que son admin (solo se puede realizar vía consola de la aplicación).

**CRUD Rooms**

 - Sobre el cambio de sala pública a privada: Todos los participantes (que hayan enviado mensajes en la sala pública) pasan a ser miembros de la sala privada.

**CRUD RoomMessages**
 - Se pueden modificar mensajes y mantener el mensaje original, el cual solo está accesible para los usuarios adminsitradores.
 - Se puede enviar mensaje en una sala en particular (Crear mensaje e indicar la sala de destino) o se puede enviar un mensaje masivo a varias salas (En el index de salas, seleccionar las salas requeridas, apretar "Batch actions", seleccionar la opción de "Send messages to rooms", escribir el mensaje en el recuadro recién abierto y confirmar envío. batch action).

**Authenticate status:**
 - Not implemented. Currently, CRUD admin actions has free access.
 --