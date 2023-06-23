#kubectl -n vault exec -it vault-0 -- /bin/sh -c "vault operator init" > vault.out
kubectl -n vault exec -it vault-0 -- /bin/sh -c "vault operator init -key-shares=1 -key-threshold=1 -format='yaml'" > vault.out
cat vault.out
