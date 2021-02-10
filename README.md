# docker-mzbench

Get your [MZBench](https://github.com/mzbench/mzbench) running in two steps:

1. Run `sudo docker build -t mzbench -f Dockerfile .`
2. Run `docker run -d -p 4800:4800 mzbench`
    Note: if you want to have access to a service running on the host (localhost),
    do something like `docker run --network="host" -d -p 4800:4800 mzbench`
3. Navigate to `http://localhost:4800` to get your MZBench Web UI