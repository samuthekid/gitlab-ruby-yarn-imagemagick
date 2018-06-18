FROM ruby:2.5.1


# Add global dependencies
RUN apt-get update \
    && apt-get install -y apt-transport-https ca-certificates imagemagick libmagickwand-dev libfontconfig rsync

RUN apt-get update \
    && apt-get install -y openssh-client

RUN \
    curl -sL https://deb.nodesource.com/setup_7.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -y --force-yes --no-install-recommends nodejs yarn


# Slim down image
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man/?? /usr/share/man/??_*

