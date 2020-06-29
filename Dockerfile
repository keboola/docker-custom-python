FROM python:3.8.1
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
        libatlas-base-dev \
        gfortran \
    && rm -rf /var/lib/apt/lists/*

# From https://jdk.java.net/13/, stolen from https://github.com/docker-library/openjdk/blob/master/8/jdk/Dockerfile#L22
ENV JAVA_HOME /usr/local/openjdk
ENV PATH $JAVA_HOME/bin:$PATH
RUN wget https://download.java.net/java/GA/jdk13.0.2/d4173c853231432d94f001e99d882ca7/8/GPL/openjdk-13.0.2_linux-x64_bin.tar.gz \
	&& mkdir $JAVA_HOME \
	&& tar xv --file openjdk-13*_bin.tar.gz --directory "$JAVA_HOME" --no-same-owner --strip-components 1 \
	&& find "$JAVA_HOME/lib" -name '*.so' -exec dirname '{}' ';' | sort -u > /etc/ld.so.conf.d/docker-openjdk.conf \
	&& ldconfig

# Lets always use latest pip?
RUN /usr/local/bin/python -m pip install --upgrade pip

# Install some commonly used packages and the Python application
RUN pip3 install --no-cache-dir --upgrade --force-reinstall \
		beautifulsoup4 \
		bokeh \
		cloudpickle \
		colorama \
		cython \
		dill \
        httplib2 \
        ipython \
        flake8 \
        future \
        h5py \
        idna\<2.10\
        matplotlib \
        mlflow \
        numba \
        numexpr \
        numpy \
        nose \
        pandas\<1.0\
        patsy \
        pymongo \
        PyYaml \
        pytest \
        qgrid \
        requests\<2.24.0\
        seaborn \
        snowflake-connector-python \
        scipy \
        scikit-learn \
        scikit-image \
        sqlalchemy\<=1.3.13\
        statsmodels \
        sympy \
        tabulate \
        tqdm \
        vincent \
        xlrd \
    && pip3 install --no-cache-dir --upgrade --force-reinstall git+git://github.com/keboola/python-docker-application.git@2.1.1 \
    && pip3 install --no-cache-dir --find-links https://h2o-release.s3.amazonaws.com/h2o/latest_stable_Py.html h2o \
    && mkdir -p /root/.cache/snowflake/

# Import matplotlib the first time to build the font cache.
ENV XDG_CACHE_HOME /home/$NB_USER/.cache/
RUN MPLBACKEND=Agg python -c "import matplotlib.pyplot"

RUN pip3 check
