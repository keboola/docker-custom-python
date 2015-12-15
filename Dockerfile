FROM quay.io/keboola/base-python

# setup the environment
WORKDIR /tmp
RUN pip install --no-cache-dir \
		PyYaml \
		httplib2 \
		MechanicalSoup

RUN pip install --upgrade git+git://github.com/keboola/python-docker-application.git

# prepare the container
WORKDIR /home

