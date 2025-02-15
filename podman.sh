#!/bin/bash
user=$(logname)
apt-get update &&
  apt-get upgrade -y

apt-get install ca-certificates curl software-properties-common -y
apt-get install podman podman-compose -y


##########

apt-get install curl gnupg2 ca-certificates lsb-release ubuntu-keyring -y

curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor |
  tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null

gpg --dry-run --quiet --no-keyring --import --import-options import-show /usr/share/keyrings/nginx-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
http://nginx.org/packages/ubuntu $(lsb_release -cs) nginx" |
  tee /etc/apt/sources.list.d/nginx.list

echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" |
  tee /etc/apt/preferences.d/99nginx

apt-get update && apt-get upgrade -y
apt-get install nginx -y

##########

snap install --classic certbot

ln -s /snap/bin/certbot /usr/bin/certbot

reboot
