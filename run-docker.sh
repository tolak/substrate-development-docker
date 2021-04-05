#!/bin/bash

# expose ports of one validator and two collator
docker run -it -p 9944:9944 -p 9988:9988 -p 9999:9999 --name crowdloan nutbox-crowdloan