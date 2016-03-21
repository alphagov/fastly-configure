#!/usr/bin/env bash

git clone 'git@github.gds:gds/cdn-configs.git'

cp cdn-configs/fastly/fastly.yaml .
cp cdn-configs/fastly/vcl_templates/* vcl_templates/

bundle install --path "${HOME}/bundles/${JOB_NAME}"
bundle exec ./deploy_vcl ${vhost} ${ENVIRONMENT}
