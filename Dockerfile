FROM centos

MAINTAINER Chetan Birajdar <birajdar.chetan@gmail.com>

# Install erlang and other packages
RUN yum -y install https://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-6.noarch.rpm

# Install latest rabbitmq server
RUN yum -y install http://www.rabbitmq.com/releases/rabbitmq-server/v3.6.1/rabbitmq-server-3.6.1-1.noarch.rpm

#Expose AMQP and Admin ports

EXPOSE 4369
EXPOSE 5672
EXPOSE 15672

RUN echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config

RUN rabbitmq-plugins enable rabbitmq_management

COPY erlang.cookie /var/lib/rabbitmq/.erlang.cookie
COPY server.sh .
RUN chown rabbitmq:rabbitmq /var/lib/rabbitmq/.erlang.cookie
RUN chmod 600 /var/lib/rabbitmq/.erlang.cookie

CMD sh server.sh
