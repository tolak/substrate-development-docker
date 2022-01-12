# Docker Container Of Substrate Development

A pure substrate development environment, with rust and node environment configured.

## Download image or build image by yourself

### Download prebuild image from docker hub

After docker installed, run

```sh
docker pull tolak/substrate-development:v0.7.0
```
### Or build by yourself

Run script ```build-image.sh``` or give a specific image name by runing

```sh
docker build -t <image name> .
```

## Run docker container by executing

```sh
docker run -it -p 127.0.0.1:9944:9944 -p 127.0.0.1:9955:9955 --p 127.0.0.1:19944:19944 v <local substrate workspace>:<container workspace> --name substrate tolak/substrate-development:v0.7.0
```
