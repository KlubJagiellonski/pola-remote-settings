#!/bin/sh
SCHEMA=$1
JSON_FILES=$(ls $2)
FAILED=0

echo "\033[0;36mValidating schema $SCHEMA\033[0m\n"
ajv compile -s $SCHEMA

if [ $? -ne 0 ]; then
  echo "\033[0;31m============================================="
  echo "\033[0;31m===== The schema '$SCHEMA' is invalid! ======="
  echo "\033[0;31m=============================================\033[0m"
  exit 1
fi

echo "\033[0;34m\n============================================="
echo "\033[0;34mValidating all files using '$SCHEMA'"
echo "\033[0;34m=============================================\n\033[0m"

for FILE in $JSON_FILES; do
  echo "\033[0;36mValidating $FILE\033[0m\n"

  ajv -s $SCHEMA -d $FILE

  if [ $? -ne 0 ]; then
    FAILED=1
  fi

  echo "---------------------------------------------\n"

done

if [ $FAILED -ne 0 ]; then
  echo "\033[0;31m============================================="
  echo "\033[0;31m===== At least one validation failed! ======="
  echo "\033[0;31m=============================================\033[0m"
  exit 1
else
  echo "\033[0;32m============================================="
  echo "\033[0;32m========== All files are valid. ============="
  echo "\033[0;32m=============================================\033[0m"
  exit 0
fi
