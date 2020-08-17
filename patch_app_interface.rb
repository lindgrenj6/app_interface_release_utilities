#!/usr/bin/env ruby
# frozen_string_literal: true

require 'yaml'

raise 'I need to know where app-interface is, set it with APP_INTERFACE=/path/to/app-interface' unless ENV['APP_INTERFACE']
raise 'Which App should I patch? This should match the deploy.yml path in app-interface' unless ENV['APPLICATION']
raise 'Which Environment should I update? Usually stage or prod' unless ENV['ENV']

def app_info
  @app_info ||= YAML.safe_load(File.read('application_info.yml'))[ENV['APPLICATION']]
end

def shas
  @shas ||= begin
              # Get the SHAs from Github
              shas_raw = `REPOS='#{app_info['repos'].join(' ')}' PREFIX=#{app_info['prefix']} SEPARATOR="," BRANCH=#{ENV['BRANCH'] || 'stable'} bash lib/get_shas.sh`.lines.map(&:strip)

              shas_raw.map { |line| line.split(',') }.to_h
            end
end

def deploy
  @deploy ||= YAML.safe_load(File.read("#{ENV['APP_INTERFACE']}/data/services/insights/#{ENV['APPLICATION']}/deploy.yml"))
end

deploy['resourceTemplates'].each do |templ|
  target = templ['targets'].find { |target| target['namespace']['$ref'].end_with?("#{ENV['APPLICATION']}-#{ENV['ENV']}.yml") }

  # holy cow this is ugly
  tag = shas.delete(templ['name'].gsub('-', '_').sub("#{app_info['prefix']}_", ''))
  # TODO: don't edit the object and dump, it doesn't match the output. Just run sed to replace the current image tag with the new tag.
  target['parameters']['IMAGE_TAG'] = tag if tag
end

# TODO: warn if there are any shas left, (as there would be for approval)
File.write('/tmp/out.yml', deploy.to_yaml)
