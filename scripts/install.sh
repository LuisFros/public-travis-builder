pwd=$( aws ecr get-login-password --region us-east-1)
docker container stop $(docker container ls -aq)
docker login -u AWS -p $pwd 564835583352.dkr.ecr.us-east-1.amazonaws.com/backend_web
docker pull 564835583352.dkr.ecr.us-east-1.amazonaws.com/backend_web