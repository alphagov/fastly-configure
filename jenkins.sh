#!/usr/bin/env bash

git clone 'git@github.gds:gds/cdn-configs.git'

cp cdn-configs/fastly/fastly.yaml .

git clone 'git@github.com:alphagov/govuk-cdn-config.git'

cp govuk-cdn-config/vcl_templates/*.vcl.erb vcl_templates/

bundle install --path "${HOME}/bundles/${JOB_NAME}"
bundle exec ./deploy_vcl ${vhost} ${ENVIRONMENT}
