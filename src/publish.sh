#!/bin/bash

LAYER_NAME=openssl-lambda
REGION=us-east-1

# Publish the Lambda layer in the us-east-1 region
VERSION_NUMBER=$(aws lambda publish-layer-version --region $REGION --layer-name $LAYER_NAME \
  --zip-file fileb://layer/layer.zip --cli-read-timeout 0 --cli-connect-timeout 0 \
  --description "OpenSSL binaries for Amazon Linux 2 Lambdas" --query Version --output text)

# Add a permission to the layer version to keep it private (omit if already private by default)
aws lambda add-layer-version-permission --region $REGION --layer-name $LAYER_NAME \
  --statement-id sid1 --action lambda:GetLayerVersion --version-number $VERSION_NUMBER
