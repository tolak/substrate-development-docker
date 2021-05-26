# Docker Container Of Substrate Development

Substrate development environment, including start solochain and parachain.

## Download image or build image by yourself

### Download prebuild image from docker hub

After docker installed, run

```sh
docker pull tolak/substrate-development:v0.0.4
```
### Or build by yourself

Run script ```build-image.sh``` or give a specific image name by runing

```sh
docker build -t <image name> .
```

> Note case binary file under polkadot-launch/bin is too large, so before build your own image contact me to get the right binary file.

## Run docker container by executing

```sh
docker run -it -p 127.0.0.1:9944:9944 -p 127.0.0.1:9988:9988 -p 127.0.0.1:9999:9999 --name substrate tolak/substrate-development:v0.0.4
```

## Run Parachains

See [here](./run-parachains.md)
