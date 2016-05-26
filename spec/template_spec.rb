require_relative '../shared/watir_helper'
require_relative '../config/template_cfg'
require_relative '../lib/template_helper'

describe "Template Tasks" do

  before(:all) { open_browser }
  after(:all) { close_all_windows }
  after(:each) { |tc| take_screenshot if (tc.exception != nil || tc.instance_variable_get("@exception")) != nil }

  it "test create template test" do
    #===================================================#  
    pending('test case still work in progress')
    fail
    #===================================================#
  end
  
end



