FROM python:3.8.8
ENV PYTHONIOENCODING utf-8

WORKDIR /home

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update && ACCEPT_EULA=Y apt-get install -y --no-install-recommends \
        libgeos-c1v5 \
        python-numpy \
        python-scipy \
        python-matplotlib \
        ipython \
        msodbcsql17 \
        mssql-tools \
        python-pandas \
        python-sympy \
        python-nose \
        g++ \
        libsasl2-dev \
        libatlas-base-dev \
        libicu-dev \
        gfortran \
        unixodbc-dev \
        python3-icu \
        wget \
        git \
        graphviz \
    && rm -rf /var/lib/apt/lists/*

ENV PATH $PATH:/opt/mssql-tools/bin

ENV VIRTUAL_ENV=/home/default

# From https://jdk.java.net/13/, stolen from https://github.com/docker-library/openjdk/blob/master/8/jdk/Dockerfile#L22
ENV JAVA_HOME /usr/local/openjdk
ENV PATH $JAVA_HOME/bin:$PATH
RUN wget https://download.java.net/java/GA/jdk13.0.2/d4173c853231432d94f001e99d882ca7/8/GPL/openjdk-13.0.2_linux-x64_bin.tar.gz \
    && mkdir $JAVA_HOME \
    && tar xv --file openjdk-13*_bin.tar.gz --directory "$JAVA_HOME" --no-same-owner --strip-components 1 \
    && find "$JAVA_HOME/lib" -name '*.so' -exec dirname '{}' ';' | sort -u > /etc/ld.so.conf.d/docker-openjdk.conf \
    && ldconfig

RUN mkdir /home/default \
	&& python3 -m venv $VIRTUAL_ENV \
    && . $VIRTUAL_ENV/bin/activate \
    && python3 -m pip install --upgrade pip \
    && pip3 install --no-cache-dir --upgrade --force-reinstall \
        avro \
        azure-storage-blob \
        beautifulsoup4 \
        bokeh \
        boto3 \
        cloudpickle \
        colorama \
        colorlog \
        console-bundle \
        cython \
        daipe-core \
        datalake-bundle \
        deepdiff \
        deprecation \
        dill \
        fastavro \
        flake8 \
        future \
        h5py \
        httplib2 \
        injecta \
        ipython \
        jupyter-bundle \
        lineage-bundle \
        logger-bundle \
        matplotlib \
        mlflow \
        nltk \
        nose \
        numba \
        numexpr \
        numpy \
        ordered-set \
        pandas \
        patsy \
        plotly \
        py4j \
        pycodestyle-magic \
        pyfony-bundles \
        pyfony-core \
        pymongo \
        pyodbc \
        pyspark \
        pyspark-bundle \
        pytest \
	    python-box \
        python-dotenv \
        PyYaml \
        qgrid \
        scikit-image \
        scikit-learn \
        scipy \
        seaborn \
        simpleeval \
        snowflake-connector-python[pandas] \
        sqlalchemy\
        statsmodels \
        sympy \
        tabulate \
        tomlkit \
        tqdm \
        vincent \
        xgboost \
        xlrd \
	&& chown :users -R /home/default \
	&& chmod a+rwx -R /home/default

RUN . $VIRTUAL_ENV/bin/activate \
    && pip3 install --no-cache-dir --upgrade --force-reinstall git+https://github.com/keboola/python-docker-application.git@2.2.0 \
    && pip3 install --no-cache-dir --find-links https://h2o-release.s3.amazonaws.com/h2o/latest_stable_Py.html h2o \
    && pip3 install --no-cache-dir --upgrade --force-reinstall \
        git+https://github.com/keboola/sapi-python-client.git@0.4.0 \
        keboola.component \
        cryptography\<41 \
        charset-normalizer\<3 \
        chardet\<4 \
        'pyopenssl==23.1.1' \
    && mkdir -p /root/.cache/snowflake/ \
	&& chown :users -R /home/default \
	&& chmod a+rwx -R /home/default

# Import matplotlib the first time to build the font cache.
ENV XDG_CACHE_HOME /tmp/

RUN . $VIRTUAL_ENV/bin/activate \
    && MPLBACKEND=Agg python -c "import matplotlib.pyplot" \
    && pip3 check \
    && pip3 freeze
