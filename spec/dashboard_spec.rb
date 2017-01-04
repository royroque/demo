require_relative '../shared/watir_helper'
require_relative '../config/dashboard_cfg'
require_relative '../lib/dashboard_helper'

describe "Dashboard Test Suites" do

  before(:each) do
    open_browser
    initialize_instance_variables
  end
  after(:each) do |tc|
    take_screenshot if (tc.exception != nil || tc.instance_variable_get("@exception") != nil )
    close_all_windows
  end

  it "test story 1" do
    browser.goto('http://34.194.147.229/:8880/')
  end

end
