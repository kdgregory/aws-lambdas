FROM postgres:9.6

ENV POSTGRES_USER rdsadmin
ENV POSTGRES_PASSWORD rdsadmin

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install apt-utils && \
    apt-get -y install postgresql-9.6-pgextwlist

COPY *.sql /docker-entrypoint-initdb.d/
COPY *.sh /docker-entrypoint-initdb.d/
