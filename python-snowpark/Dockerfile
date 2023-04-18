# syntax=docker/dockerfile:1
FROM python

ENV VIRTUAL_ENV /home/default

RUN mkdir $VIRTUAL_ENV \
    && chown :users -R $VIRTUAL_ENV \
    && chmod a+rwx -R $VIRTUAL_ENV

RUN python3 -m venv $VIRTUAL_ENV \
    && . $VIRTUAL_ENV/bin/activate \
    && pip3 install --no-cache-dir snowflake-snowpark-python \
	&& chown :users -R /home/default \
	&& chmod a+rwx -R /home/default \
    && pip3 check
