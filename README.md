# bitcoin docker image

This repository maintains the setup required for dockerizing [bitcoin-core](https://bitcoincore.org/) binary.

The blockchain data for the main-net bitcoin at the time of this writing is 250GB which is very expensive
in terms of bandwidth, storage unless the maintainer is monetized. For experimental purpose, it is
recommended to instead switch to testnet data which relatively requires smaller storage ~1.5 GB with
**pruning enabled**. Without pruning its 14GB and depends on what you want to get out of it.

The `bitcoin.conf` file is configured for testnet 3 with pruning enabled.

## quick run

`docker run -v /covered/btc-testnet-data/:/btc-client/data -p 8332:18332 -p 8333:18333 -td rihbyne/btc-testnet-img:v1.0.0`

Note - you have to create the directory on host `/covered/btc-testnet-data/`, so the runnable container mounts it as volume
for persisting testnet 3 block data

## build the image

`docker build -t btc-testnet-img`

## Running the image after local build

`docker run --name testnet-btc-live -v /covered/btc-testnet-data/:/btc-client/data -p 8332:18332 -p 8333:18333 -td btc-testnet-img:latest`

Here the `/covered/btc-testnet-data/` is the docker volume mounted to store blocks. This is need to prevent 
the  container from growing in size with time because the bitcoin-client will continue downloading and sync with
its peer node over time.

# upcoming improvements
- automate upgrading bitcoin-core lib through shell script
