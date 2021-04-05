
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# install dependencies
RUN apt update && apt upgrade -y && apt install -y autoconf automake bison build-essential cmake curl dpkg-dev expect flex gcc g++ gdb git git-core gnupg kmod libboost-system-dev libboost-thread-dev libcurl4-openssl-dev libiptcdata0-dev libjsoncpp-dev liblog4cpp5-dev libprotobuf-dev libssl-dev libtool libxml2-dev ocaml ocamlbuild pkg-config protobuf-compiler python sudo systemd-sysv texinfo uuid-dev vim wget software-properties-common lsb-release apt-utils binutils-dev

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
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt install -y nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update && apt install -y yarn

# run validators and collators
ADD ./polkadot-launch /root/polkadot-launch

WORKDIR /root

# validators
EXPOSE 9944
EXPOSE 9955
EXPOSE 9966
EXPOSE 9977
# collators
EXPOSE 9988
EXPOSE 9999
