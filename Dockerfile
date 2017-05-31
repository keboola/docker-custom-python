FROM python:3.5.3
ENV PYTHONIOENCODING utf-8

WORKDIR /home

RUN apt-get update && apt-get install -y --no-install-recommends \
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
		libssl-dev \
		libgeos-c1 \
		g++ \
	&& rm -rf /var/lib/apt/lists/*

# Install some commonly used packages and the Python application
RUN pip3 install --no-cache-dir --upgrade --force-reinstall \
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
	&& pip3 install --no-cache-dir --upgrade --force-reinstall git+git://github.com/keboola/python-docker-application.git@2.0.0
