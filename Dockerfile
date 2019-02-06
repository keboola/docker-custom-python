FROM python:3.7.2
ENV PYTHONIOENCODING utf-8

WORKDIR /home

RUN apt-get update && apt-get install -y --no-install-recommends \
        libgeos-c1v5 \
        python-numpy \
        python-scipy \
        python-matplotlib \
        ipython \
        python-pandas \
        python-sympy \
        python-nose \
        g++ \
    && rm -rf /var/lib/apt/lists/*

# Install some commonly used packages and the Python application
RUN pip3 install --no-cache-dir --upgrade --force-reinstall \
        httplib2 \
        ipython \
        flake8 \
        matplotlib \
        numpy \
        nose \
        pandas \
        pymongo \
        PyYaml \
        pytest \
        requests \
        snowflake-connector-python \
        scipy \
        scikit-learn \
        sympy \     
    && pip3 install --no-cache-dir --upgrade --force-reinstall git+git://github.com/keboola/python-docker-application.git@2.1.1 \
    && mkdir -p /root/.cache/snowflake/
