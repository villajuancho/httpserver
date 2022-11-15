



# PRE - INSTALACION

En nexus activar Anonimous access en security.

nano .profile

export NEXUSDOCKER="10.0.30.5:5000"
export NEXUSAPT="10.0.30.5:8081"

cp /etc/apt/sources.list /etc/apt/sources.list.cp

cat <<EOF | tee /etc/apt/sources.list
deb http://$NEXUSAPT/repository/apt-focal/ focal main
EOF

nano public.gpg.key

apt-key add public.gpg.key

apt update

# INSTALACION
hostnamectl set-hostname "new-hostname"


apt install -y socat conntrack ebtables ipset ipvsadm

apt install -y gnupg curl
apt install -y crun criu buildah
apt install -y runc conmon

apt install -y cri-o cri-o-runc cri-tools

(verificar instalación)
apt-cache policy cri-o



cat <<EOF | tee /etc/crio/crio.conf
[crio.runtime]
cgroup_manager = "systemd"
[crio.image]
default_transport = "docker://"
pause_image = "$NEXUSDOCKER/k8s.gcr.io/pause:3.7"
pause_command = "/usr/bin/pod"
signature_policy = ""
image_volumes = "mkdir"
insecure_registries = [
"$NEXUSDOCKER"
]
registries = [
"docker.io"
]
EOF

sed -i 's/10.85.0.0/10.244.0.0/g' /etc/cni/net.d/100-crio-bridge.conf

rm /etc/cni/net.d/*

cat <<EOF | tee /etc/cni/net.d/100-crio-bridge.conf
{
    "cniVersion": "0.3.1",
    "name": "crio",
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

cat <<EOF | tee /etc/modules-load.d/crio.conf
overlay
br_netfilter
EOF

modprobe overlay

modprobe br_netfilter

apt install -y jq open-iscsi nfs-common

sysctl --system

systemctl daemon-reload

free -h
swapoff -a
swapoff -a
sed -i.bak -r 's/(.+ swap .+)/#\1/' /etc/fstab
systemctl mask swap.target
free -h

## Installing kubeadm, kubelet and kubectl (cluster kubernetes)

mkdir -p /opt/cni/bin
curl -LO http://$NEXUSAPT/tarfiles/cni-plugins-linux-amd64-v0.8.2.tgz
tar -xzf cni-plugins-linux-amd64-v0.8.2.tgz -C /opt/cni/bin

//curl -LO http://$NEXUSAPT/tarfiles/crictl-v1.24.0-linux-amd64.tar.gz

curl -LO http://$NEXUSAPT/tarfiles/k8s-v1.24.0-linux-amd64.tar.gz  
tar -xzf k8s-v1.24.0-linux-amd64.tar.gz -C /usr/bin
chmod +x /usr/bin/kube*


curl -LO http://$NEXUSAPT/tarfiles/kubelet.service
cp kubelet.service /etc/systemd/system/kubelet.service
chmod 777 /etc/systemd/system/kubelet.service
mkdir -p /etc/systemd/system/kubelet.service.d

curl -LO http://$NEXUSAPT/tarfiles/10-kubeadm.conf
cp 10-kubeadm.conf /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

systemctl enable --now kubelet


kubectl version --client && kubeadm version


## nerdctl
curl -LO http://$NEXUSAPT/tarfiles/nerdctl-0.20.0-linux-amd64.tar.gz
tar Cxzvvf /usr/local/bin nerdctl-0.20.0-linux-amd64.tar.gz





shutdown -r now

systemctl stop crio
systemctl start crio
systemctl status crio
systemctl enable crio

systemctl stop iscsid
systemctl start iscsid
systemctl status iscsid
systemctl restart iscsid
systemctl enable iscsid

systemctl status kubelet






# download images

sed -i 's/ip-address/10.0.15.199/' config.yaml
sed -i 's/node-name/ip-10-0-15-199/' config.yaml
sed -i "s/docker-repo/$NEXUSDOCKER/" config.yaml

kubeadm config images pull --config=/app/k8s/config.yaml
kubeadm init --config=/app/k8s/config.yaml


SET TAINT MASTER
kubectl taint node cys-master-01 node-role.kubernetes.io/master=:NoSchedule --overwrite
kubectl label node cys-master-01 node-role.kubernetes.io/master=



# ADD WORKER
kubeadm token create --print-join-command

kubeadm join 10.0.5.25:6443 --cri-socket=unix:///var/run/crio/crio.sock --token wdj5t5.7k95zktiw3dlwlrn --discovery-token-ca-cert-hash sha256:950a3cfd200157c981dcff2f11c0328df345a33f5120e2b1c2d9304cf0861309 




# INSTALL CALICO
copiar tigera-operator.yaml
copiar custom-resources.yaml
sed -i 's/docker.io/xx.xx.xx.xx:5000/' tigera-operator.yaml
kubectl apply -f tigera-operator.yaml

cat <<EOF | tee custom-resources.yaml
# This section includes base Calico installation configuration.
# For more information, see: https://projectcalico.docs.tigera.io/v3.23/reference/installation/api#operator.tigera.io/v1.Installation
apiVersion: operator.tigera.io/v1
kind: Installation
metadata:
  name: default
spec:
  registry: docker.io
  # Configures Calico networking.
  calicoNetwork:
    # Note: The ipPools section cannot be modified post-install.
    bgp: Disabled
    ipPools:
    - blockSize: 26
      cidr: 10.244.0.0/16
      natOutgoing: Enabled
      encapsulation: VXLAN
      nodeSelector: all()
---
# This section configures the Calico API server.
# For more information, see: https://projectcalico.docs.tigera.io/v3.23/reference/installation/api#operator.tigera.io/v1.APIServer
apiVersion: operator.tigera.io/v1
kind: APIServer 
metadata: 
  name: default 
spec: {}
EOF



# INSTALL longhorn
copiar longhorn.yaml
cambiar el numberOfReplicas: "2" de ser necesario
sed -i 's/longhornio/xx.xx.xx.xx:5000\/longhornio/' longhorn.yaml
sed -i 's/longhornio/10.0.30.5:5000\/longhornio/' longhorn.yaml
kubectl apply -f longhorn.yaml


# INSTALL metrics
copiar metrics.yaml
sed -i 's/k8s.gcr.io/xx.xx.xx.xx:5000\/k8s.gcr.io/' metrics.yaml
sed -i 's/k8s.gcr.io/10.0.30.5:5000\/k8s.gcr.io/' metrics.yaml
kubectl apply -f metrics.yaml



# INSTALL prometheus
curl -LO http://$NEXUSAPT/tarfiles/prometheus.tar
tar -xvf prometheus.tar
sed -i 's/nexus/xx.xx.xx.xx:5000/' *.yaml
sed -i 's/nexus/10.0.30.5:5000/' *.yaml
sed -i 's/nexus/10.0.30.5:5000/' alert-manager/*.yaml
sed -i 's/nexus/10.0.30.5:5000/' base/*.yaml
sed -i 's/nexus/10.0.30.5:5000/' grafana/*.yaml
sed -i 's/nexus/10.0.30.5:5000/' metrics/*.yaml
sed -i 's/nexus/10.0.30.5:5000/' node-exporter/*.yaml

## base
kubectl create -f base/namespace.yaml
kubectl create -f base/clusterRole.yaml
kubectl create -f base/config-map.yaml
kubectl create -f base/prometheus-service.yaml

Sin filesystem
kubectl create  -f base/prometheus-deployment.yaml 

Con longhorn filesystem
kubectl create  -f base/deploy-longhorn.yaml



kubectl get deployments --namespace=monitoring
kubectl get pod --namespace=monitoring -w

ui - http://<node>:31500

## metrics
kubectl apply -f metrics/

kubectl get deployments kube-state-metrics -n kube-system
kubectl get pod --namespace=kube-system -w

## Alerts
https://prometheus.io/docs/alerting/configuration/#%3Creceiver%3E

kubectl create -f alert-manager/alert-manager-config-map.yaml
kubectl create -f alert-manager/alert-template-config-map.yaml
kubectl create -f alert-manager/deployment.yaml
kubectl create -f alert-manager/service.yaml

kubectl get deployments --namespace=monitoring
kubectl get pod --namespace=monitoring -w

ui - http://<node>:31501

## node-exporter
kubectl create -f node-exporter/daemonset.yaml
kubectl get daemonset -n monitoring

kubectl create -f node-exporter/service.yaml
kubectl get endpoints -n monitoring 

kubectl get pod --namespace=monitoring -w

## grafana
kubectl create -f grafana/grafana-datasource-config.yaml
kubectl create -f grafana/service.yaml


Sin filesystem
kubectl create -f grafana/deployment.yaml

Con longhorn filesystem
kubectl create  -f grafana/longhorn-volumen.yaml
kubectl create -f grafana/deployment-longhorn.yaml

** kubectl delete -f grafana/deployment-longhorn.yaml

kubectl get deployments --namespace=monitoring
kubectl get pod --namespace=monitoring -w

ui - http://<node>:31502

Default credentials
User: admin
Pass: admin
Luego pide cambiarlas


# INSTALL loki
curl -LO http://$NEXUSAPT/tarfiles/logging.tar
tar -xvf logging.tar

sed -i 's/image: /image: 10.0.30.5:5000\//' fluentbit/*.yaml
sed -i 's/image: /image: 10.0.30.5:5000\//' grafana-loki/*.yaml


## loki
kubectl create -f grafana-loki/config.yaml
kubectl create -f grafana-loki/longhorn-volumen.yaml
kubectl create -f grafana-loki/deployment-longhorn.yaml
kubectl create -f grafana-loki/service.yaml

kubectl get pod -n monitoring

## fluentbit

kubectl create -f fluentbit/service-account.yaml
kubectl create -f fluentbit/role-1.22.yaml
kubectl create -f fluentbit/role-binding-1.22.yaml
kubectl create -f fluentbit/configmap-crio.yaml
kubectl create -f fluentbit/deploy.yaml

kubectl get pod -n monitoring


