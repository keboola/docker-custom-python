#!/bin/bash

docker login -u="$QUAY_USERNAME" -p="$QUAY_PASSWORD" quay.io
docker tag keboola/docker-custom-python quay.io/keboola/docker-custom-python:$TRAVIS_TAG
docker tag keboola/docker-custom-python quay.io/keboola/docker-custom-python:latest
docker images
docker push quay.io/keboola/docker-custom-python:$TRAVIS_TAG
docker push quay.io/keboola/docker-custom-python:latest

# taken from https://gist.github.com/BretFisher/14cd228f0d7e40dae085
# install aws cli w/o sudo
pip install --user awscli
# put aws in the path
export PATH=$PATH:$HOME/.local/bin
# needs AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY envvars
eval $(aws ecr get-login --region us-east-1)
docker tag keboola/docker-custom-python:latest 147946154733.dkr.ecr.us-east-1.amazonaws.com/keboola/docker-custom-python:$TRAVIS_TAG
docker tag keboola/docker-custom-python:latest 147946154733.dkr.ecr.us-east-1.amazonaws.com/keboola/docker-custom-python:latest
docker push 147946154733.dkr.ecr.us-east-1.amazonaws.com/keboola/docker-custom-python:$TRAVIS_TAG
docker push 147946154733.dkr.ecr.us-east-1.amazonaws.com/keboola/docker-custom-python:latest

# needs KBC_DEVELOPERPORTAL_USERNAME, KBC_DEVELOPERPORTAL_PASSWORD and KBC_DEVELOPERPORTAL_URL
docker pull quay.io/keboola/developer-portal-cli-v2:latest
export REPOSITORY=`docker run --rm  -e KBC_DEVELOPERPORTAL_USERNAME=$KBC_DEVELOPERPORTAL_USERNAME -e KBC_DEVELOPERPORTAL_PASSWORD=$KBC_DEVELOPERPORTAL_PASSWORD -e KBC_DEVELOPERPORTAL_URL=$KBC_DEVELOPERPORTAL_URL quay.io/keboola/developer-portal-cli-v2:0.0.1 ecr:get-repository keboola dca-custom-science-python`
docker tag keboola/docker-custom-python:latest $REPOSITORY:$TRAVIS_TAG
docker tag keboola/docker-custom-python:latest $REPOSITORY:latest
eval $(docker run --rm -e KBC_DEVELOPERPORTAL_USERNAME=$KBC_DEVELOPERPORTAL_USERNAME -e KBC_DEVELOPERPORTAL_PASSWORD=$KBC_DEVELOPERPORTAL_PASSWORD -e KBC_DEVELOPERPORTAL_URL=$KBC_DEVELOPERPORTAL_URL quay.io/keboola/developer-portal-cli-v2:0.0.1 ecr:get-login keboola dca-custom-science-python)
docker push $REPOSITORY:$TRAVIS_TAG
docker push $REPOSITORY:latest

# Deploy to KBC -> update tag to current in Keboola Developer Portal
docker run --rm -e KBC_DEVELOPERPORTAL_USERNAME=$KBC_DEVELOPERPORTAL_USERNAME -e KBC_DEVELOPERPORTAL_PASSWORD=$KBC_DEVELOPERPORTAL_PASSWORD -e KBC_DEVELOPERPORTAL_URL=$KBC_DEVELOPERPORTAL_URL quay.io/keboola/developer-portal-cli-v2:latest update-app-repository keboola dca-custom-science-python $TRAVIS_TAG
