FROM ubuntu:22.04

RUN apt-get update && apt-get -y install
RUN apt-get install -y curl wget gnupg apt-transport-https lsb-release ca-certificates
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
  imagemagick ffmpeg libpq-dev libxml2-dev libxslt1-dev file git-core \
  g++ libprotobuf-dev protobuf-compiler pkg-config nodejs gcc autoconf \
  bison build-essential libssl-dev libyaml-dev libreadline6-dev \
  zlib1g-dev libncurses5-dev libffi-dev libgdbm-dev \
  certbot libidn11-dev libicu-dev libjemalloc-dev
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv
RUN cd ~/.rbenv && src/configure && make -C src
RUN echo 'export PATH="/root/.rbenv/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
RUN echo $HOME
ENV PATH="/root/.rbenv/shims:/root/.rbenv/bin:$PATH"
RUN git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN rbenv install 3.0.4
RUN rbenv global 3.0.4
RUN gem install bundler
RUN git clone https://github.com/mastodon/mastodon.git live

RUN cd live && git checkout $(git tag -l | grep -v 'rc[0-9]*$' | sort -V | tail -n 1) && \
    bundle config deployment 'true' && \
    bundle config without 'development test' && \
    bundle install -j$(getconf _NPROCESSORS_ONLN)
RUN corepack enable
RUN yarn install --pure-lockfile
#RUN RAILS_ENV=production exec bash && bundle exec rake mastodon:setup
