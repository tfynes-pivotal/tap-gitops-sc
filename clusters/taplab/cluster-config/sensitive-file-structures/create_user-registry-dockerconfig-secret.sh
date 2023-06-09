kubectl -n tap-install create secret docker-registry \
--dry-run=client user-registry-dockerconfig \
--docker-server 'https://index.docker.io/v1/' \
--docker-username=<userid> \
--docker-password='<password>' -o yaml  > user-registry-dockerconfig.yaml