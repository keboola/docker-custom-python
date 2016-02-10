FROM quay.io/keboola/base-python:3.5.1-f

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
		PyYaml \
		httplib2 \
		MechanicalSoup \
		pymongo \
		ipython \
		numpy \
		matplotlib \
	&& pip install --upgrade --no-cache-dir --ignore-installed --cert=/tmp/cacert.pem git+git://github.com/keboola/python-docker-application.git

# prepare the container
WORKDIR /home
