 ### Iniciar:
## REFERENCES: 
- https://aws.amazon.com/premiumsupport/knowledge-center/codedeploy-agent-non-root-profile/
- https://docs.aws.amazon.com/codedeploy/latest/userguide/troubleshooting-deployments.html#troubleshooting-deployments-lifecycle-event-failures


## CI/CD
1. Travic CI se usa para hacer el CI/CD conecatado con CodeDeploy + S3.
2. El release se comprime en un ZIP
3. Se hace un build en Docker de la imagen actual y se sube a ECR
4. Se sube al archivo ZIP comprimido a S3 para que CodeDeploy pueda acceder a el.
5. Se revisa el Bucket S3 con el release, se descomprime y se corren los scripts definidos en `appspec.yml` y guardados en `scripts/`.
6. Travis espera a que el deploy sea exitoso.
7. CodeDeploy trae la imagen de ECR y corre el contenedor.
8. Para poder configurar CodeDeploy y correr Docker en las instancias del AutoScaling group, se usa el siguiente `UserData` para iniciar una instancia EC2. 
```
#!/bin/bash
sudo apt-get update -y
sudo apt  install awscli -y
## INSTALL DOCKER
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install -y docker-ce
sudo usermod -aG docker ubuntu

# Install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo apt-get install ruby -y
sudo apt-get install wget -y
cd /home/ubuntu
wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install
sudo chmod +x ./install
sudo ./install auto
sudo service codedeploy-agent start
```
9. Adicionalmente para manejar las variables de ambiente de las instancias, se usa un snapshot para que los volumenes tengan un arcivo `.env.prod` con las variables sensibles necesarias. 
10. Variables de ambiente de Travis CI: Se entregan credenciales AWS de un rol creado para Travis (llamado `travisCI`). Este tiene permisos solo para poder subir artefactos a S3 y llamados a CodeDeploy. 
11. Las instancias EC2 tienen un usuario `r2d2` que tiene permisos para acceder a servicios de AWS: `RDS, ECR, S3, Cognito` 

cd backend  
sudo docker-compose -f local-docker-compose.yml build  
sudo docker-compose -f local-docker-compose.yml up  


El backend está corriendo en el puerto 3000.

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
