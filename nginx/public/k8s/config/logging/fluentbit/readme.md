# fluent bit
- tutorial git
  https://docs.fluentbit.io/manual/installation/kubernetes

# Install

kubectl create namespace logging
kubectl create -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-service-account.yaml
kubectl create -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-role-1.22.yaml
kubectl create -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/fluent-bit-role-binding-1.22.yaml

Editar el siguinete archivo
curl https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/output/elasticsearch/fluent-bit-configmap.yaml -O


Cambiar parse de docker a cri
input-kubernetes.conf: |
    [INPUT]
        Name              tail
        Tag               kube.*
        Path              /var/log/containers/*.log
        Parser            docker
        DB                /var/log/flb_kube.db
        Mem_Buf_Limit     5MB
        Skip_Long_Lines   On
        Refresh_Interval  10

- kubectl create -f fluent-bit-configmap.yaml

- $ kubectl create -f https://raw.githubusercontent.com/fluent/fluent-bit-kubernetes-logging/master/output/elasticsearch/fluent-bit-ds.yaml



-----
# INSTALCION
- recuerde instalar el loki primero


kubectl create -f service-account.yaml
kubectl create -f role-1.22.yaml
kubectl create -f role-binding-1.22.yaml
kubectl create -f configmap-crio.yaml
kubectl create -f deploy.yaml


# LOGGING K*S

https://kubernetes.io/docs/concepts/cluster-administration/logging/