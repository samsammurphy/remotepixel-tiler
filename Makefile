
SHELL = /bin/bash

wheel:
	docker build -f Dockerfiles/wheel --tag lambda:latest .
	docker run -w /var/task/ --name lambda -itd lambda:latest
	docker cp lambda:/tmp/package.zip wheel.zip
	docker stop lambda
	docker rm lambda

custom:
	docker build -f Dockerfiles/custom --tag lambda:latest .
	docker run -w /var/task/ --name lambda -itd lambda:latest
	docker cp lambda:/tmp/package.zip custom.zip
	docker stop lambda
	docker rm lambda

deploy:
	sls deploy --sat cbers --stage test	
	sls deploy --sat landsat --stage test
	sls deploy --sat sentinel --stage test

clean:
	docker stop lambda
	docker rm lambda
