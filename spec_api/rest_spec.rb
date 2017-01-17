require_relative '../lib/rest_helper'
require_relative '../config/rest_cfg'

describe "REST EXAMPLE Test Suites" do

  before(:each) do
    initialize_instance_variables
  end

 it "test google" do
    ## GET
    uri=@url+"/ProvAppCLService/clentity/Transactions"
    rest_get(uri)

    ## POST
    # uri=@url+"/ProvAppCLService/clentity/Transactions"    
    uri='http://google.com'
    payload=File.read('../resource/transaction.json-ORIG').gsub!('<REPLACE_NAME>', "Transaction #{@timenow}")
    rest_post(uri,payload)
    p @parent_id=@resp_body.scan(/"id":"(.*?)",/)[0].join

    ## PUT
    #rest_put(uri,payload)

    ## DELETE
    # rest_delete(uri)
  end
end
