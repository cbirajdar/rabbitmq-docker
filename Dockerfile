FROM centos

MAINTAINER Chetan Birajdar <birajdar.chetan@gmail.com>

# Install erlang and other packages
RUN yum -y install https://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-6.noarch.rpm

# Install latest rabbitmq server
RUN yum -y install http://www.rabbitmq.com/releases/rabbitmq-server/v3.6.1/rabbitmq-server-3.6.1-1.noarch.rpm

#Expose these ports for clustering to work
EXPOSE 4369
EXPOSE 25672

#Expose these ports for Erlang distribution protocol (EPMD)
EXPOSE 9101
EXPOSE 9102
EXPOSE 9103
EXPOSE 9104
EXPOSE 9105

#Expose AMQP and Admin ports

EXPOSE 5672
EXPOSE 15672

# Enable admin UI console using management plugin
RUN rabbitmq-plugins enable rabbitmq_management rabbitmq_management_agent

# To enable loopback interface and enable admin login with guest - NOT FOR PROD
RUN echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config

# RabbitMQ nodes authenticate with each other using this cookie
COPY erlang.cookie /var/lib/rabbitmq/.erlang.cookie
RUN chown rabbitmq:rabbitmq /var/lib/rabbitmq/.erlang.cookie
RUN chmod 600 /var/lib/rabbitmq/.erlang.cookie

COPY server.sh .
CMD sh server.sh
