
# 🐘 Confluent Kafka Deployment using Ansible 9.x

This guide outlines step-by-step instructions to deploy a **Confluent Kafka Cluster** using **Ansible 9.x**.

---

## 🛠 Prerequisites

### ✅ 1. Login to Ansible Control Node
Ensure you are logged into the **Ansible Control Node** with appropriate access.

### ✅ 2. Ensure Root Privileges for every kafka node user
Your user must have **root privileges** and execute `sudo` without a password prompt.
Login to each kafka node and make sure the user has root privileges if not then follow the steps below to give it the sudo privileges without a password prompt.
#### How to configure:

```bash
sudo visudo
```
Add this line (replace `your_username` with your actual username, e.g., `your-username` or `root`):
```bash
your_username ALL=(ALL) NOPASSWD:ALL
```

---

## 🐍 3. Install Ansible 9.x and Dependencies

Run the following commands:
```bash
sudo dnf install ansible-core -y
ansible --version
ansible localhost -m ping
```

---

## 📦 4. Inventory Configuration (hosts.yaml)

Prepare a `hosts.yaml` file with:
- Kafka nodes' **DNS names**
- **Username & password** for SSH access
- **Confluent license key**

📄 **Sample hosts.yaml**:
- Available in this repository
- Official Documentation: [Confluent Ansible Hosts YAML](https://docs.confluent.io/ansible/current/ansible-prepare.html)

---

---

## ⚙️ 5. Configure Ansible

Edit (or create) the `ansible.cfg` file and set appropriate paths for your inventory and roles.

---

## 🚀 6. Deploy Confluent Kafka Cluster

login to ansible node 

switch the user to sudo

sudo -s

run ./deploy-kafka.sh

---

## ✅ Summary
By following this guide, you will have a fully deployed **Confluent Kafka Cluster** using **Ansible automation**.
