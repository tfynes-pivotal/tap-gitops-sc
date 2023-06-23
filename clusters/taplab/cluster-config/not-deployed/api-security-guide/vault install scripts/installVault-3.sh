
# FUNCTIONS FOR RUNNING-IN OR COPYING-TO VAULT POD
run-in-vault-pod() {
  kubectl -n vault exec -it vault-0 -- /bin/sh -c "export VAULT_TOKEN=$roottoken && $1"
}

copy-to-vault-pod() {
  kubectl -n vault cp $1 vault-0:$2 -c vault
}

write-to-vault-pod() {
  kubectl -n vault exec -it vault-0 -- /bin/sh -c "echo \"$1\" > $2"
}

# INITIALIZE VAULT ROOT TOKEN from vault.out FILE
export roottoken=$(yq e '.root_token' ./vault.out)

# UNSEAL VAULT
run-in-vault-pod "vault operator unseal $(yq e '.unseal_keys_hex[0]' ./vault.out)"

# ENABLE SECRETS FOR API-PORTAL
run-in-vault-pod "vault secrets enable -path=api-portal-for-vmware-tanzu kv-v2"
echo

# CREATE VAULT POLICY FILE FOR API-PORTAL & SPRING CLOUD GATEWAY
cat > /tmp/apip <<EOM
path "api-portal-for-vmware-tanzu/data/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
path "api-portal-for-vmware-tanzu/metadata/*" {
  capabilities = ["list", "delete"]
}
EOM

# COPY POLICY FILE TO VAULT POD
copy-to-vault-pod "/tmp/apip" "/tmp/apip"

# APPLY POLICY TO VAULT
run-in-vault-pod "cat /tmp/apip | vault policy write api-portal-policy -"

# VAULT K8S enable
run-in-vault-pod "vault auth enable kubernetes"

# ADD API-PORTAL & SCG ROLE TO VAULT
run-in-vault-pod "vault write auth/kubernetes/role/api-portal-role bound_service_account_names=api-portal,tdemo-gateway-svc-acc bound_service_account_namespaces=api-portal,default policies=api-portal-policy ttl=24h"

# CONFIGURE VAULT K8S CONFIG
write-to-vault-pod "VAULT_TOKEN='$roottoken' vault write auth/kubernetes/config token_reviewer_jwt=\"\$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)\" kubernetes_host=\"https://\$KUBERNETES_PORT_443_TCP_ADDR:443\" kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt bound_service_account_names=api-portal,tdemo-gateway-svc-acc bound_service_account_namespaces=api-portal,default policies=api-portal-policy ttl=24h" "/tmp/vault-k8s-config"

run-in-vault-pod "chmod +x /tmp/vault-k8s-config"
run-in-vault-pod "/tmp/vault-k8s-config"

echo VAULT STATUS
run-in-vault-pod "vault status"
