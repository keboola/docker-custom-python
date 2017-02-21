FROM quay.io/keboola/base-python:3.5.2-b

WORKDIR /home

RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
		python-numpy \
		python-scipy \
		python-matplotlib \
		ipython \
		python-pandas \
		python-sympy \
		python-nose \
		libpng12-0 \
		libpng12-dev \
		libfreetype6 \
		libfreetype6-dev \
		g++ \
	&& rm -rf /var/lib/apt/lists/*

# Install some commonly used packages and the Python application
RUN pip install --no-cache-dir --ignore-installed \
		httplib2 \
		ipython \
		flake8 \
		matplotlib \
		numpy \
		pandas \
		pymongo \
		PyYaml \
		pytest \
		requests \
	&& pip install --upgrade --no-cache-dir --ignore-installed git+git://github.com/keboola/python-docker-application.git@1.3.0

# prepare the container
WORKDIR /home
