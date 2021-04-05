# Docker Container Of Parachain Crowdloan Test

# Background

We launched three polkadot validators and two parachains with paraid 200 and 300. The tools we use to launch the network automatically is [polkadot-launch](https://github.com/paritytech/polkadot-launch.git) with some custom configuration.

- validator1 is listen to ws port: 9944
- validator2 is listen to ws port: 9955
- validator3 is listen to ws port: 9966

- parachain 200 is listen to ws port: 9988
- parachian300 is listen to ws port: 9999

> Note case binary file under polkadot-launch/bin is too large, so before build your own image contact me to get the right binary file.


# Build image

Run script ```build-image.sh``` or give a specific image name by runing

```sh
docker build -t <image name> .
```

# Run docker container by executing

```sh
docker run -it -p 127.0.0.1:9944:9944 -p 127.0.0.1:9988:9988 -p 127.0.0.1:9999:9999 --name crowdloan nutbox-crowdloan
```

## Launch parachain test network(same as Rococo)

```sh
cd polkadot-launch
yarn && yarn start config.json
```

This would automatically run three validators and register parachain 200 and parachain 300 as parathread. We can create auction and start crowdloan later.

# Connect to node with polkadot.js

- Browser [validator1](https://polkadot.js.org/apps/?rpc=ws%3A%2F%2F127.0.0.1%3A9944)

- Browser [parachain 200](https://polkadot.js.org/apps/?rpc=ws%3A%2F%2F127.0.0.1%3A9988)

- Browser [parachain 200](https://polkadot.js.org/apps/?rpc=ws%3A%2F%2F127.0.0.1%3A9999)