# httpserver

tar cvzf - focal/ | split -b 40m - focal.tar.gz.
cat focal.tar.gz.* | tar xzvf -


tar cvzf - jammy/ | split -b 40m - jammy.tar.gz.


# CARPETA CON ARCHIVOS DE INSTALACION
INTALL_PATH=/home/ubuntu
mkdir -p $INTALL_PATH/install
cd $INTALL_PATH/install

# DOWNLOAD APT FOCAL
curl -k -LO https://raw.githubusercontent.com/villajuancho/httpserver/main/nginx/public/k8s/apt/focal/focalGit.sh && chmod 777 * && ./focalGit.sh

# INSTALL DOCKER
cd $INTALL_PATH/install/focal
curl -k -LO https://raw.githubusercontent.com/villajuancho/httpserver/main/nginx/public/k8s/config/docker/install.sh && chmod 777 *.sh && ./install.sh