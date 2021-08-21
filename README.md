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
- built new docker container `docker build -t webtop-remnux .`
- use docker-compose file to run the docker container - modify the file as needed (change the password...) `docker-compose up -d`
- visit http://localhost:3000 to access the webtop
