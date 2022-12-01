while [ $# -gt 0 ]; do
  case "$1" in
    --user=*)
      user="${1#*=}"
      ;;
    --nexus=*)
      nexus="${1#*=}"
      ;;
    --pass=*)
      pass="${1#*=}"
      ;;
    *)
      printf "***************************\n"
      printf "* Error: Invalid argument. $1 \n"
      printf "***************************\n"
      exit 1
  esac
  shift
done

if [[ $nexus == '' ]];then
  printf "*******************************************************************************\n"
  printf "* Error: Missing --nexus=192.168.88.76:8099 \n"
  printf "*******************************************************************************\n"
  exit 1
fi

if [[ $user == '' ]];then
  printf "*******************************************************************************\n"
  printf "* Error: Missing --user=admin \n"
  printf "*******************************************************************************\n"
  exit 1
fi


if [[ $pass == '' ]];then
  printf "*******************************************************************************\n"
  printf "* Error: Missing --pass=passw0rd \n"
  printf "*******************************************************************************\n"
  exit 1
fi




curl -u "$user:$pass" --upload-file "./calico.tar" "http://$nexus/repository/install/config/calico.tar"
curl -u "$user:$pass" --upload-file "./grafana.tar" "http://$nexus/repository/install/config/grafana.tar"
curl -u "$user:$pass" --upload-file "./k8s.tar" "http://$nexus/repository/install/config/k8s.tar"
curl -u "$user:$pass" --upload-file "./keycloak.tar" "http://$nexus/repository/install/config/keycloak.tar"
curl -u "$user:$pass" --upload-file "./keycloak-docker.tar" "http://$nexus/repository/install/config/keycloak-docker.tar"
curl -u "$user:$pass" --upload-file "./kong.tar" "http://$nexus/repository/install/config/kong.tar"
curl -u "$user:$pass" --upload-file "./prometheus.tar" "http://$nexus/repository/install/config/prometheus.tar"
curl -u "$user:$pass" --upload-file "./kongoidc.tar" "http://$nexus/repository/install/config/kongoidc.tar"
curl -u "$user:$pass" --upload-file "./longhorn.tar" "http://$nexus/repository/install/config/longhorn.tar"
curl -u "$user:$pass" --upload-file "./metrics.tar" "http://$nexus/repository/install/config/metrics.tar"
curl -u "$user:$pass" --upload-file "./logging.tar" "http://$nexus/repository/install/config/logging.tar"
curl -u "$user:$pass" --upload-file "./config.yaml" "http://$nexus/repository/install/config/config.yaml"
curl -u "$user:$pass" --upload-file "./mockapp.tar" "http://$nexus/repository/install/test/mockapp.tar"
curl -u "$user:$pass" --upload-file "./public.gpg.key" "http://$nexus/repository/install/public.gpg.key"
