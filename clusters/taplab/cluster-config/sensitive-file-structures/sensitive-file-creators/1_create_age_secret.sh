
echo "Age Key (private secrets encryption key) Creation Script"
echo
if [ -f "key.txt" ]; then 
  echo "Encryption key already exists"
else
  age-keygen -o key.txt
  cat key.txt
fi
  echo
  echo =============================================================================================
  echo EXPORT key in SOPS_AGE_RECIPIENTS environment variable before progressing
  echo ---------------------------------------------------------------------------------------------
  echo export SOPS_AGE_RECIPIENTS=$(cat key.txt | grep "# public key: " | sed 's/# public key: //')
  echo =============================================================================================
  echo