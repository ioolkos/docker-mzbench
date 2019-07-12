FROM erlang:20.3.8.22

ENV MZBENCH_REV "f8da05dd2dfc06a87bc3870095e360ee184de4e2"

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get install -y vim rsync

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
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
EXPOSE 8888

CMD /app/mzbench/bin/mzbench start_server --config /etc/mzbench/server.config; tail -f /dev/null
