# DEMO
API and UI Framework
  
## ADD NEW TEST SUITE:
    in scripts folder, execute/follow instructions from prompt:
    USAGE:  ruby create_new_test_suite <name> <api/ui>

## ADD TEST CASE / METHOD DEFINITION:
    SPEC:  add 
      it "test story: name" do
        execute_test_case_1 #put method definition in lib/*_helper.rb
      end

## EXECUTE TEST MANUALLY
    in spec folder, run with rspec (with or without )
      rpsec dashboard_spec.rb -e 'taskbar'

## RAKE: 
    RAKEFILE: (modify task default line)
      task :default => :regression, :newtestsuitename
         
## JENKINS: 
    (ADD BUILD STEP: Execute batch/shell)
    cd ./scripts/
    ruby run_rake_tests.rb
    (CREATE a CHOICE PARAMETER and enter default followed by list of component listed in rakefile)
    (ARCHIVE Artifact:  logs/*.html,logs/*.xml,logs/*.png)
    (ADD POSTBUILD: Publish JUnit test result report: logs/*.xml)
