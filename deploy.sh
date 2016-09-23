#!/bin/bash

docker login -e="." -u="$QUAY_USERNAME" -p="$QUAY_PASSWORD" quay.io
docker tag keboola/docker-custom-python quay.io/keboola/docker-custom-python:$TRAVIS_TAG
docker tag keboola/docker-custom-python quay.io/keboola/docker-custom-python:latest
docker images
docker push quay.io/keboola/docker-custom-python:$TRAVIS_TAG
docker push quay.io/keboola/docker-custom-python:latest
