#!/usr/bin/env bash

set -e

git clone -b multivariate-tests 'git@github.com:alphagov/cdn-configs.git'

cp cdn-configs/fastly/fastly.yaml .

git clone -b dynamic-multivariate-vcl-template 'git@github.com:alphagov/govuk-cdn-config.git'

cp govuk-cdn-config/vcl_templates/*.vcl.erb vcl_templates/

bundle install --path "${HOME}/bundles/${JOB_NAME}"
bundle exec ./deploy_vcl ${vhost} ${ENVIRONMENT}
