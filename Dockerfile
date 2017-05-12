FROM ruby:2.4

# Add global dependencies
RUN apt-get update \
    && apt-get install -y apt-transport-https ca-certificates imagemagick libmagickwand-dev libfontconfig openssh-client rsync

# Add Docker engine
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D \
    && echo "deb https://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y docker-engine

# Add Node.js
RUN curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - \
    && echo "deb https://deb.nodesource.com/node_6.x jessie main" > /etc/apt/sources.list.d/nodesource.list \
    && apt-get update \
    && apt-get install -y nodejs \
    && ln -f -s /usr/bin/nodejs /usr/bin/node

# Add Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y yarn

# Install global Gulp
RUN yarn global add gulp

# Slim down image
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man/?? /usr/share/man/??_*

# Set the Docker host, because we're assuming we're using docker in docker.
ENV DOCKER_HOST "tcp://docker:2375"

# Expose Docker socket for Docker-in-Docker
VOLUME /var/run/docker.sock
