#!/bin/bash

if getent hosts rancher-metadata > /dev/null ; then
  cp /etc/puppetlabs/puppet/ssl/private_keys/$(curl http://rancher-metadata/latest/self/container/uuid 2> /dev/null).pem /root/.ssh/id_rsa
fi
