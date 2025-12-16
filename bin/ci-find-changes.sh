#!/usr/bin/env bash
set -e

if [ "$#" -lt "1" ]; then
    echo 'Usage: ci-find-changes.sh <targetBranch> <varName>:<path>'
    echo 'Example: ci-find-changes.sh main internalApi:apps/internal-api internalApiPhpClient:libs/internal-api-php-client'
    exit
fi

TARGET_BRANCH=$1
ALL_CHANGES=

set_output() {
    local var_name=$1
    local value=$2
    echo "${var_name}=${value}" >> "$GITHUB_OUTPUT"
}

for PROJECT in ${@:2}; do
  PROJECT_CONFIG=(${PROJECT//:/ })
  PROJECT_VAR_NAME=${PROJECT_CONFIG[0]}
  PROJECT_DIR=${PROJECT_CONFIG[1]}

  echo -n "Checking ${PROJECT_DIR} ... "
  PROJECT_CHANGES_COUNT=$(git diff --name-only "origin/${TARGET_BRANCH}" "${PROJECT_DIR}" | wc -l)

  if [[ $PROJECT_CHANGES_COUNT -eq 0 ]]; then
    echo "no changes"
    set_output "changedProjects_${PROJECT_VAR_NAME}" "0"
  else
    echo "has changes"
    set_output "changedProjects_${PROJECT_VAR_NAME}" "1"
    ALL_CHANGES="${ALL_CHANGES} \"${PROJECT_VAR_NAME}\""
  fi
done

if [[ "${ALL_CHANGES}" == "" ]]; then
  echo ">> No changes detected, triggering all projects builds"
  for PROJECT in ${@:2}; do
    PROJECT_CONFIG=(${PROJECT//:/ })
    PROJECT_VAR_NAME=${PROJECT_CONFIG[0]}

    set_output "changedProjects_${PROJECT_VAR_NAME}" "1"
    ALL_CHANGES="${ALL_CHANGES} \"${PROJECT_VAR_NAME}\""
  done
fi

set_output "changedProjects" "$ALL_CHANGES"
