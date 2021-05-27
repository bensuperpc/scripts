sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable docker
docker pull ubuntu:16.04
docker pull ubuntu:18.04
docker pull ubuntu:20.04
docker pull ubuntu:20.10
docker pull ubuntu:latest
docker pull gcc:latest
docker pull tensorflow/tensorflow:latest
docker pull alpine:latest
docker pull python:latest
