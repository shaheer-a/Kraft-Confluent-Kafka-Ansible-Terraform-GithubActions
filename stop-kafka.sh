#!/bin/bash
set -e

INVENTORY="hosts.yaml"

echo "==== Stopping Control Center ===="
ansible -i $INVENTORY -m shell -a "systemctl stop confluent-control-center" kafka-control-center-1.your-internal-domain

echo "==== Stopping Kafka Connect ===="
ansible -i $INVENTORY -m shell -a "systemctl stop confluent-kafka-connect" kafka-connect-1.your-internal-domain

echo "==== Stopping Schema Registry ===="
ansible -i $INVENTORY -m shell -a "systemctl stop confluent-schema-registry" kafka-schema-registry-1.your-internal-domain

echo "==== Stopping Brokers ===="
ansible -i $INVENTORY -m shell -a "systemctl stop confluent-server" kafka-broker-1.your-internal-domain

echo "==== Stopping Controllers ===="
ansible -i $INVENTORY -m shell -a "systemctl stop confluent-kcontroller" kafka-controller-1.your-internal-domain

echo "==== All services of development confluent kafka stopped safely ===="
