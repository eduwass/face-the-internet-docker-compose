# Face The Internet
Face The Internet client &amp; server setup in a Docker compose multi-container definition

* **Client**: [JohnPett/Face-the-Internet](https://github.com/JohnPett/Face-the-Internet)
* **Server**: [eduwass/face-the-internet-worker](https://github.com/eduwass/face-the-internet-worker)

Puts together both repos so you can launch them both as a multi-container Docker application.

# Usage
##### 1. Clone the repo **using recursive option**:
`git clone https://github.com/eduwass/face-the-internet-docker-compose.git --recursive`

##### 2. Start the Docker VM machine using the run.sh script
`. run.sh`

## Main Commands:
```
. run.sh        #  starts a Docker VM and runs both containers inside it    
. stop.sh       #  stops the running VM
. reset.sh      #  CAUTION deletes all docker VMs and containers and resets to default status
. ssh-client.sh #  starts an SSH session inside the Client container
. ssh-server.sh #  starts an SSH session iniside the Server container  
```

### Server example commands
First SSH into the server and then cd into app folder
`cd /app/`

##### Slice image to rows of 5% height
`convert -crop 100%x5% +repage ./examples/face3.png rows/%d_image.png`
##### [FaceMorpher](https://github.com/alyssaq/face_morpher) Morph two faces and output 30 images
`python facemorpher/morpher.py --src=examples/face3.png --dest=examples/face4.png --out_frames=out_folder --num=30`
##### [ShapeMorph](http://www.fmwconcepts.com/imagemagick/shapemorph/) Morph to shapes using point coordinates (x1,y1 x2,y2)
`bash shapemorph -f 30 -m "73,56 57,68" examples/face3.png examples/face4.png result.miff`
`convert result.miff result.jpg`

##### Facemorph 2 images and save their rows (src, mixed, dst) sliced

```
python facemorpher/morpher.py --src=examples/face3.png --dest=examples/face4.png --out_frames=morph --num=5 --alpha
mkdir rows
convert -crop 100%x5% +repage ./morph/frame1.png rows/src_%d.png
convert -crop 100%x5% +repage ./morph/frame2.png rows/mix_%d.png
convert -crop 100%x5% +repage ./morph/frame3.png rows/dest_%d.png
```

# Resetting Docker to default state

Just run `. reset.sh` or run this manually:

##### 1. Stop and remove Docker containers:
`docker stop $(docker ps -a -q)`

`docker rm $(docker ps -a -q)`

##### 2. Kill and remove Docker containers (just in case):
`docker rm $(docker kill $(docker ps -aq))`

##### 3. Remove all images
`docker rmi $(docker images -q)`

##### 4. Stop and remove docker-machine
`docker-machine stop dev`
`docker-machine rm dev`
