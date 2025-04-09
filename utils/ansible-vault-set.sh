if [[ ! -z $1 ]]; then vault_id=$1
else vault_id=default;
fi
if (vault-keyring-client --vault-id $vault_id); then
    echo "Password for vault $vault_id already specified"
else
    echo "Specify password for vault $vault_id"
    vault-keyring-client --set --vault-id $vault_id
    if [[ -z $ANSIBLE_VAULT_IDENTITY_LIST ]]; then
        export ANSIBLE_VAULT_IDENTITY_LIST=$vault_id@$HOME/.local/bin/vault-keyring-client
        echo "export ANSIBLE_VAULT_IDENTITY_LIST=$vault_id@$HOME/.local/bin/vault-keyring-client" >> ~/.bashrc
    else
        export ANSIBLE_VAULT_IDENTITY_LIST=$ANSIBLE_VAULT_IDENTITY_LIST,$vault_id@$HOME/.local/bin/vault-keyring-client
        echo "export ANSIBLE_VAULT_IDENTITY_LIST=\$ANSIBLE_VAULT_IDENTITY_LIST,$vault_id@$HOME/.local/bin/vault-keyring-client" >> ~/.bashrc
    fi
fi
