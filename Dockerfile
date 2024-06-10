# depending on cpu, ram, & internet speed, this may take 40 mins to an hour

FROM ghcr.io/linuxserver/webtop:ubuntu-xfce

# RUN sudo add-apt-repository --yes ppa:micahflee/ppa
#RUN sudo add-apt-repository ppa:ubuntu-mozilla-security/ppa
RUN sudo apt update
RUN sudo apt upgrade -y
# RUN sudo apt install torbrowser-launcher -y
RUN sudo apt install flatpak -y
RUN flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
RUN flatpak install flathub com.github.micahflee.torbrowser-launcher -y
RUN sudo apt install thunderbird -y
RUN sudo apt install python3-setuptools -y

# copied from remnux docker repo
# copied from remnux docker repo
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y wget gnupg git && \
    # mkdir /etc/apt/keyrings && \
    apt-get install ca-certificates && \
    # sudo curl -fsSL -o /etc/apt/keyrings/salt-archive-keyring-2023.gpg https://repo.saltproject.io/salt/py3/ubuntu/20.04/amd64/SALT-PROJECT-GPG-PUBKEY-2023.gpg | apt-key add - && \
    # echo "deb [signed-by=/etc/apt/keyrings/salt-archive-keyring-2023.gpg arch=amd64] https://repo.saltproject.io/salt/py3/ubuntu/20.04/amd64/3005 focal main" | sudo tee /etc/apt/sources.list.d/salt.list && \
    wget -nv -O - https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest/salt-archive-keyring.gpg | apt-key add - && \
    echo deb [arch=amd64] https://repo.saltproject.io/py3/ubuntu/20.04/amd64/3005 focal main > /etc/apt/sources.list.d/saltstack.list && \
    
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
