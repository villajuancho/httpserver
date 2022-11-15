# httpserver

tar cvzf - focal/ | split -b 40m - focal.tar.gz.
cat focal.tar.gz.* | tar xzvf -


tar cvzf - jammy/ | split -b 40m - jammy.tar.gz.


curl -k -LO https://raw.githubusercontent.com/villajuancho/httpserver/main/nginx/public/k8s/apt/focal/focalGit.sh && chmod 777 * && ./focalGit.sh

curl -k -LO https://raw.githubusercontent.com/villajuancho/httpserver/main/nginx/public/k8s/apt/focal/focalGit.sh && chmod 777 * && ./focalGit.sh