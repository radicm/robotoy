# Setup

```
# position in project root dir and run
docker build -t app .

# init start app
docker run -d -it --name=robotoy app

# stop app
docker stop robotoy

# start app
docker start robotoy

# remove container 
docker rm robotoy

# attach to container
docker exec -it robotoy bash

# in case you get access error during app start
sudo chmod +x docker/start.sh
```

# Usage

```
# Attach to docker 
cd bin

# Start game
ruby start.rb

# Game info 
-h
```

# Testing

```
# Attach to docker
rspec spec
```
