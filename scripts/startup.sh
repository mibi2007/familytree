#! /bin/bash
apt-get update
apt-get install -y docker.io docker-compose
usermod -aG docker param
systemctl enable docker
systemctl start docker
