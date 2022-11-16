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
chmod -R 777 $INSTALL_PATH/nexus
mkdir -p $INSTALL_PATH/install/nexus
cd $INSTALL_PATH/install/nexus

curl https://raw.githubusercontent.com/villajuancho/httpserver/main/nginx/public/k8s/config/nexus/docker-compose.yaml | sed "s#<path>#$INSTALL_PATH#g" > docker-compose.yaml

docker compose up -d

docker logs -f nexus-nexus-1

docker exec nexus-nexus-1 cat /nexus-data/admin.password 

ingresar a nexus y crear los space apt-space y docker-space

# certificados apt
gpg --gen-key

passphase: ad1jhasydfhcfk
# export certificados apt
gpg --list-keys
gpg --armor --output public.gpg.key --export 961F00589BFACD44CCC7A9D0AFFC2AF782230775

gpg --armor --output private.gpg.key --export-secret-key
961F00589BFACD44CCC7A9D0AFFC2AF782230775

cp public.gpg.key $INSTALL_PATH/nexus/nexus-public/install

# crear repo apt-focal

# install archivos deb
cd $INSTALL_PATH/install/focal
chmod 777 *.sh
./run.sh --nexusapt=192.168.88.249:8099 --user=admin --pass=passw0rd 


# crear repo docker-repo
- configurar el docker token realm

# add repo
cat <<EOF | tee /etc/docker/daemon.json
{
  "insecure-registries" : ["192.168.88.249:5000"]
}
EOF

systemctl restart docker

docker login -u admin -p passw0rd http://192.168.88.249:5000

# bajar archivos imagenes
cd $INSTALL_PATH/install

tar -xvf images.tar.gz.aa

