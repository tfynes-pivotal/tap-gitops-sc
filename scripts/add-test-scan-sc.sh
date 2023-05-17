#!/bin/bash
kubectl -n tap-install get secret ootb-supply-chain-basic-values-ver-1 -o jsonpath="{.data.values\.yml}" | base64 -d -i - > /tmp/values.yaml
tanzu -n tap-install package install ootb-supply-chain-testing-scanning -p ootb-supply-chain-testing-scanning.tanzu.vmware.com -v 0.12.5 --values-file /tmp/values.yaml
rm /tmp/values.yaml
