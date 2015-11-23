FROM keboola/base
MAINTAINER Ondrej Popelka <ondrej.popelka@keboola.com>

ENV APP_CUSTOM_VERSION 1.0.0

# setup the environment
WORKDIR /tmp
RUN pip install \
		PyYaml \
		httplib2 \
		mechanize

# prepare the container
WORKDIR /home

