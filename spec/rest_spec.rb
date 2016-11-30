require_relative '../shared/watir_helper'
require_relative '../config/rest_cfg'
require_relative '../lib/rest_helper'

describe "REST Test Suites" do

  before(:each) do
    initialize_instance_variables
  end

  it "create customer record" do    
    @source_file =  File.expand_path(File.dirname(__FILE__) + '/../resource/customer.json-ORIG')
    @target_file = File.expand_path(File.dirname(__FILE__) + '/../resource/customer.json')
    @uri_path = @uri + "ProvAppCLService/entitytree/Customer"

    5000.times do |i|
      FileUtils.cp_r @source_file, @target_file
    
      modify_string_in_file(@target_file, '<REPLACE_FIRST_NAME>', Faker::Name.first_name)
      modify_string_in_file(@target_file, '<REPLACE_LAST_NAME>', Faker::Name.last_name)
      modify_string_in_file(@target_file, '<REPLACE_TAXID>', Faker::Company.ein)
      modify_string_in_file(@target_file, '<REPLACE_COMP_NAME>', Faker::Company.name)
      rest_post(@uri_path, @target_file)
      FileUtils.rm_rf @target_file
    end
  end

  it "create request record" do    
    @source_file =  File.expand_path(File.dirname(__FILE__) + '/../resource/request.json-ORIG')
    @target_file = File.expand_path(File.dirname(__FILE__) + '/../resource/request.json')
    @uri_path = @uri + "ProvAppCLService/entitytree/Request"

    5000.times do |i|
      FileUtils.cp_r @source_file, @target_file
    
      modify_string_in_file(@target_file, '<REPLACE_NAME>', Faker::Commerce.product_name)
      modify_string_in_file(@target_file, '<REPLAEC_AGENT_NAME>', Faker::Name.name)
      rest_post(@uri_path, @target_file)
      FileUtils.rm_rf @target_file
    end
  end

  it "create transaction record" do    
    @source_file =  File.expand_path(File.dirname(__FILE__) + '/../resource/transaction.json-ORIG')
    @target_file = File.expand_path(File.dirname(__FILE__) + '/../resource/transaction.json')
    @uri_path = @uri + "ProvAppCLService/entitytree/Transaction"

    5000.times do |i|
      FileUtils.cp_r @source_file, @target_file
    
      modify_string_in_file(@target_file, '<REPLACE_TYPE_ID>', Faker::Company.buzzword)
      modify_string_in_file(@target_file, '<REPLACE_NAME>', Faker::Company.catch_phrase)
      rest_post(@uri_path, @target_file)
      FileUtils.rm_rf @target_file
    end
  end

  it "create collateral record" do    
    @source_file =  File.expand_path(File.dirname(__FILE__) + '/../resource/collateral.json-ORIG')
    @target_file = File.expand_path(File.dirname(__FILE__) + '/../resource/collateral.json')
    @uri_path = @uri + "ProvAppCLService/entitytree/Collateral"

    5000.times do |i|
      FileUtils.cp_r @source_file, @target_file
    
      modify_string_in_file(@target_file, '<REPLACE_NUMBER>', Faker::Number.number(6))
      modify_string_in_file(@target_file, '<REPLACE_NAME>', Faker::Company.name)
      rest_post(@uri_path, @target_file)
      FileUtils.rm_rf @target_file
    end
  end

end
