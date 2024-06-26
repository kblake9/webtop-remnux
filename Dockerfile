

FROM ghcr.io/linuxserver/webtop:ubuntu-xfce


RUN sudo apt update
RUN sudo apt upgrade -y

RUN sudo apt install flatpak -y
RUN flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
RUN flatpak install flathub com.github.micahflee.torbrowser-launcher -y
RUN sudo apt install thunderbird -y
RUN sudo apt install python3-setuptools -y


# copied from remnux docker repo
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y wget gnupg git && \
    wget -nv -O - https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest/salt-archive-keyring.gpg | apt-key add - && \
    echo deb [arch=amd64] https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest focal main > /etc/apt/sources.list.d/saltstack.list && \
    apt-get update && \
    apt-get install -y salt-common && \
    git clone https://github.com/REMnux/salt-states.git /srv/salt && \
    salt-call -l info --local state.sls remnux.cloud pillar='{"remnux_user": "remnux"}' && \
    rm -rf /srv && \
    rm -rf /var/cache/salt/* && \
    rm -rf /root/.cache/* && \
    unset DEBIAN_FRONTEND
EXPOSE 3000
VOLUME /config
