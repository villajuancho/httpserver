
while [ $# -gt 0 ]; do
  case "$1" in
    --repo=*)
      repo="${1#*=}"
      ;;
    *)
      printf "***************************\n"
      printf "* Error: Invalid argument. $1 \n"
      printf "***************************\n"
      exit 1
  esac
  shift
done

if [[ $repo == '' ]];then
  printf "*******************************************************************************\n"
  printf "* Error: Missing --repo=192.168.88.76:5000 \n"
  printf "*******************************************************************************\n"
  exit 1
fi


# TAG IMAGES 
docker tag sonatype/nexus3:3.38.1 $repo/sonatype/nexus3:3.38.1

# coredns
docker tag docker.io/coredns/coredns:1.8.6 $repo/k8s.gcr.io/coredns:v1.8.6


#  K8S 1.24
docker tag k8s.gcr.io/etcd:3.5.3-0 $repo/k8s.gcr.io/etcd:3.5.3-0
docker tag k8s.gcr.io/kube-apiserver:v1.24.0  $repo/k8s.gcr.io/kube-apiserver:v1.24.0
docker tag k8s.gcr.io/kube-controller-manager:v1.24.0 $repo/k8s.gcr.io/kube-controller-manager:v1.24.0
docker tag k8s.gcr.io/kube-proxy:v1.24.0 $repo/k8s.gcr.io/kube-proxy:v1.24.0
docker tag k8s.gcr.io/kube-scheduler:v1.24.0 $repo/k8s.gcr.io/kube-scheduler:v1.24.0
docker tag k8s.gcr.io/pause:3.7 $repo/k8s.gcr.io/pause:3.7

#  K8S 1.23.5
docker tag k8s.gcr.io/etcd:3.5.1-0 $repo/k8s.gcr.io/etcd:3.5.1-0
docker tag k8s.gcr.io/kube-apiserver:v1.23.5  $repo/k8s.gcr.io/kube-apiserver:v1.23.5
docker tag k8s.gcr.io/kube-controller-manager:v1.23.5 $repo/k8s.gcr.io/kube-controller-manager:v1.23.5
docker tag k8s.gcr.io/kube-proxy:v1.23.5 $repo/k8s.gcr.io/kube-proxy:v1.23.5
docker tag k8s.gcr.io/kube-scheduler:v1.23.5 $repo/k8s.gcr.io/kube-scheduler:v1.23.5
docker tag k8s.gcr.io/pause:3.6 $repo/k8s.gcr.io/pause:3.6


# metric server
docker tag k8s.gcr.io/metrics-server/metrics-server:v0.6.1 $repo/k8s.gcr.io/metrics-server/metrics-server:v0.6.1


## calico
docker tag quay.io/tigera/operator:v1.27.1 $repo/quay.io/tigera/operator:v1.27.1
docker tag calico/typha:v3.23.1 $repo/calico/typha:v3.23.1
docker tag calico/ctl:v3.23.1 $repo/calico/ctl:v3.23.1
docker tag calico/node:v3.23.1 $repo/calico/node:v3.23.1
docker tag calico/cni:v3.23.1 $repo/calico/cni:v3.23.1
docker tag calico/apiserver:v3.23.1 $repo/calico/apiserver:v3.23.1 
docker tag calico/kube-controllers:v3.23.1 $repo/calico/kube-controllers:v3.23.1
docker tag calico/dikastes:v3.23.1 $repo/calico/dikastes:v3.23.1
docker tag calico/pod2daemon-flexvol:v3.23.1 $repo/calico/pod2daemon-flexvol:v3.23.1
docker tag calico/csi:v3.23.1 $repo/calico/csi:v3.23.1

## longhorn
docker tag longhornio/csi-attacher:v3.4.0 $repo/longhornio/csi-attacher:v3.4.0
docker tag longhornio/csi-provisioner:v2.1.2 $repo/longhornio/csi-provisioner:v2.1.2
docker tag longhornio/csi-resizer:v1.2.0 $repo/longhornio/csi-resizer:v1.2.0
docker tag longhornio/csi-snapshotter:v3.0.3 $repo/longhornio/csi-snapshotter:v3.0.3
docker tag longhornio/csi-node-driver-registrar:v2.5.0 $repo/longhornio/csi-node-driver-registrar:v2.5.0
docker tag longhornio/backing-image-manager:v3_20220609 $repo/longhornio/backing-image-manager:v3_20220609 
docker tag longhornio/longhorn-engine:v1.3.0 $repo/longhornio/longhorn-engine:v1.3.0
docker tag longhornio/longhorn-instance-manager:v1_20220611 $repo/longhornio/longhorn-instance-manager:v1_20220611
docker tag longhornio/longhorn-manager:v1.3.0 $repo/longhornio/longhorn-manager:v1.3.0
docker tag longhornio/longhorn-share-manager:v1_20220531 $repo/longhornio/longhorn-share-manager:v1_20220531
docker tag longhornio/longhorn-ui:v1.3.0 $repo/longhornio/longhorn-ui:v1.3.0

