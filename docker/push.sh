#!/usr/bin/env bash

AWS_PROFILE=mastodon
REGION_ID='ca-central-1'
ACCOUNT_ID=`aws sts get-caller-identity --profile ${AWS_PROFILE} | jq -r ".Account"`

echo "Using region ${REGION} with AWS account ${ACCOUNT_ID}"

echo "Logging in"
aws ecr get-login-password --region ${REGION_ID} --profile ${AWS_PROFILE} | docker login --username AWS --password-stdin ${ACCOUNT_ID}.dkr.ecr.${REGION_ID}.amazonaws.com

echo "Tagging mastodon_configured:latest as ${ACCOUNT_ID}.dkr.ecr.${REGION_ID}.amazonaws.com/mastodon_configured"
docker image tag mastodon_configured:latest ${ACCOUNT_ID}.dkr.ecr.${REGION_ID}.amazonaws.com/mastodon_configured

echo "Pushing"
docker push ${ACCOUNT_ID}.dkr.ecr.${REGION_ID}.amazonaws.com/mastodon_configured:latest