# demo
Demo RSPEC Skeleton



## NEW TEST SUITE:
    SPEC: (replace demo1 in all cases below)
        COPY/MODIFY: spec/demo1_spec.rb
        ADD: require_relative '../lib/demo1_helper'
    HELPER: (replace demo1 in all cases below)
        COPY/MODIFY: lib/demo1_helper.rb
    
## RAKE: 
    RAKEFILE: (replace demo1 in all cases below)
        RSpec::Core::RakeTask.new("#{(product='demo1').to_sym}") do |t|
        task :default => [:demo1]
  
## JENKINS: set build command as follows:
    cd ./scripts/
    ruby run_rake_tests.rb



TEST ONLY