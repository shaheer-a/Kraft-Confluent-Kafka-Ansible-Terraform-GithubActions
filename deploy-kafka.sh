#!/bin/bash

# ---- CONFIGURATION ----
USERNAME="your-username"
PASSWORD="your-password"

# List of hostnames or IPs
HOSTS=(
  "kafka-controller-1.your-internal-domain"
  "kafka-broker-1.your-internal-domain"
  "kafka-schema-registry-1.your-internal-domain"
  "kafka-connect-1.your-internal-domain"
  "kafka-control-center-1.your-internal-domain"
)

# ---- PRE-EXECUTION ----
echo "🧹 Cleaning up known_hosts files if they exist..."

KNOWN_HOSTS_FILE="$HOME/.ssh/known_hosts"
KNOWN_HOSTS_OLD_FILE="$HOME/.ssh/known_hosts.old"

[[ -f "$KNOWN_HOSTS_FILE" ]] && rm -f "$KNOWN_HOSTS_FILE" && echo "✅ Removed $KNOWN_HOSTS_FILE"
[[ -f "$KNOWN_HOSTS_OLD_FILE" ]] && rm -f "$KNOWN_HOSTS_OLD_FILE" && echo "✅ Removed $KNOWN_HOSTS_OLD_FILE"

echo "✅ SSH known_hosts cleanup complete."

# ---- SSH CONNECTIONS ----
for HOST in "${HOSTS[@]}"; do
  echo "============================"
  echo "🔗 Connecting to $HOST..."

  sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no "$USERNAME@$HOST" << 'EOF'
echo "✅ Connected to $(hostname)"
uptime
whoami
exit
EOF

  echo "🚪 Logged out from $HOST"
  echo "============================"
  echo
done

# ---- ANSIBLE VALIDATION ----
echo "🔍 Running Ansible host validation..."

ANSIBLE_HASH_BEHAVIOUR=merge ansible-playbook -i hosts.yaml confluent.platform.validate_hosts
if [ $? -ne 0 ]; then
  echo "❌ Host validation failed. Aborting deployment."
  exit 1
fi

echo "✅ Host validation passed."

# ---- ANSIBLE DEPLOYMENT ----
echo "🚀 Running full Ansible deployment..."

ANSIBLE_HASH_BEHAVIOUR=merge ansible-playbook -i hosts.yaml confluent.platform.all
