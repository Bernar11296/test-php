build:
	docker build ./ -t php_fpm:7.4-test --file Dockerfile
run:
	docker network create -d bridge --subnet=172.20.0.0/16 dockernet -o "com.docker.network.bridge.name"="dockernet"
	docker run -d --name php7.4 --log-driver=journald --restart=unless-stopped --ip=172.20.0.5 --network="dockernet" php_fpm:7.4-test
check:
	curl 172.20.0.5:8080 | grep "PHP Version"