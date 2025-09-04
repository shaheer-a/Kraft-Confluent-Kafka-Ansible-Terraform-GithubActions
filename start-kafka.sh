#!/bin/bash
set -e

INVENTORY="hosts.yaml"

echo "==== Starting Controllers ===="
ansible -i $INVENTORY -m shell -a "systemctl start confluent-kcontroller" kafka-controller-1.your-internal-domain

echo "==== Starting Brokers ===="
ansible -i $INVENTORY -m shell -a "systemctl start confluent-server" kafka-broker-1.your-internal-domain

echo "==== Starting Schema Registry ===="
ansible -i $INVENTORY -m shell -a "systemctl start confluent-schema-registry" kafka-schema-registry-1.your-internal-domain

echo "==== Starting Kafka Connect ===="
ansible -i $INVENTORY -m shell -a "systemctl start confluent-kafka-connect" kafka-connect-1.your-internal-domain

echo "==== Starting Control Center ===="
ansible -i $INVENTORY -m shell -a "systemctl start confluent-control-center" kafka-control-center-1.your-internal-domain

echo "==== All services of development confluent kafka started successfully ===="
