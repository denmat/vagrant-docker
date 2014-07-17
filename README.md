# Building puppet master with Vagrant and Docker

This uses a docker container to build a puppet master from scratch.

This is a copy of a private repository that is being worked on.
    
Current status:
  * creates vagrant/docker host from oracle65 image
  * creates a puppetmaster with embedded puppetdb
  * has the ability to manage dns with dnsmasq
  * one caveat - haven't got a workaround for this issue:
    https://github.com/dotcloud/docker/issues/1951


