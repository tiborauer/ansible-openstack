# Deploy VM on OpenStack (Hun-REN Cloud)

## Seed VM

Ansible requires a Linux machine as a control. The repo assumes that you are on
an Ubuntu machine with user "service". The simplest way to achieve this is 
using WSL.

### Configure WSL

1. Passwordless sudo

    ```bash
    sudo visudo
    ```

Add `"service ALL=(ALL) NOPASSWD:ALL"` at the end of the file

2. Prevent system resetting hosts

    ```bash
    echo -e '\n[network]\nhostname=seed\ngenerateHosts=false' | sudo tee -a /etc/wsl.conf
    ```

3. Update system

    ```bash
    sudo apt update
    sudo apt upgrade
    ```

### Install deployement environment

1. Install developmental packages

    ```bash
    sudo apt install curl software-properties-common apt-transport-https python3-pip git pre-commit ca-certificates gnupg
    ```

2. Setup git

    ```bash
    git config --global init.defaultBranch main
    git config --global user.name <username>
    git config --global user.email <e-mail>
    git clone https://github.com/tiborauer/ansible-openstack /home/service/projects/deploy
    ```

3. Ansible

    3.1. Install

        ```bash
        pip install ansible vault-keyring-client keyrings.cryptfile passlib --user --break-system-package
        echo 'export PATH=/home/service/.local/bin:${PATH}' >> /home/service/.bashrc
        ```

    3.2. Set up vault password

        You MUST create the same vault-id(s) with password as that was/were 
        used for encoding the vault secrets. It will also asks for a password
        for the keyring. This can be anything you like.

        ```bash
        . /home/service/projects/deploy/utils/ansible-vault-set.sh [vault-id]
        ```

    3.3. Configure Ansible so that it uses the keyring for the vault password

        ```bash
        echo -e '[defaults]\nvault_password_file=/home/service/.local/bin/vault-keyring-client' > /home/service/.ansible.cfg
        ```

4. Setup OpenStack

    - Copy the clouds.yaml file to /home/service/.config/openstack (create folder
      if not exists)
    - Copy SSH keys correspodning to `organisation.initial_key` in _vars/environment.yml_ 
      with basename "_id\_cloud_" to /home/service/.ssh (create folder if not 
      exists). Make sure the permission of the private key is set to "_600_".
      ```bash
      chmod 0600 /home/service/.ssh/id_rsa
      ```