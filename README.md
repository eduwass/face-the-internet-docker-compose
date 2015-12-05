# Face The Internet
Face The Internet client &amp; server setup in a Docker compose multi-container definition

* **Client**: [JohnPett/Face-the-Internet](https://github.com/JohnPett/Face-the-Internet)
* **Server**: [eduwass/face-the-internet-worker](https://github.com/eduwass/face-the-internet-worker)

Puts together both repos so you can launch them both as a multi-container Docker application.

# Usage
##### 1. Clone the repo **using recursive option**:
`git clone https://github.com/eduwass/face-the-internet-docker-compose.git --recursive`

##### 2. Start Docker VM Container
`docker-machine create --driver virtualbox dev`

##### 3. Set needed Docker env vars
`eval "$(docker-machine env dev)"`

##### 4. Run Docker Compose
`docker-compose up`

# Resetting Docker

##### 1. Stop and remove Docker containers:
`docker stop $(docker ps -a -q)`

`docker rm $(docker ps -a -q)`

##### 2. Kill and remove Docker containers (just in case):
`docker rm $(docker kill $(docker ps -aq))`

##### 3. Remove all images
`docker rmi $(docker images -q)`

