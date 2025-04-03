# Deploy VM on OpenStack (Hun-REN Cloud)

## Seed VM

1. Passwordless sudo
```bash
sudo visudo
```

Add _"service ALL=(ALL:ALL) ALL"_ under the section _# User privilege specification_

2. Update system
```bash
sudo apt update
sudo apt upgrade
```

3. Install developmental packages
```bash
sudo apt install curl software-properties-common apt-transport-https python3-pip git pre-commit ca-certificates gnupg
```

3. Install Ansible
```bash
pip install ansible --user --break-system-package
echo 'export PATH=/home/service/.local/bin:${PATH}' >> /home/service/.bashrc
```

4. Setup git
```bash
git config --global init.defaultBranch main
git config --global user.name <username>
git config --global user.email <e-mail>
git clone https://github.com/tiborauer/ansible-openstack
```
