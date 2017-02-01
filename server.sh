#!/bin/bash

if [ -z "$JOIN_CLUSTER" ]; then
  rabbitmq-server
else
  rabbitmq-server -detached
  rabbitmqctl stop_app
  rabbitmqctl join_cluster rabbit@$JOIN_CLUSTER
  rabbitmqctl start_app
  tail -f /var/log/rabbitmq/rabbit@$HOSTNAME.log
fi
