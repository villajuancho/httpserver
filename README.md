# httpserver

tar cvzf - focal/ | split -b 40m - focal.tar.gz.
cat focal.tar.gz.* | tar xzvf -


tar cvzf - jammy/ | split -b 40m - jammy.tar.gz.


# CARPETA CON ARCHIVOS DE INSTALACION
INSTALL_PATH=/home/ubuntu
mkdir -p $INSTALL_PATH/install
cd $INSTALL_PATH/install

# DOWNLOAD APT FOCAL
curl -k -LO https://raw.githubusercontent.com/villajuancho/httpserver/main/nginx/public/k8s/apt/focal/focalGit.sh && chmod 777 * && ./focalGit.sh

# INSTALL DOCKER
cd $INSTALL_PATH/install/focal
curl -k -LO https://raw.githubusercontent.com/villajuancho/httpserver/main/nginx/public/k8s/config/docker/install.sh && chmod 777 *.sh && ./install.sh


# INSTALL NEXUS
mkdir -p $INSTALL_PATH/nexus/nexus-data
mkdir -p $INSTALL_PATH/nexus/nexus-public/install
mkdir -p $INSTALL_PATH/install/nexus
cd $INSTALL_PATH/install/nexus

curl -k -LO https://raw.githubusercontent.com/villajuancho/httpserver/main/nginx/public/k8s/config/nexus/docker-compose.yaml

docker compose up -d

