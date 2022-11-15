# coc keycloak
## INI
kubectl get nodes --show-labels
kubectl label nodes ip-10-31-1-50 keycloak=true
kubectl label nodes ip-10-31-1-51 keycloak=true
kubectl label nodes ip-10-31-2-50 keycloak=true

# credentials
./credentials.sh --dbPass=passw0rd --adminPass=passw0rd --namespace=keycloak


# repo y affinity
sed -i 's/nexus/10.21.1.30:5002/' *.yaml
sed -i 's/keycloak-namespace/keycloak/' *.yaml
sed -i 's/selectkey/keycloak/' *.yaml
sed -i 's/selectvalue/true/' *.yaml


# pslq
kubectl apply -f postgresql-volumen.yaml
kubectl apply -f postgresql.yaml

# keycloak
kubectl apply -f keycloak-volumen.yaml
kubectl apply -f keycloak.yaml
kubectl apply -f keycloak-service.yaml
