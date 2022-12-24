
tar cvzf - clean.tar | split -b 40m - cleanp.tar.gz.




docker build -t clean:latest .
docker tag clean:latest 192.168.88.249:5000/clean:latest
docker push 192.168.88.249:5000/clean:latest


cat cleanp.tar.gz.* | tar xzvf -
docker load < clean.tar


cat <<EOF | tee /etc/cron.d/otro
* * * * * root echo "Prueba 2" >> /var/log/cron.log 2>&1
# Don't remove the empty line at the end of this file. It is required to run the cron job
EOF