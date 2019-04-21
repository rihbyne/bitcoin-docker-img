# Base OS image
FROM debian:testing
MAINTAINER Rihan Pereira <rihen234@gmail.com>

ARG USER_ID
ARG GROUP_ID

ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}


# create and assign user/groups to the /bitcoind directory
RUN groupadd -g ${GROUP_ID} bitcoin \
    && useradd -u ${USER_ID} -g bitcoin -s /bin/bash -m -d /btc-client bitcoin

# remain as user bitcoin
USER bitcoin

# copy bitcoin-version client
ADD ./bitcoin-0.17.1 /btc-client

# copy bitcoin.conf file
ADD ./bitcoin.conf /btc-client

# specify the directory to use as a volume
VOLUME ["/btc-client/data"]

# expose btc p2p network and rpc port
EXPOSE 8332 18332 8333 18333

# working directory
WORKDIR /btc-client/bin

# make bitcoind executable
# RUN chmod +x /btc-client/bin/bitcoind

# entrypoint
ENTRYPOINT ["/btc-client/bin/bitcoind", "-conf=/btc-client/bitcoin.conf", "-reindex"]
