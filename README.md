# puppet-marmoset

## Table of Contents

1. [Overview](#overview)
2. [Usage](#usage)

## Overview

This module manages the [marmoset](https://github.com/virtapi/marmoset#marmoset).
Marmoset provides HTTP APIs for automating the isc-dhcpd, pxelinux and
installimage. This puppet module fetches the source files as git repo from
github. Afterwards a virtualenv is created to install all needed python deps.

## Usage

The main class provides several options to customize the setup:

### Setup Options

* `sourcerepo`: git url to the repo, defaults to github
* `http_proxy`: Optional http proxy for downloading pypi packages
* `servername`: FQDN marmoset will accept
* `port`: Port marmoset will listen on
* `host`: IP address marmoset will bind to
* `usernamer`: Marmoset will run with this user
* `groupname`: Marmoset wil run with this group
* `home`: Homedir of the user
* `vcsrepo`: Path to the dir where marmoset will be cloned
* `pyenv`: Path to the virtualenv used by marmoset
* `requirements`: Path to requirements.txt with additional marmoset deps
* `manage_python`: Boolean, if true (default) this module will install python

### LDAP Settings

slapd us required as a ldap backend for isc-dhcpd. marmoset needs access to
slapd to write records.

* `ldap_bind_dn`: Bind url for slapd for connections
* `ldap_password`: Password to access slapd
* `ldap_client_base_dn`: DN for operations
* `ldap_server`: Server where slapd is running
* `ldap_port`: Port where slapd is listening

### API Access

You need to configure a password and username for people to access marmoset

* `auth_password`: Password for user authentication
* `auth_username`: Username for user authentication
