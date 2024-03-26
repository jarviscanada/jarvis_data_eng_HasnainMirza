#! /bin/sh

# Initialize Variables 
cmd=$1
db_username=$2
db_password=$3

# Check is dockoer is working and start docker 
sudo systemctl status docker || sudo systemctl start docker

# Check container status 
docker container inspect jrvs-psql
container_status=$?

# Cases when commands are different .
case $cmd in 
  create)
  
  # Check if the container is already created
  if [ $container_status -eq 0 ]; then
		echo 'Container already exists'
		exit 1	
	fi

  #  Error check for number of arguments 

  if [ $# -ne 3 ]; then
    echo 'Create requires username and password'
    exit 1
  fi
  
  # Create container
	docker volume create pgdata
  # Start the container
	docker run --name $db_username -e POSTGRES_PASSWORD=$db_password  -d -v pgdata:/var/lib/postgresql/data -p 5432:5432 postgres:9.6-alpine
	exit ?
	;;

  start|stop) 
  # Check instance status;
  if [ $container_status -ne 0 ]; then
	echo' Container does not exist '
	exit 1
  fi
   

  # Start or stop the container ; save the exit code for our exit command
	docker container $cmd jrvs-psql
	exit $?
	;;	

  *)
	echo 'Illegal command'
	echo 'Commands: start|stop|create'
	exit 1
	;;
esac 
