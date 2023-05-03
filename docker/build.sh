#!/usr/bin/env bash

# prerequisites: git, docker, jq

AWS_PROFILE=mastodon
REGION_ID='ca-central-1'
ACCOUNT_ID=`aws sts get-caller-identity --profile ${AWS_PROFILE} | jq -r ".Account"`

echo "Using region ${REGION} with AWS account ${ACCOUNT_ID}"

docker build -f Dockerfile.rubybase -t rubybase .
mkdir ./mastodon
git clone https://github.com/mindlapse/mastodon.git ./mastodon
sudo docker buildx build -t mastodon -f Dockerfile ./mastodon

# When this script first runs, the setup walkthrough will ask a series of questions to generate a .env.production file.
# This file is extracted from the container and saved locally.  Subsequent runs of this script will check for this file
# and if it is present then the interactive setup is skipped and the .env.production file is used.  If you wish to start
# over and proceed through the interactive setup, simply remove or rename the .env.production file.

docker rm -f mastodon_config  # if it exists
KEEP_GOING=true
if [[ ! -f "./.env.production" ]]; then
    echo -e "\nStarting interactive setup\n"
    docker run -it --workdir /opt/mastodon --name=mastodon_config mastodon bundle exec rake mastodon:setup
    [[ $? -ne 0 ]] && echo -e "\n.env.production was not generated. Aborting\n" && KEEP_GOING=false
    
else
    echo -e "\nUsing existing .env.production\n"
    docker create --name mastodon_config mastodon
    docker cp ./.env.production mastodon_config:/opt/mastodon/.env.production
    [[ $? -ne 0 ]] && echo -e "\nError copying in .env.production. Aborting\n" && KEEP_GOING=false
fi

docker commit mastodon_config mastodon_configured
docker image tag mastodon_configured:latest ${ACCOUNT_ID}.dkr.ecr.${REGION_ID}.amazonaws.com/mastodon_configured


if [ "$KEEP_GOING" = true ]; then
    # build the sidekiq, streaming, and web images
    docker commit mastodon_config mastodon_local
    echo -e "\nBuilding mastodon_web .........\n" && docker build -f Dockerfile.web -t mastodon_web . && \
    echo -e "\nBuilding mastodon_sidekiq .....\n" && docker build -f Dockerfile.sidekiq -t mastodon_sidekiq . && \
    echo -e "\nBuilding mastodon_streaming ...\n" && docker build -f Dockerfile.streaming -t mastodon_streaming .
fi



