# Usage: ./run.sh [dev]
# Params:
#       dev     Set RAILS_ENV to 'development' when starting the container

RAILS_ENV=$([[ "$1" = 'dev' ]] && echo 'development' || echo 'production')

docker run -it -p 3000:3000 -e WEB_DOMAIN="localhost" -e RAILS_ENV=$RAILS_ENV mastodon_configured bundle exec puma -C config/puma.rb

# docker run -it -p 3000:3000 mastodon_configured ls /opt/mastodon
