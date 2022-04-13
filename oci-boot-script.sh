#!/bin/bash
sudo apt update
sudo apt -y upgrade

sudo timedatectl set-timezone Asia/Seoul

sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo echo '/swapfile swap swap defaults 0 0' | sudo tee -a /etc/fstab

sudo ufw allow 21
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 443
sudo ufw allow 8000
sudo ufw allow 9443
yes | sudo ufw enable
sudo systemctl enable ufw.service
sudo ufw restart
sudo ufw status

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

sudo mkdir -p /data/npm
sudo docker run -d -p 80:80 -p 443:443 -p 81:81 --name npm --restart=unless-stopped -v /data:/data -v /letsencrypt:/etc/letsencrypt jc21/nginx-proxy-manager:latest

sudo mkdir -p /data/portainer
sudo docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

sudo docker network create npm-net
sudo docker network connect npm-net npm
sudo docker network connect npm-net portainer

ip="$(curl --silent icanhazip.com)"
echo ""
echo ""
echo "===== oci boot script ====="
echo ""
echo "부트 스크립트 설정이 완료되었습니다."
echo ""
echo "- Nginx Proxy Manager"
echo "외부 아이피 http://$ip:81"
echo "내부 아이피 http://"
echo "Email: admin@example.com"
echo "Password: changeme"
echo ""
echo "3. portainer 접속하여 도커 설정"
echo "http://$ip:8000"
echo ""