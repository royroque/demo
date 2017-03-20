require_relative '../../shared/watir_helper'
require_relative '../../config/ui/template_cfg'
require_relative '../../lib/ui/template_helper'

describe "Template Test Suites" do

  before(:each) do
    open_browser
    initialize_instance_variables
    # login_to_application
  end
  after(:each) do |tc|
    take_screenshot if (tc.exception != nil || tc.instance_variable_get("@exception") != nil )
    close_all_windows
  end

  it "test create template test" do
    #===================================================#
    pending('test case still work in progress')
    fail
    #===================================================#
  end

end
