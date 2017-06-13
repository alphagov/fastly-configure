#!/usr/bin/env bash

set -e

git clone 'git@github.digital.cabinet-office.gov.uk:gds/cdn-configs.git'

cp cdn-configs/fastly/fastly.yaml .

git clone 'git@github.com:alphagov/govuk-cdn-config.git'
cd govuk-cdn-config
git checkout 'blue-box-ab-test'
cd ..

cp govuk-cdn-config/vcl_templates/*.vcl.erb vcl_templates/

bundle install --path "${HOME}/bundles/${JOB_NAME}"
bundle exec ./deploy_vcl ${vhost} ${ENVIRONMENT}
