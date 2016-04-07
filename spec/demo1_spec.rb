require_relative '../shared/watir_helper'
require_relative '../config/env_cfg'
require_relative '../lib/generic_helper'
require_relative '../lib/demo1_helper'

describe "Component: Demo 1" do

  before(:all) do
    @profile=load_profile_from_config_yml('profiles.yml','user1')
    open_browser
  end

  after(:all) do 
    close_all_windows
  end

  it "Story 1" do
    browser.goto('http://google.com')
    run_demo1_task_1
  end

end



