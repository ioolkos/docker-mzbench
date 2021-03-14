FROM erlang:22.3.4.15

ENV MZBENCH_REV "27fd1910293d12223c60a8b7bb5ef8abe8e918b8"

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get install -y vim rsync \
    && apt-get install -y net-tools

RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip.py \
    && python get-pip.py \
    && rm get-pip.py

RUN cd / \
    && mkdir app \
    && cd app \
    && git clone https://github.com/mzbench/mzbench \
    && cd mzbench \
    && git checkout $MZBENCH_REV \
    && pip install -r requirements.txt

COPY ./server.config /etc/mzbench/server.config
EXPOSE 4800

CMD /app/mzbench/bin/mzbench start_server --config /etc/mzbench/server.config; tail -f /dev/null
