

echo "PULL IMAGES"

echo "PROMETHEUS"
docker pull prom/alertmanager:v0.24.0
docker pull prom/prometheus:v2.36.0
docker pull grafana/grafana:8.5.5
docker pull k8s.gcr.io/kube-state-metrics/kube-state-metrics:v2.3.0
docker pull prom/node-exporter:v1.3.1

echo "FLUENT - LOKI"
docker pull fluent/fluent-bit:1.9.2
docker pull grafana/loki:2.5.0

