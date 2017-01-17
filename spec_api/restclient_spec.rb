require_relative '../config/restclient_cfg'
require_relative '../lib/restclient_helper'

describe "RESTCLIENT EXAMPLE Test Suites" do

  before(:each) do
    initialize_instance_variables
  end

  it "test google" do
    ## GET
    # uri=@url+"/ProvAppCLService/clentity/Transactions"    
    uri='http://google.com'
    rest_get(uri,200)

    ## POST
    # uri=@url+"/ProvAppCLService/clentity/Transactions"    
    uri='http://google.com'
    payload=File.read('../resource/transaction.json-ORIG').gsub!('<REPLACE_NAME>', "Transaction #{@timenow}")
    rest_post(uri,payload,200)
    p @parent_id=@resp_body.scan(/"id":"(.*?)",/)[0].join

    ## PUT
    #rest_put(uri,payload,200)

    ## DELETE
    #rest_delete(uri,payload,200)
  end

end
