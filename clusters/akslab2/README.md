## Tanzu Sync

Tanzu Sync fetches templated Kubernetes configuration from a git repository, applies data values, and deploys it to the cluster.
This reference implementation comes pre-configured with an install of Tanzu Application Platform.

For detailed documentation, refer to [VMware Tanzu Application Platform Product Documentation](https://docs.vmware.com/en/VMware-Tanzu-Application-Platform/1.5/tap/install-gitops-intro.html).

Secrets Management

create user-registry-dockerconfig
kubectl -n tap-install create secret docker-registry --dry-run=client user-registry-dockerconfig --docker-server 'https://index.docker.io/v1/' --docker-username=[dockerhub-userid] --docker-password='[dockerhub-password]' -o yaml > user-registry-dockerconfig.yaml


sops --encrypt ./user-registry-dockerconfig.yaml > user-registry-dockerconfig.sops.yaml
cp ./user-registry-dockerconfig.sops.yaml [tap-gitops local repo full path]/clusters/akslab2/cluster-config/config/tap-install/
~