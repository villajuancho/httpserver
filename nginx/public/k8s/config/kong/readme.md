

# INSTALACION K8S

# PRE
kubectl get nodes --show-labels
kubectl label nodes ip-10-31-1-30 kongtype=interno
kubectl label nodes ip-10-31-2-30 kongtype=interno

kubectl label nodes ip-10-31-1-20 kongtype=canales
kubectl label nodes ip-10-31-2-20 kongtype=canales


# entrada
sed -i 's/nexus/10.21.1.30:5002/' *.yaml

kubectl create namespace kong-entrada

sed -i 's/kong-namespace/kong-entrada/' *.yaml

sed -i 's/selectkey/kubernetes.io\/hostname/' *.yaml
sed -i 's/selectvalue/clwkkg01/' *.yaml

# salida
sed -i 's/nexus/10.21.1.30:5002/' *.yaml

kubectl create namespace kong-salida

sed -i 's/kong-namespace/kong-salida/' *.yaml

sed -i 's/selectkey/kubernetes.io\/hostname/' *.yaml
sed -i 's/selectvalue/clwkgap01/' *.yaml



# interno
sed -i 's/nexus/10.21.1.30:5002/' *.yaml

kubectl create namespace kong-interno

sed -i 's/kong-namespace/kong-interno/' *.yaml

sed -i 's/selectkey/kongtype/' *.yaml
sed -i 's/selectvalue/interno/' *.yaml

# canales
sed -i 's/nexus/10.21.1.30:5002/' *.yaml

kubectl create namespace kong-canales

sed -i 's/kong-namespace/kong-canales/' *.yaml

sed -i 's/selectkey/kongtype/' *.yaml
sed -i 's/selectvalue/canales/' *.yaml






kubectl apply -f kong-db-pvc.yaml
## kubectl apply -f database.yaml
kubectl apply -f databaseAffinity.yaml

kubectl apply -f prepare.yaml
kubectl -n kong-entrada exec -it prepare-kong -- kong migrations bootstrap
kubectl delete -f prepare.yaml

kubectl apply -f deployAffinity.yaml
## cambiar puerto
kubectl apply -f service.yaml

kubectl apply -f konga-pvc.yaml
## kubectl apply -f konga.yaml
kubectl apply -f kongaAffinity.yaml

## cambiar puerto
kubectl apply -f konga-service.yaml

