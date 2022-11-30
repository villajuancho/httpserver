curl -LO https://raw.githubusercontent.com/villajuancho/httpserver/main/nginx/public/k8s/config/calico.tar
curl -LO https://raw.githubusercontent.com/villajuancho/httpserver/main/nginx/public/k8s/config/grafana.tar
curl -LO https://raw.githubusercontent.com/villajuancho/httpserver/main/nginx/public/k8s/config/k8s.tar
curl -LO https://raw.githubusercontent.com/villajuancho/httpserver/main/nginx/public/k8s/config/keycloak.tar
curl -LO https://raw.githubusercontent.com/villajuancho/httpserver/main/nginx/public/k8s/config/keycloak-docker.tar
curl -LO https://raw.githubusercontent.com/villajuancho/httpserver/main/nginx/public/k8s/config/kong.tar
curl -LO https://raw.githubusercontent.com/villajuancho/httpserver/main/nginx/public/k8s/config/prometheus.tar
curl -LO https://raw.githubusercontent.com/villajuancho/httpserver/main/nginx/public/k8s/config/kongoidc.tar
curl -LO https://raw.githubusercontent.com/villajuancho/httpserver/main/nginx/public/k8s/config/longhorn.tar
curl -LO https://raw.githubusercontent.com/villajuancho/httpserver/main/nginx/public/k8s/config/metrics.tar
curl -LO https://raw.githubusercontent.com/villajuancho/httpserver/main/nginx/public/k8s/config/logging.tar
curl -LO https://raw.githubusercontent.com/villajuancho/httpserver/main/nginx/public/k8s/config/config.yaml
curl -LO https://raw.githubusercontent.com/villajuancho/httpserver/main/nginx/public/k8s/mockapp.tar
curl -LO https://raw.githubusercontent.com/villajuancho/httpserver/main/nginx/public/k8s/uploadfiles.sh

curl -u "admin:passw0rd" --upload-file "https://raw.githubusercontent.com/villajuancho/httpserver/main/nginx/public/k8s/config/config.yaml" "http://192.168.88.249:8099/repository/raw1/config/config.yaml"




curl -LO https://raw.githubusercontent.com/villajuancho/httpserver/main/nginx/public/k8s/config/config.yaml



curl -u "admin:passw0rd" -H "Content-Type: multipart/form-data" --data-binary "@./containerd.io_1.6.6-1_amd64.deb" "http://$NEXUSAPT/repository/apt-focal/"

curl -u "admin:passw0rd" -H "Content-Type: multipart/form-data" --data-binary "@./mockapp.tar" "http://192.168.88.249:8099/repository/raw1/config/config.yaml"

curl -u "admin:passw0rd" -o "https://raw.githubusercontent.com/villajuancho/httpserver/main/nginx/public/k8s/config/config.yaml" "http://192.168.88.249:8099/repository/raw1/config/config.yaml"


curl -v -u "admin:passw0rd" --upload-file "https://raw.githubusercontent.com/villajuancho/httpserver/main/nginx/public/k8s/config/config.yaml" "http://192.168.88.249:8099/repository/raw1/config/config.yaml"
