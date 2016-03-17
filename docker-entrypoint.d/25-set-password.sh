#!/bin/sh

sed -i -e "s/^\(plugin.activemq.pool.1.password = \).*$/\1$MCOLLECTIVE_PASSWORD/" /etc/puppetlabs/mcollective/server.cfg
