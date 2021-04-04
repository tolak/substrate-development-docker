
FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

# replace source.list
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak
ADD ./dockerfile.d/aliyun.source.conf /etc/apt/sources.list

# install dependencies
RUN apt update && apt upgrade -y && apt install -y autoconf automake build-essential cmake curl dpkg-dev expect  gcc-8 gdb git git-core libcurl4-openssl-dev libssl-dev libtool pkg-config vim wget software-properties-common apt-utils binutils-dev

# config llvm
ADD ./dockerfile.d/install-llvm.sh /root
RUN bash /root/install-llvm.sh

# config rust toolchain
ENV rust_toolchain  nightly-2021-03-25
ADD ./dockerfile.d/install-rust.sh /root
RUN bash /root/install-rust.sh
RUN /root/.cargo/bin/rustup install ${rust_toolchain}
RUN /root/.cargo/bin/rustup default ${rust_toolchain}
RUN /root/.cargo/bin/rustup target add wasm32-unknown-unknown --toolchain ${rust_toolchain}
ENV PATH=$PATH:$HOME/.cargo/bin

# config node
RUN apt install nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update && apt install yarn

# run validators and collators
ADD ./polkadot-launch /root

WORKDIR /root

# validators
EXPOSE 9944
EXPOSE 9955
EXPOSE 9966
EXPOSE 9977
# collators
EXPOSE 9988
EXPOSE 9999
