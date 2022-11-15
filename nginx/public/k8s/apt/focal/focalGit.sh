curl -k -LO https://raw.githubusercontent.com/villajuancho/httpserver/main/nginx/public/k8s/apt/focal/focal.tar.gz.aa
curl -k -LO https://raw.githubusercontent.com/villajuancho/httpserver/main/nginx/public/k8s/apt/focal/focal.tar.gz.ab
curl -k -LO https://raw.githubusercontent.com/villajuancho/httpserver/main/nginx/public/k8s/apt/focal/focal.tar.gz.ac
curl -k -LO https://raw.githubusercontent.com/villajuancho/httpserver/main/nginx/public/k8s/apt/focal/focal.tar.gz.ad
cat focal.tar.gz.* | tar xzvf -
rm -f focal.tar.*