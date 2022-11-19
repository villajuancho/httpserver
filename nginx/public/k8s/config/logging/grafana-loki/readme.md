# LOKI INSTALL

kubectl create -f config.yaml
kubectl create -f longhorn-volumen.yaml
kubectl create -f deployment-longhorn.yaml
kubectl create -f service.yaml

kubectl get pod -n monitoring
    