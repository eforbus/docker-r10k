#!/bin/bash

cp /etc/puppetlabs/puppet/ssl/private_keys/$(hostname -f).pem /root/.ssh/id_rsa
