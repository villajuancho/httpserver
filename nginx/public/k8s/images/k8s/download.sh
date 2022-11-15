

echo "PULL IMAGES"
echo "Nexus"
docker pull sonatype/nexus3:3.38.1

echo "K8S-1.24"
docker pull docker.io/coredns/coredns:1.8.6
docker pull k8s.gcr.io/etcd:3.5.3-0
docker pull k8s.gcr.io/kube-apiserver:v1.24.0 
docker pull k8s.gcr.io/kube-controller-manager:v1.24.0
docker pull k8s.gcr.io/kube-proxy:v1.24.0
docker pull k8s.gcr.io/kube-scheduler:v1.24.0
docker pull k8s.gcr.io/pause:3.7
docker pull k8s.gcr.io/metrics-server/metrics-server:v0.6.1

echo "K8S-1.23.5"
docker pull docker.io/coredns/coredns:1.8.6
docker pull k8s.gcr.io/etcd:3.5.1-0
docker pull k8s.gcr.io/kube-apiserver:v1.23.5
docker pull k8s.gcr.io/kube-controller-manager:v1.23.5
docker pull k8s.gcr.io/kube-proxy:v1.23.5
docker pull k8s.gcr.io/kube-scheduler:v1.23.5
docker pull k8s.gcr.io/pause:3.6
docker pull k8s.gcr.io/metrics-server/metrics-server:v0.6.1

echo "CALICO"
docker pull quay.io/tigera/operator:v1.27.1
docker pull calico/typha:v3.23.1
docker pull calico/ctl:v3.23.1
docker pull calico/node:v3.23.1
docker pull calico/cni:v3.23.1
docker pull calico/apiserver:v3.23.1
docker pull calico/kube-controllers:v3.23.1
docker pull calico/dikastes:v3.23.1
docker pull calico/pod2daemon-flexvol:v3.23.1
docker pull calico/csi:v3.23.1

echo "LONGHORN"
docker pull longhornio/csi-attacher:v3.4.0
docker pull longhornio/csi-provisioner:v2.1.2
docker pull longhornio/csi-resizer:v1.2.0
docker pull longhornio/csi-snapshotter:v3.0.3
docker pull longhornio/csi-node-driver-registrar:v2.5.0

docker pull longhornio/backing-image-manager:v3_20220609
docker pull longhornio/longhorn-engine:v1.3.0
docker pull longhornio/longhorn-instance-manager:v1_20220611
docker pull longhornio/longhorn-manager:v1.3.0
docker pull longhornio/longhorn-share-manager:v1_20220531
docker pull longhornio/longhorn-ui:v1.3.0


