FROM quay.io/keboola/base-python:3.5.1

# setup the environment
WORKDIR /tmp
RUN pip install --no-cache-dir \
		PyYaml \
		httplib2 \
		MechanicalSoup \
		pymongo 

RUN pip install --upgrade git+git://github.com/keboola/python-docker-application.git

# prepare the container
WORKDIR /home

