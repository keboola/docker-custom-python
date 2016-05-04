FROM quay.io/keboola/base-python:3.5.1-g

WORKDIR /home

RUN yum -y update \
	&& yum -y install \
		numpy \
		scipy \
		python-matplotlib \
		ipython \
		python-pandas \
		sympy \
		python-nose \
		libpng \
		libpng-devel \
		freetype2 \ 
		freetype-devel \
		gcc-c++ \
	&& yum clean all

# Install some commonly used packages and the Python application
RUN pip install --no-cache-dir --ignore-installed --cert=/tmp/cacert.pem \
		httplib2 \
		ipython \
		flake8 \
		matplotlib \
		numpy \
		pandas \
		pymongo \
		PyYaml \
		pytest \
	&& pip install --upgrade --no-cache-dir --ignore-installed --cert=/tmp/cacert.pem git+git://github.com/keboola/python-docker-application.git@1.2.0

# prepare the container
WORKDIR /home
