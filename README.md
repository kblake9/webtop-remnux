# webtop-remnux
remnux installed inside of webtop container so you can use remnux UI in your browser

linuxserver.io webtop blog: https://www.linuxserver.io/blog/2021-05-05-meet-webtops-a-linux-desktop-environment-in-your-browser

webtop container: https://hub.docker.com/r/linuxserver/webtop

remnux info: https://remnux.org/

# requirements
- git
- docker
- docker-compose

# How to run
- clone this repo `git clone https://github.com/BoredHackerBlog/webtop-remnux && cd webtop-remnux`
- built new docker container `docker build -t webtop-remnux .` building the container may take about 40 mins to an hour.
- use docker-compose file to run the docker container - modify the file as needed (change the password...) `docker-compose up -d`
- visit http://localhost:3000 to access the webtop

alternatively, if you want the container faster, save the following in a docker-compose.yml file:
```
---
version: "2.1"
services:
  webtop:
    image: ghcr.io/boredhackerblog/webtop-remnux/webtop-remnux:latest
    container_name: webtop-remnux
    privileged: true #optional
    environment:
      - PUID=1000
      - PGID=1000
    volumes:
      - ./data:/config
    ports:
      - 3000:3000
    shm_size: "4gb" #optional
    restart: unless-stopped
```

then run `docker-compose up -d` and visit http://localhost:3000 in your browser.
