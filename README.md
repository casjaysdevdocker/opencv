## 👋 Welcome to opencv 🚀  

opencv README  
  
  
## Run container

```shell
dockermgr update opencv
```

### via command line

```shell
docker pull casjaysdevdocker/opencv:latest && \
docker run -d \
--restart always \
--name casjaysdevdocker-opencv \
--hostname casjaysdev-opencv \
-e TZ=${TIMEZONE:-America/New_York} \
-v $HOME/.local/share/srv/docker/opencv/files/data:/data:z \
-v $HOME/.local/share/srv/docker/opencv/files/config:/config:z \
-p 80:80 \
casjaysdevdocker/opencv:latest
```

### via docker-compose

```yaml
version: "2"
services:
  opencv:
    image: casjaysdevdocker/opencv
    container_name: opencv
    environment:
      - TZ=America/New_York
      - HOSTNAME=casjaysdev-opencv
    volumes:
      - $HOME/.local/share/srv/docker/opencv/files/data:/data:z
      - $HOME/.local/share/srv/docker/opencv/files/config:/config:z
    ports:
      - 80:80
    restart: always
```

## Authors  

🤖 casjay: [Github](https://github.com/casjay) [Docker](https://hub.docker.com/r/casjay) 🤖  
⛵ CasjaysDevDocker: [Github](https://github.com/casjaysdevdocker) [Docker](https://hub.docker.com/r/casjaysdevdocker) ⛵  
