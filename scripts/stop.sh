docker-compose -f home/ubuntu/backend/prod-docker-compose.yml down
docker stop $(docker ps -a -q)