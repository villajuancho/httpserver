

# INSTALACION K8S

docker build -t kongoidc:latest .

docker tag kongoidc:latest 10.21.1.30:5002/kongoidc:latest

docker push 10.21.1.30:5002/kongoidc:latest

