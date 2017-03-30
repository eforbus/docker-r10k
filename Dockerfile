FROM camptocamp/mcollectived:2.9.1-1

MAINTAINER mickael.canevet@camptocamp.com

# Install git
RUN apt-get update \
  && apt-get install -y git \
  && rm -rf /var/lib/apt/lists/*

# Install r10k
ENV R10K_VERSION='2.5.2'
RUN gem install r10k --version $R10K_VERSION --no-ri --no-rdoc

# Configure .ssh directory
RUN mkdir /root/.ssh \
  && chmod 0600 /root/.ssh \
  && echo StrictHostKeyChecking no > /root/.ssh/config

# Configure volumes
VOLUME ["/opt/puppetlabs/r10k/cache/", "/etc/puppetlabs/code/environments"]
