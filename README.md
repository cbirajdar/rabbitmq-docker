## Local rabbitmq cluster set-up using Docker

### Build

- ```git clone git@github.com:cbirajdar/rabbitmq-docker.git```
- Run ```docker build -t cbirajdar/rabbitmq .``` in the root directory
  - If you don't have docker installed, follow the guide here - https://docs.docker.com/engine/installation/
- Make sure that the docker image is built successfully
  - Run ```docker images``` to verify that the built images shows up in the local repository

### Run

You can run the cluster in two ways:
- Using docker-compose
  - ```cd cluster && docker-compose up -d```
- Using docker run
  - ```docker run -p 5672:5672 -p 15672:15672 --hostname rabbitmq1 --name rabbitmq1 cbirajdar/rabbitmq```
  - ```docker run -p 5673:5672 -p 15673:15672 --hostname rabbitmq2 --name rabbitmq2 --link rabbitmq1 cbirajdar/rabbitmq```
  - ```docker run -p 5674:5672 -p 15674:15672 --hostname rabbitmq3 --name rabbitmq3 --link rabbitmq1 --link rabbitmq2 cbirajdar/rabbitmq```

### Verify

Visit the following links in the browser to make sure rabbitmq admin console is running.

- http://192.168.99.101:15672/
- http://192.168.99.101:15673/
- http://192.168.99.101:15674/


### Running simple tests against the cluster
- https://github.com/cbirajdar/messaging-providers-benchmark

### Stop and Destroy nodes

- Stop and rm containers (Note: these will mo)
  - ```docker stop $(docker ps -f "name=rabbitmq*" -a -q)```
  - ```docker rm $(docker ps -f "name=rabbitmq*" -a -q)```
- Remove docker image
  - ```docker rmi $(IMAGE_ID)```
