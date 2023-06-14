# Tanzu GitOps Demonstration Cluster

This archive combines an opinionated TAP cluster installation and configuration along with additional service operators and demonstration workloads.

It uses the carvel toolchain ([tanzu cluster essentials](https://network.pivotal.io/products/tanzu-cluster-essentials)) to configure continuous reconciliation from this archive after initial deployment and configuration.

The same configuration is used to monitor for application workload and service deployments allowing for the state of the target cluster to be driven off this repo for application as well as platform level configuration.

## Additional Implementation Details
* Uses CertManager HTTP Solver to establish TLS based ingress platform-wide.
* Includes Tanzu Postgres Operator, allowing for declarative in-cluster postgres database provisioning for apps.
* Includes Spring Cloud Gateway Operator, allowing for declarative in-cluster micro-gateway
  * Spring Cloud Gateway routes configured to fascade demonstration applications, showing URL rewriting and API-Key based authentication support
* Tanzu Spring API-Portal enabled to provide;
  * auto-instrumentation of SpringCloudGateway routes via the operator's openapi doc endpoint
  * self-service API-Key management
* Hashicorp Vault explicitly helm deployed to provide an in-cluster backend for API-Key storage


## Prerequisites
* Compliant kubernetes cluster (GKE, AKE, EKS, TKG....)
* Image Registry (e.g. Dockerhub)
* Source Repository (e.g. Github)
* Wildcard DNS Domain (e.g. dyn.com)
* TanzuNet Credentials
* [optional] OIDC provider with account (e.g. okta developer account)

  * CLI Tooling
    * kubectl
    * k9s (optional but recommended)
    * git cli
    * [age cli](https://github.com/FiloSottile/age#installation)
    * [sops cli](https://github.com/mozilla/sops/releases)
    * tanzu cli

## Notes
* Installation used SOPS-encrypted (sealed-secrets) allowing for safe use of a public gitops source repository


## Installation HowTo

* Secrets Encryption containing references to; [TAP Docs Reference](https://docs.vmware.com/en/VMware-Tanzu-Application-Platform/1.5/tap/install-gitops-sops.html)
  * image registry credentials (e.g. dockerhub login) 
  * source repository id (e.g. github 'app' client id/secret for tap-gui auth support)

### Creating Sensitive-Values Configuration Files
  



* Update all configuration files to refer to your wildcard DNS domain (global search/replace)

* Create target K8s Cluster

* Deploy Tanzu Cluster Essentials

* Deploy TAP 'sync' kApp

* Update wildcard DNS entry for global ingress to cluster (based on public IP provided by cluster to Contour)
  * Monitor for IP/CNAME as follows

```
kubectl -n tanzu-system-ingress get svc -w
```







For detailed documentation, refer to [VMware Tanzu Application Platform Product Documentation](https://docs.vmware.com/en/VMware-Tanzu-Application-Platform/1.5/tap/install-gitops-intro.html).
