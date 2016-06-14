# Fastly Configure

A utility to configure the [Fastly CDN](https://fastly.com) from version-controllable VCL and
YAML files, using Fastly's [API](https://docs.fastly.com/api/).

## Prerequisites

To run Fastly Configure, you'll need:

  - Ruby 2.1.8 or later
  - Bundler 1.5.3 or later
  - a Fastly account

The ability to upload custom VCL is not turned on for accounts by default.
To enable it, contact Fastly's support team.

## Usage

### Installing

This script makes use of a few third-party Gems. Before running this script,
you'll need to install the Gems listed in the Gemfile. The easiest way to do
this is with Bundler:

```
bundle install
```

### Authentication

You need to set two environment variables to help this script connect to the
Fastly API:

  - FASTLY_USER
  - FASTLY_PASS

Due to API restrictions, you can't currently use an account that has
two-factor authentication enabled with this script.

### Service configuration

Service configuration is passed in to the script using a YAML file, which
must live at `fastly.yaml`. You can find an example in `fastly.yaml` in this
repository. Additional configuration parameters can also be set in this
file to enable the use of ERB look-ups in the VCL.

### VCL

Your VCL script should be stored as an ERB template in `/vcl_templates`. The
VCL file should be named the same as the `configuration`.

## Contributing

1. Fork it.
2. Create a feature branch.
3. Commit your changes.
4. Push to the new branch.
5. Create a pull request.
