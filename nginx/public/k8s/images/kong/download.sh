

echo "PULL IMAGES"

echo "KONG"
docker pull postgres:9.6
docker pull kong:2.8.1-alpine
docker pull pantsel/konga:0.14.9

echo "KEYCLOAK"
docker pull postgres:13.2
docker pull jboss/keycloak:16.1.0

