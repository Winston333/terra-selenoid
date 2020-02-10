#!/bin/bash
sudo apt-get update -y
sudo apt-get remove docker docker-engine docker.io
sudo apt install docker.io -y
sudo usermod -aG docker ${USER}
sudo setfacl -m user:$USER:rw /var/run/docker.sock
curl -s https://aerokube.com/cm/bash | bash \
&& ./cm selenoid start --vnc
./cm selenoid-ui start
