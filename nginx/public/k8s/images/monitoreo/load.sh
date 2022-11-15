
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

## prometheus
docker push $repo/prom/alertmanager:v0.24.0
docker push $repo/prom/prometheus:v2.36.0
docker push $repo/grafana/grafana:8.5.5
docker push $repo/k8s.gcr.io/kube-state-metrics/kube-state-metrics:v2.3.0
docker push $repo/prom/node-exporter:v1.3.1

## logging
docker push $repo/fluent/fluent-bit:1.9.2
docker push $repo/grafana/loki:2.5.0 
