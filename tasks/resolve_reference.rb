#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
require 'yaml'

# Load YAML from a file or string
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

# Convert YAML to a Ruby hash
hash = YAML.load(yaml_data)
result = { 'value' => hash }
puts result.to_json

exit 0
# Generate the inventory and output the result
begin
  # Wrap the inventory result in a 'value' key as expected by Bolt
  result = { 'value' => hash }
  puts result.to_json
rescue StandardError => e
  warn({ _error: { msg: e.message, kind: 'bolt/plugin-error' } }.to_json)
  exit 1
end
