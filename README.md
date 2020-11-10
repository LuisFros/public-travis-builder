 ### Iniciar:
```
cd backend  
sudo docker-compose -f local-docker-compose.yml build  
sudo docker-compose -f local-docker-compose.yml up  
```

El backend está corriendo en el puerto 3000.

### To alter schema:
```
sudo docker-compose -f local-docker-compose.yml run web rails generate migration AddEmailToUser  
sudo docker-compose -f local-docker-compose.yml run web rake db:migrate  
```
If having permission issues after that:  
```
sudo chown -R $USER:$USER .
```
 ### Docs:

 Utilizar Postman. Las llamadas están guardadas en la cartpeta /backend/postman_collections

# IIC2173 - Entrega 2
## Consideraciones generales
## Método de acceso al servidor con archivo .pem y ssh (no publicar estas credenciales en el repositorio).
.pem en Canvas.  
SSH: 
- Todas las instancias EC2 tienen habilitado el puerto 22 para conectarse por SSH. Todas con el mismo archivo `.pem` que entregamos en Canvas. 
- Solo necestian saber la IP Publica de la instancia o el dns interno asignado por aws para elegir una instancia. 

 ### Iniciar:
```
cd backend  
sudo docker-compose -f local-docker-compose.yml build  
sudo docker-compose -f local-docker-compose.yml up  
```

El backend está corriendo en el puerto 3000.

### To alter schema:
```
sudo docker-compose -f local-docker-compose.yml run web rails generate migration AddEmailToUser  
sudo docker-compose -f local-docker-compose.yml run web rake db:migrate  
```
If having permission issues after that:  
```
sudo chown -R $USER:$USER .
```
 ### Docs:

 Utilizar Postman. Las llamadas están guardadas en la carpeta /backend/postman_collections


✅ o ❌
## Parte Mínima

### Sección Mínima

#### Autentificación

* RF1
* RF2
* RF3
* RF4(opcional)

#### CI/CD

* RF1 ✅ -> Docs/CICD.md + Releases PR
* RF2 ✅ -> .travis.yml + Docs/CICD.md 
* RF3 ✅ -> .travis.yml + spec/
* RF4 ✅ -> Docs/CICD.md

#### Documentación

* RF1 ✅ -> Docs/components.png
* RF2
* RF3 ✅ -> Docs/deployment.png
* RF4

## Sección variable

### CRUD ADMIN
* RF1 ✅ -> Docs/CRUD_admin_details.md
* RF2 ✅ -> Docs/CRUD_admin_details.md
* RF3 ✅ -> Docs/CRUD_admin_details.md

### CSS/Javascript Injection ❌

### Encriptación
* RF1 ✅
* RF2 ❌
* RF3 ✅ (Arquitectura propuesta) -> Docs/encryption.pdf

## Release changes
v1.0.0
 - Add CRUD Admin