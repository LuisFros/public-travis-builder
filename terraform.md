## Servicios utilizados:
-  EC2:
  - Instancias
  - Auto Scaling Group
  - App Load Balancer
  - Target Group
- Code Deploy
 - App
 - Deployment Group
- S3
  - Deploy Artifact
  - Frontend
- Cloudfront
  - CDN
- VPC (Default)
  - Subnets 
- RDS

## Como mejorar? 

- Definir un namespace para poder hacer un deploy a partir de una variable de ambiente {staging} o {production}. 
- Hay algunas referencias con variables como el `var.DB_PASSWORD` o `aws_vpc_Main-VPC.id` pero varios Ids estan en texto plano. Seria mejor tenerlos como referencia por variables para mejorar la mantenibilidad
- Mantenere estado en Cloud seria mejor que el archivo .tfsate en el repo.
- AMI es lo **unico** que tiene que estar creado para poder montar la infraestructura.