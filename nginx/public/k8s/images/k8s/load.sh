
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


# PUSH IMAGES
docker push $repo/sonatype/nexus3:3.38.1

#coredns
docker push $repo/k8s.gcr.io/coredns:v1.8.6

#metric server
docker push $repo/k8s.gcr.io/metrics-server/metrics-server:v0.6.1

#k8s 1.24
docker push $repo/k8s.gcr.io/etcd:3.5.3-0
docker push $repo/k8s.gcr.io/kube-apiserver:v1.24.0
docker push $repo/k8s.gcr.io/kube-controller-manager:v1.24.0
docker push $repo/k8s.gcr.io/kube-proxy:v1.24.0
docker push $repo/k8s.gcr.io/kube-scheduler:v1.24.0
docker push $repo/k8s.gcr.io/pause:3.7

#k8s 1.23.5
docker push $repo/k8s.gcr.io/etcd:3.5.1-0
docker push $repo/k8s.gcr.io/kube-apiserver:v1.23.5
docker push $repo/k8s.gcr.io/kube-controller-manager:v1.23.5
docker push $repo/k8s.gcr.io/kube-proxy:v1.23.5
docker push $repo/k8s.gcr.io/kube-scheduler:v1.23.5
docker push $repo/k8s.gcr.io/pause:3.6


## calico
docker push $repo/quay.io/tigera/operator:v1.27.1
docker push $repo/calico/typha:v3.23.1
docker push $repo/calico/ctl:v3.23.1
docker push $repo/calico/node:v3.23.1
docker push $repo/calico/cni:v3.23.1
docker push $repo/calico/apiserver:v3.23.1 
docker push $repo/calico/kube-controllers:v3.23.1
docker push $repo/calico/dikastes:v3.23.1
docker push $repo/calico/pod2daemon-flexvol:v3.23.1
docker push $repo/calico/csi:v3.23.1

## longhorn
docker push $repo/longhornio/csi-attacher:v3.4.0
docker push $repo/longhornio/csi-provisioner:v2.1.2
docker push $repo/longhornio/csi-resizer:v1.2.0
docker push $repo/longhornio/csi-snapshotter:v3.0.3
docker push $repo/longhornio/csi-node-driver-registrar:v2.5.0
docker push $repo/longhornio/backing-image-manager:v3_20220609 
docker push $repo/longhornio/longhorn-engine:v1.3.0
docker push $repo/longhornio/longhorn-instance-manager:v1_20220611
docker push $repo/longhornio/longhorn-manager:v1.3.0
docker push $repo/longhornio/longhorn-share-manager:v1_20220531
docker push $repo/longhornio/longhorn-ui:v1.3.0

