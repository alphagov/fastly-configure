# Fastly Configure

Fastly Configure is a utility to configure the [Fastly
CDN](https://fastly.com) from version-controllable VCL. Under the hood, we
use YAML for setting configuration options and then package everything up to
talk to the [Fastly API](https://docs.fastly.com/api) in order to:

  - validate your VCL syntax
  - deploy your new VCL configuration
  - show a diff between the previous configuration and the new one
  - activate the new configuration, assuming there were no validation errors

Using Fastly Configure, the VCL you write should become your configuration's
source of truth, rather than the Fastly UI.

## Prerequisites

Before beginning, you'll need:

  - Ruby 2.0.0 or later
  - Bundler 1.5.3 or later
  - a Fastly account
  - a Fastly user without 2FA enabled

## Installation

We make use of a few third-party Gems, so before running Fastly Configure,
go fetch them by running Bundler against the enclosed Gemfile:

```
bundle install
```

Next, if you haven't already done so, contact Fastly's support team and ask
them to allow custom-written VCL to be enabled on your account. VCL will be
come the source of truth for your Fastly configuration.

Finally, [log in](https://app.fastly.com) to your Fastly account, and
download the automatically-generated VCL from your existing service:

  - click the Configure tab along the top
  - choose the service from the dropdown list
  - click the Configure button
  - click VCL along the top
  - click Download at the top right of the page

You should place this inside `vcl_templates`, and name it something
appropriate since its name will dictate how you deploy to this service in
future.

Since naming can be hard, let's use an example. I have two Fastly services
created - `api-uat` and `api-production` - and I wish to configure VCL for both using
Fastly Configure. I would download the pre-generated VCL from Fastly for
each service in to `vcl_templates/` as `api-uat.vcl.erb` and `api-production.vcl.erb`.
When I come to deploy in future, the value of `configuration` as referenced
in this script becomes `api`, and the value of `environment` becomes `uat`
or `production` depending what I'm deploying.

## Configuration

Now that we're all set up, we can create a YAML file to describe
configuration settings. You can use the file to create both ERB variable
values, but at a very minimum, you need to set a required parameter -
`service_id`. This YAML file must exist at `fastly.yaml` in the root of the
directory where you've cloned this repository. There's an example thrown in
to get you started.

### Required parameters

The only required parameter is `service_id` which you can find in the Fastly
UI inside your service's configuration. It's a long alphanumeric string.
Pass this in as a string, for instance:

```
---
- api
  - uat
    - service_id: a1b2c3d4e5f6g7h8i9
  - production
    - service_id: z1y2x3w4v5u6t7s8r9
```

### Optional parameters

Optionally, if you're using ERB lookups inside your VCL, you can set the
values inside your YAML. This means that the YAML can become the source of
all of your secrets whilst the VCL can be opened up more widely, for
instance.

You could, for example, set the value of a particular HTTP header depending
on what the value of the environment you run Fastly Configure with. This can
be done using:

```
<% if environment == "uat" %>
  set req.http.host = "staging.domain.com"
<% end %>
```

## Running Fastly Configure

After running through the above steps, you can run Fastly Configure to start
using your version-controlled VCL as the source of truth for your Fastly
configuration!

### Authentication

As mentioned above in the prerequisites, you'll need to make sure that you
have a Fastly user without two-factor authentication which you can use to
authenticate with the Fastly API. Due to limitations with the Fastly API,
you can't currently use a user which has two-factor authentication enabled.

To authenticate, set two environment variables. If you're running this in
your shell, you can set them easily using:

```
$  export FASTLY_USER=<username>
$  export FASTLY_PASS=<passphrase>
```

The space before the `export` command is intentional, as it stops the
credentials being saved in your bash history.

Alternatively, if you're running them in a CI environment such as Jenkins or
TeamCity, set the two environment variables using the appropriate mechanism.

### Get going!

Fastly Configure can be run as follows:

```
bundle exec ./deploy_vcl <configuration> <environment>
```

So, to bring back our example of using `api` as the configuration with two
environments - `uat` and `production` - we would use either:

```
bundle exec ./deploy_vcl api uat
```

or

```
bundle exec ./deploy_vcl api production
```

The script will return the version number of the currently-deployed
configuration, diff it against your new VCL, upload the new VCL, provide a
version number, run a syntax check against it and - assuming no syntax or
other errors - activate the new VCL. Since activation is automated, this is
why it's useful to have the concept of environments.

## Contributing

We're always very grateful for contributions, and thank you in advance for
considering contributing. Our standard procedure for contributions is:

  1. Fork this repository
  2. Create a feature branch.
  3. Commit your changes.
  4. Push to the new branch.
  5. Create a pull request against this repository.
