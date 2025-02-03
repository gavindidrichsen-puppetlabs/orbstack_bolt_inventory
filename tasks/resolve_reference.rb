#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
require 'yaml'
require 'optparse'

# Parse command line options
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: resolve_reference.rb [options]"
  opts.on('-y', '--yaml', 'Output in YAML format') do |y|
    options[:yaml] = y
  end
end.parse!

# create a valid yaml bolt inventory
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
groups:
- name: agent
  facts:
    role: agent
  targets:
  - agent01
  - agent02
  - agent03
- name: compiler
  facts:
    role: compiler
  targets:
  - compiler01
  - compiler02
"""

# convert YAML to a ruby hash
hash = YAML.load(yaml_data)
result = { 'value' => hash }

if options[:yaml]
  puts hash.to_yaml
else
  puts result.to_json
end
