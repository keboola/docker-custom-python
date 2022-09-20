# syntax=docker/dockerfile:1
FROM python

RUN pip3 install --no-cache-dir \
        snowflake-snowpark-python \
	&& chown :users -R /home/default \
	&& chmod a+rwx -R /home/default \
    && pip3 check
