# httpserver

tar cvzf - focal/ | split -b 40m - focal.tar.gz.
cat focal.tar.gz.* | tar xzvf -

tar -czvf name-of-archive.tar.gz /path/to/directory-or-file


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

curl -k -LO https://raw.githubusercontent.com/villajuancho/httpserver/main/nginx/public/k8s/images.tar.gz.aa 

tar -xvf images.tar.gz.aa

# instalar imagenes
chmod -R 777 images
./images/k8s/download.sh
./images/k8s/tag.sh --repo=192.168.88.249:5000
./images/k8s/load.sh --repo=192.168.88.249:5000
./images/kong/download.sh
./images/kong/tag.sh --repo=192.168.88.249:5000
./images/kong/load.sh --repo=192.168.88.249:5000
./images/monitoreo/download.sh --repo=192.168.88.249:5000
./images/monitoreo/tag.sh --repo=192.168.88.249:5000
./images/monitoreo/load.sh --repo=192.168.88.249:5000


# archivos adicionales
mkdir -p $INSTALL_PATH/nexus/nexus-public/install/config
cd $INSTALL_PATH/nexus/nexus-public/install/config
curl -LO https://raw.githubusercontent.com/villajuancho/httpserver/main/nginx/public/k8s/config/configGit.sh && chmod 777 *.sh && ./configGit.sh


# ---------------

# INSTALACION k8S

# GENERAL

INSTALL_PATH=/home/ubuntu
mkdir -p $INSTALL_PATH/install
cd $INSTALL_PATH/install

echo "deb http://192.168.88.249:8099/repository/apt-focal/ focal main" | sudo tee /etc/apt/sources.list.d/nexus.list

curl -LO http://192.168.88.249:8099/install/public.gpg.key
apt-key add public.gpg.key
apt update

apt install -y socat conntrack ebtables ipset ipvsadm
apt install -y gnupg curl
apt install -y crun criu buildah
apt install -y runc conmon
apt install -y jq open-iscsi nfs-common

apt install -y docker-ce

docker version

cat <<EOF | tee /etc/docker/daemon.json
{
  "insecure-registries" : [ "192.168.88.249:5000" ]
}
EOF

systemctl restart docker

docker login 192.168.88.249:5000 -u admin

# INSTALL K8S 1.23.5"
apt install kubeadm=1.23.5-00 kubelet=1.23.5-00 kubectl=1.23.5-00 cri-tools=1.23.0-00 kubernetes-cni=0.8.7-00

# configuracion network"
rm /etc/cni/net.d/*
mkdir -p /etc/cni/net.d

cat <<EOF | tee /etc/cni/net.d/100-bridge.conf
{
    "cniVersion": "0.3.1",
    "type": "bridge",
    "bridge": "cni0",
    "isGateway": true,
    "ipMasq": true,
    "hairpinMode": true,
    "ipam": {
        "type": "host-local",
        "routes": [
            { "dst": "0.0.0.0/0" },
            { "dst": "1100:200::1/24" }
        ],
        "ranges": [
            [{ "subnet": "10.244.0.0/16" }],
            [{ "subnet": "1100:200::/24" }]
        ]
    }
}
EOF

cat <<EOF | tee /etc/cni/net.d/200-loopback.conf
{
    "cniVersion": "0.3.1",
    "type": "loopback"
}
EOF

cat <<EOF | tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

# Ajustes sistema"
sysctl --system
systemctl daemon-reload

free -h
swapoff -a
swapoff -a
sed -i.bak -r 's/(.+ swap .+)/#\1/' /etc/fstab
systemctl mask swap.target
free -h

systemctl enable --now kubelet
systemctl enable --now iscsid
systemctl restart kubelet
systemctl restart iscsid
systemctl status iscsid


kubectl version --client && kubeadm version


# MASTER
curl -LO http://192.168.88.249:8099/install/config/config.yaml
sed -i 's/ip-address/192.168.88.27/' config.yaml
sed -i 's/node-name/k8s-master1/' config.yaml
sed -i "s/docker-repo/192.168.88.249:5000/" config.yaml
sed -i "s/k8sversion/v1.23.5/" config.yaml


kubeadm config images pull --config=$INSTALL_PATH/install/config.yaml
kubeadm init --config=$INSTALL_PATH/install/config.yaml

# add to .profile
export KUBECONFIG=/etc/kubernetes/admin.conf