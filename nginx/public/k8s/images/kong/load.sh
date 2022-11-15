
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


## kong
docker push $repo/postgres:9.6
docker push $repo/kong:2.8.1-alpine
docker push $repo/pantsel/konga:0.14.9

## keycloak
docker push $repo/postgres:13.2
docker push $repo/jboss/keycloak:16.1.0
