FROM camptocamp/mcollectived:2.10.2-2

# Install git
RUN apt-get update \
  && apt-get install -y git \
  && rm -rf /var/lib/apt/lists/*

# Install r10k
ENV R10K_VERSION='95ba8b8'
RUN gem install specific_install --no-ri --no-rdoc \
  && gem specific_install -l https://github.com/puppetlabs/r10k.git -b $R10K_VERSION

# Configure .ssh directory
RUN mkdir /root/.ssh \
  && chmod 0600 /root/.ssh \
  && echo StrictHostKeyChecking no > /root/.ssh/config

# Configure volumes
VOLUME ["/opt/puppetlabs/r10k/cache/", "/etc/puppetlabs/code/environments"]
