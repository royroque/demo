require_relative '../shared/watir_helper'
require_relative '../config/demo1_cfg'
require_relative '../lib/demo1_helper'

describe "Suite Demo" do

  before(:all){ open_browser }
  after(:all) { close_all_windows }
  after(:each) { |tc| take_screenshot if (tc.exception != nil || tc.instance_variable_get("@exception")) != nil }

  it "test story 1" do
    @profile=load_profile_from_config_yml('profiles.yml','user1')
    
    browser.goto(@profile[:url])
    execute_test_case_1
  end

end



