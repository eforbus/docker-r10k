FROM debian:jessie

MAINTAINER mickael.canevet@camptocamp.com

ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8

ENV PATH=/opt/puppetlabs/puppet/bin:/opt/puppetlabs/bin:$PATH

# Install puppet-agent
ENV RELEASE jessie
RUN apt-get update \
  && apt-get install -y curl locales-all \
  && curl -O http://apt.puppetlabs.com/puppetlabs-release-pc1-${RELEASE}.deb \
  && dpkg -i puppetlabs-release-pc1-${RELEASE}.deb \
  && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
  && apt-get install -y puppet-agent \
  && rm -rf /var/lib/apt/lists/*

# Configure mcollectived
RUN sed -i -e 's/stomp1/activemq/' -e 's/6163/61613/' /etc/puppetlabs/mcollective/server.cfg \
  && echo logger_type = console >> /etc/puppetlabs/mcollective/server.cfg

COPY plugins/ /opt/puppetlabs/mcollective/plugins/

# Install git
RUN apt-get update \
  && apt-get install -y git \
  && rm -rf /var/lib/apt/lists/*

# Install r10k
ENV R10K_VERSION='2.2.0'
RUN gem install r10k --version $R10K_VERSION --no-ri --no-rdoc

# Configure .ssh directory
RUN mkdir /root/.ssh \
  && chmod 0600 /root/.ssh \
  && echo StrictHostKeyChecking no > /root/.ssh/config

# Configure volumes
VOLUME ["/opt/puppetlabs/r10k/cache/", "/etc/puppetlabs/code/environments"]

# Configure entrypoint
COPY /docker-entrypoint.sh /
COPY /docker-entrypoint.d/* /docker-entrypoint.d/
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/opt/puppetlabs/puppet/bin/mcollectived", "--no-daemonize"]
