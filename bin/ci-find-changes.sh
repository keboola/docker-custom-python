#!/usr/bin/env bash
set -e

if [ "$#" -lt "1" ]; then
    echo 'Usage: ci-find-changes.sh <varName>:<path>'
    echo 'Example: ci-find-changes.sh internalApi:apps/internal-api internalApiPhpClient:libs/internal-api-php-client'
    exit
fi

ALL_CHANGES=

for PROJECT in $@; do
  PROJECT_CONFIG=(${PROJECT//:/ })
  PROJECT_VAR_NAME=${PROJECT_CONFIG[0]}
  PROJECT_DIR=${PROJECT_CONFIG[1]}

  echo -n "Checking ${PROJECT_DIR} ... "
  PROJECT_CHANGES_COUNT=$(git diff --name-only origin/main $PROJECT_DIR | wc -l)

  if [[ $PROJECT_CHANGES_COUNT -eq 0 ]]; then
    echo "no changes"
  else
    echo "has changes"
    echo "##vso[task.setvariable variable=changedProjects_${PROJECT_VAR_NAME};isOutput=true]1"
    ALL_CHANGES="${ALL_CHANGES} \"${PROJECT_VAR_NAME}\""
  fi
done

if [[ "${ALL_CHANGES}" == "" ]]; then
  echo ">> No changes detected, triggering all projects builds"
  for PROJECT in $@; do
    PROJECT_CONFIG=(${PROJECT//:/ })
    PROJECT_VAR_NAME=${PROJECT_CONFIG[0]}

    echo "##vso[task.setvariable variable=changedProjects_${PROJECT_VAR_NAME};isOutput=true]1"
    ALL_CHANGES="${ALL_CHANGES} \"${PROJECT_VAR_NAME}\""
  done
fi

echo "##vso[task.setvariable variable=changedProjects;isOutput=true]$ALL_CHANGES"