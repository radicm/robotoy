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
```

# Usage

```
# attach to docker 
cd bin

# start game
ruby start.rb

# game info 
-h
```

# Testing

```
# attach to docker
rspec spec
```
