#!/bin/bash

if [ -z "$JOIN_CLUSTER"]; then
  rabbitmq-server
else
  rabbitmqctl stop_app
  rabbitmqctl join_cluster rabbit@JOIN_CLUSTER
  rabbitmqctl start_app
fi
