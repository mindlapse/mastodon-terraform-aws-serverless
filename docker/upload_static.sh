#!/usr/bin/env bash

if [[ ! -n "$1" ]]; then
    echo "Usage: ./upload_static.sh <s3://bucketname>"
fi

rm -rf ./public
docker cp mastodon_config:/opt/mastodon/public/ ./

echo "Uploading `pwd`/public to $1/"
aws s3 cp `pwd`/public "$1" --recursive

