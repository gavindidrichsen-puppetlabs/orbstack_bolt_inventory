# How to setup a basic dynamic inventory plugin

## Description

The following shows how to create a bare-bones bolt inventory plugin.  The inventory is hardcoded in this example but could just as easily proxy out to something else to generate the required inventory.

## Pre-requisites

First, refer to the [Environment Setup Guide](setup_environment.md) and then accordingly configure [orbstack](https://docs.orbstack.dev).

## Basic Use

```bash
# create a new directory
mkdir my_plugin
cd my_plugin

# initialize this as a bolt project
cat << 'EOL' > bolt-project.yaml
---
name: usage
modules: []
EOL

# verify bolt is working as expected
bolt command run "hostname" --targets=localhost

# verify bolt inventory works fine against expected orbstack VMs
cp inventory.yaml.orbstack > inventory.yaml
bolt inventory show
bolt command run "hostname" --targets=all

rm -f inventory.yaml
```

Now use the plugin:

```bash
# create an inventory.yaml expecting a the _plugin: basic_plugin
cat << 'EOL' > inventory.yaml
version: 2
_plugin: basic_plugin
EOL

# the following should fail because no plugin yet!
bolt inventory show
```

Now implement the plugin

```bash
# create the 'basic_plugin' module directory
mkdir -p modules/basic_plugin

# initialize this as a bolt "plugin"
cat << 'EOL' > modules/basic_plugin/bolt_plugin.json
{
  "name": "basic_plugin",
  "version": "0.1.0",
  "description": "A Bolt dynamic inventory plugin for Orbstack VMs",
  "tasks": {
    "resolve_reference": "tasks/resolve_reference.rb"
  }
}
EOL

# create the 'resolve_reference' task
mkdir -p modules/basic_plugin/tasks

# first the metadata:
cat << 'EOL' > modules/basic_plugin/tasks/resolve_reference.json
{
  "description": "Resolve targets for Orbstack inventory",
  "input_method": "stdin",
  "parameters": {}
}
EOL

# then the resolve_referenc.rb
cat << 'EOL' > modules/basic_plugin/tasks/resolve_reference.rb
#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
require 'yaml'

# Load inventory.yaml
yaml_data = """
---
config:
  transport: ssh
  ssh:
    native-ssh: true
    load-config: true
    login-shell: bash
    tty: false
    host-key-check: false
    run-as: root
    user: root
    port: 32222
targets:
- name: agent01
  uri: agent01@orb
- name: agent02
  uri: agent02@orb
- name: agent03
  uri: agent03@orb
- name: compiler01
  uri: compiler01@orb
- name: compiler02
  uri: compiler02@orb
"""

# convert YAML to a Ruby hash
hash = YAML.load(yaml_data)

# wrap in 'value' key as expected by Bolt pluginis
result = { 'value' => hash }
puts result.to_json
EOL

bolt inventory show
bolt command run "hostname" --targets=all
```

## Appendix

### Basic Use Output

```bash

```
