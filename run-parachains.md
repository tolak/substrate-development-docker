# Steps To Run Parachains

We launched three polkadot validators and two parachains with paraid 1001 and 1002. The tools we use to launch the network automatically is [polkadot-launch](https://github.com/paritytech/polkadot-launch.git) with some custom configuration.



## Start Container

Execute command

```sh
docker run -it -p 127.0.0.1:9944:9944 -p 127.0.0.1:9988:9988 -p 127.0.0.1:9999:9999 --name parachains tolak/substrate-development:v0.2.0
```

## Start Validators and Parachains

Execute command inside docker container

```sh
cd polkadot-launch
yarn && yarn start config.json
```

This would start three validators and two parachains:

- validator1 is listen to ws port: 9944
- validator2 is listen to ws port: 9955
- validator3 is listen to ws port: 9966

- parachain 1001 is listen to ws port: 9111
- parachian 1002 is listen to ws port: 9222

## Connect to node with polkadot.js

- Browser [validator1](https://polkadot.js.org/apps/?rpc=ws%3A%2F%2F127.0.0.1%3A9944)

- Browser [parachain 1001](https://polkadot.js.org/apps/?rpc=ws%3A%2F%2F127.0.0.1%3A9988)

- Browser [parachain 1002](https://polkadot.js.org/apps/?rpc=ws%3A%2F%2F127.0.0.1%3A9999)
