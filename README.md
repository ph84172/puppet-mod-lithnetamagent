# puppet-mod-lithnetamagent

#### Table of Contents

1. [Module Description - What the module does and why it is useful](#module-description)
1. [Setup - The basics](#setup)
   * [What this module does](#what-this-module-does)
   * [Setup requirements](#setup-requirements)
   * [Beginning with the module](#beginning-with-the-module)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)

## Module description

This Puppet module manages the agent component of [Lithnet Access Manager](https://lithnet.io/products/access-manager).

## Setup

### What this module does

Installs the Lithnet Access Manager agent package.  Optionally registers the agent with the AMS server.

### Setup requirements

If using the registration feature, an active Lithnet AMS server is required, configured with support for Lithnet LAPS and registration of clients using keys.  More information can be found in the [Setting up Lithnet LAPS](https://docs.lithnet.io/ams/configuration/deploying-features/setting-up-lithnet-laps) section of the documentation.

### Beginning with the module

Include the main 'lithnetamagent' class.

## Usage

To simply install the agent without any further actions, just include the main 'lithnetamagent' class.

To enable agent registration, set the following params via module args / hiera:

 - `register_agent`: true/false
 - `ams_server`: [ip/hostname]
 - `reg_key`: [key string]

## Limitations

Currently only supports RHEL/CentOS 7, 8 & 9.
