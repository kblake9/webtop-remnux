

FROM ghcr.io/linuxserver/webtop:ubuntu-xfce


RUN sudo apt update
RUN sudo apt upgrade -y

RUN sudo apt install flatpak -y
RUN flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
RUN flatpak install flathub com.github.micahflee.torbrowser-launcher -y
RUN sudo apt install thunderbird -y
RUN sudo apt install python3-setuptools -y


RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y wget gnupg git && \

    apt-get install ca-certificates && \
    
    wget -nv -O - https://repo.saltproject.io/salt/py3/ubuntu/20.04/amd64/SALT-PROJECT-GPG-PUBKEY-2023.gpg | apt-key add - && \
    echo deb [arch=amd64] https://repo.saltproject.io/salt/py3/ubuntu/20.04/amd64/3007 focal main > /etc/apt/sources.list.d/salt.list && \
    
    apt-get update && \
    apt-get install -y salt-common && \
    wget -nv -P /srv/salt -O - https://github.com/REMnux/salt-states/blob/7bca90541b3b1406db18012da4994e7e5d5faefb/remnux/cloud.sls && \
    salt-call -l info --local state.sls cloud pillar='{"remnux_user": "remnux"}' && \
    rm -rf /srv && \
    rm -rf /var/cache/salt/* && \
    rm -rf /root/.cache/* && \
    unset DEBIAN_FRONTEND

EXPOSE 3000
VOLUME /config
