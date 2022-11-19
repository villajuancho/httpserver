# Instalacion en docker 
docker pull grafana/grafana:8.5.3

/var/lib/grafana 

grafana/grafana:8.5.3

pot 3000


docker run -it -d -v /data/grafana:/var/lib/grafana -p 32100:3000 --name grafana grafana/grafana:8.5.3