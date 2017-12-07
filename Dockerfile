# bitcoin-testnet-box docker image

# Ubuntu 14.04 LTS (Trusty Tahr)
FROM ubuntu:14.04
MAINTAINER Sean Lavine <lavis88@gmail.com>

# add bitcoind from the official PPA
RUN apt-get update
RUN apt-get install --yes software-properties-common
RUN add-apt-repository --yes ppa:bitcoin/bitcoin
RUN add-apt-repository --yes ppa:ondrej/php
RUN apt-get update

# install bitcoind (from PPA) and make
RUN apt-get install --yes bitcoind make

# UmerCommands
RUN apt-get install --yes --force-yes bitcoin-qt

#install VIM
RUN apt-get install --yes --force-yes vim

# install PHP 5.6
RUN apt-get install --yes --force-yes php5.6

RUN apt-get install --yes --force-yes curl
RUN apt-get install --yes --force-yes php5-gd
RUN apt-get install --yes --force-yes php5-mcrypt
RUN apt-get install --yes --force-yes openssl
RUN apt-get install --yes --force-yes libpcre3 libpcre3-dev
RUN apt-get install --yes --force-yes git




# create a non-root user
RUN adduser --disabled-login --gecos "" tester

RUN usermod -aG sudo tester

# run following commands from user's home directory
WORKDIR /home/tester

# copy the testnet-box files into the image
ADD . /home/tester/bitcoin-testnet-box

# make tester user own the bitcoin-testnet-box
RUN chown -R tester:tester /home/tester/bitcoin-testnet-box

# use the tester user when running the image
#USER tester

# run commands from inside the testnet-box directory
WORKDIR /home/tester/bitcoin-testnet-box

# expose two rpc ports for the nodes to allow outside container access
EXPOSE 19001 19011
CMD ["/bin/bash"]
