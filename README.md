# httpserver

tar cvzf - focal/ | split -b 40m - focal.tar.gz.
cat focal.tar.gz.* | tar xzvf -


tar cvzf - jammy/ | split -b 40m - jammy.tar.gz.
