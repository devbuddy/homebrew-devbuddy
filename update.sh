#!/bin/sh
set -ex

cat devbuddy.rb.tmpl | sed "s/##VERSION##/${PROJECT_VERSION}/g" | sed "s/##REVISION##/${PROJECT_REVISION}/g" > devbuddy.rb
