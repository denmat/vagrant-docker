# Building puppet master with Vagrant and Docker

This uses a docker container to build a puppet master from scratch.

Current status:
  * creates vagrant/docker host from oracle65 image
  * creates a puppetmaster with embedded puppetdb
  * has the ability to manage dns with dnsmasq though getting other hosts to see that is still an issue
  * can use docker --link to attach to puppet master though.

