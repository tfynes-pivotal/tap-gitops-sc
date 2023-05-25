export SOPS_AGE_RECIPIENTS=$(cat key.txt | grep "# public key: " | sed 's/# public key: //')
sops --encrypt tap-sensitive-values-12.yaml > tap-sensitive-values-12.sops.yaml
cp ./tap-sensitive-values-12.sops.yaml /Users/thomasfynes/PIVOTAL/TAP/tap-powertools/tap-installer-scripts/tap-gitops-sc/clusters/akslab/cluster-config/values/

sops --encrypt ./user-registry-dockerconfig.yaml > user-registry-dockerconfig.sops.yaml
cp ./user-registry-dockerconfig.sops.yaml /Users/thomasfynes/PIVOTAL/TAP/tap-powertools/tap-installer-scripts/tap-gitops-sc/clusters/akslab/cluster-config/config/tap-install/


sops --encrypt ./sso-credentials-secret.yaml > sso-credentials-secret.sops.yaml
cp ./sso-credentials-secret.sops.yaml /Users/thomasfynes/PIVOTAL/TAP/tap-powertools/tap-installer-scripts/tap-gitops-sc/clusters/akslab/cluster-config/config/tap-install/
