# demo
Demo RSPEC Skeleton

## ADD TEST CASE:
    SPEC:  add 
	  it "test story: name" do
	    execute_test_case_1
	  end

	  
## NEW TEST SUITE:
    SPEC: (replace demo1 in all cases below)
        COPY/MODIFY: spec/demo1_spec.rb
        ADD: require_relative '../lib/demo1_helper'
    HELPER: (replace demo1 in all cases below)
        COPY/MODIFY: lib/demo1_helper.rb
    
## RAKE: 
    RAKEFILE: (copy existing and replace demo1 in all cases below)
         
## JENKINS: 
    (ADD BUILD STEP: Execute batch/shell)
    cd ./scripts/
    ruby run_rake_tests.rb
    (CREATE a CHOICE PARAMETER and enter default followed by list of component listed in rakefile)
    (ARCHIVE Artifact:  logs/*.html,logs/*.xml,logs/*.png)
    (ADD POSTBUILD: Publish JUnit test result report: logs/*.xml)
