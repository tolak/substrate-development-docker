
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# RUN cp /etc/apt/sources.list /etc/apt/sources.list.bk
# ADD ./dockerfile.d/sources.list /etc/apt/

# install dependencies
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y autoconf automake bison build-essential cmake curl dpkg-dev expect flex gcc g++ gdb git git-core gnupg kmod libboost-system-dev libboost-thread-dev libcurl4-openssl-dev libiptcdata0-dev libjsoncpp-dev liblog4cpp5-dev libprotobuf-dev libssl-dev libtool libxml2-dev ocaml ocamlbuild pkg-config protobuf-compiler python sudo systemd-sysv texinfo uuid-dev vim ca-certificates wget software-properties-common lsb-release apt-utils binutils-dev

# config llvm
ADD ./dockerfile.d/install-llvm.sh /root
RUN bash /root/install-llvm.sh

# config rust toolchain
ENV rust_toolchain  nightly-2022-04-01
ADD ./dockerfile.d/install-rust.sh /root
# ADD ./dockerfile.d/rustup-init /root
RUN bash /root/install-rust.sh
RUN /root/.cargo/bin/rustup install ${rust_toolchain}
RUN /root/.cargo/bin/rustup default ${rust_toolchain}
RUN /root/.cargo/bin/rustup target add wasm32-unknown-unknown --toolchain ${rust_toolchain}
ENV PATH=$PATH:$HOME/.cargo/bin

# config node
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get -y install nodejs \
    && npm install --global yarn typescript

# add polkadot-launch & binary
ADD ./polkadot-launch /root/polkadot-launch

WORKDIR /root

# export ports
EXPOSE 9000-20000
