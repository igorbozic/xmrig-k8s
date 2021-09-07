FROM  alpine:latest
RUN   adduser -S -D -H -h /xmrig miner
RUN   apk --no-cache upgrade && \
      apk --no-cache add \
        git \
        cmake \
        libuv-dev \
        build-base \
        openssl-dev \
        libmicrohttpd-dev && \
      git clone https://github.com/xmrig/xmrig && \
      git clone https://github.com/xmrig/xmrig-k8s && \
      cp xmrig-k8s/config/donate.h xmrig/src && \
      cp xmrig-k8s/config/config.json xmrig/src && \
      cp xmrig-k8s/config/Config_platform.h xmrig/src/core/config/ && \
      cp xmrig-k8s/config/Config_default.h xmrig/src/core/config/ && \
      rm -rf xmrig-k8s && \
      cd xmrig && \
      mkdir build && \
      cmake -DCMAKE_BUILD_TYPE=Release . && \
      make && \
      apk del \
        build-base \
        cmake \
        git
USER miner
WORKDIR    /xmrig
ENTRYPOINT  ["./xmrig"]
