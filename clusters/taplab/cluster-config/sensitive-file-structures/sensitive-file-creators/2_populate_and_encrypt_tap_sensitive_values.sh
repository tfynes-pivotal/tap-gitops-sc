echo TAP Sensitive Values File Creator and Encryptor echo
if [[ -z "${SOPS_AGE_RECIPIENTS}" ]]; then
  echo Error SOPS_AGE_RECIPIENTS environment variable not set. Initialize and relaunch this script.
  exit 1
fi


if [[ -z "${TAP_REPOSITORY_PATH}" || -z "${TAP_REPOSITORY_USERNAME}" || -z "${TAP_REPOSITORY_PASSWORD}" || -z "${TAP_GITHUB_ID}" || -z "${TAP_GITHUB_SECRET}" ]]; then
  echo Initialize the following as environment variables and re-run script
  echo export TAP_REPOSITORY_PATH='MyDockerhubRepository'
  echo export TAP_REPOSITORY_USERNAME='MyDockerhubUsername'
  echo export TAP_REPOSITORY_PASSWORD='MyDockerhubPassword'
  echo export TAP_GITHUB_ID='MyGithubId'
  echo export TAP_GITHUB_SECRET='MyGithubSecret'
else
  echo ytt interpolate and sops encrypt
  ytt -f ./tap-sensitive-values-template.yaml -v repository_path="$TAP_REPOSITORY_PATH" -v repository_username="$TAP_REPOSITORY_USERNAME" -v repository_password="$TAP_REPOSITORY_PASSWORD" -v github_id="$TAP_GITHUB_ID" -v github_secret="$TAP_GITHUB_SECRET" > /tmp/tap-secrets.yaml
  sops --encrypt /tmp/tap-secrets.yaml > ./tap-sensitive-values.sops.yaml
  rm /tmp/tap-secrets.yaml
fi 