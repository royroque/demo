puts @suite_name=ARGV[0]
if ARGV.size != 1
  puts 'Usage: script require 1 parameter to be passed (i.e. ruby create_new_test_suite wizard)'
  exit 1
end

## TODO:
## TODO: Copy ../spec/template_spec.rb 
## TODO: modify description : "Template Test Suites"
## TODO: modify require_relative: cfg and helper

## TODO: Copy ../lib/template_helper.rb 
## TODO:  modify module name: TemplateTasksHelper

## TODO: Copy ../config/template_cfg.rb 
## TODO: modify module name : TemplateConfig

## TODO: copy ../config/yml/template.yml 
## TODO: modify 

## TODO: modify rakefile