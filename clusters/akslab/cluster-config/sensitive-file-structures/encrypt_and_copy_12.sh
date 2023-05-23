# sops encryptor 'age' key in local directory as 'key.txt'


export SOPS_AGE_RECIPIENTS=$(cat key.txt | grep "# public key: " | sed 's/# public key: //')
sops --encrypt tap-sensitive-values-12.yaml > tap-sensitive-values-12.sops.yaml
cp ./tap-sensitive-values-12.sops.yaml /<path-to-local-repo-tap-gitops-sc>/clusters/akslab2/cluster-config/values/

sops --encrypt ./user-registry-dockerconfig.yaml > user-registry-dockerconfig.sops.yaml
cp ./user-registry-dockerconfig.sops.yaml /<path-to-local-repo-tap-gitops-sc>/clusters/akslab2/cluster-config/config/tap-install/
