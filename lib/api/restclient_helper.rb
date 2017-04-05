require 'rest-client'
require 'faker'

module RestHelper
  ## NOTE for payload ; you can either File.read and send it as string or change payload: File.read(payload)

  ## CREATE
  def rest_post(uri,payload)
    response = RestClient::Request.execute(method: :post, 
      url: uri,
      user: @rest_user, 
      password: @rest_passwd,
      payload: payload, 
      headers: {content_type: @rest_cont_type, accept: @rest_accept_type}
    )

    @resp_headers=response.headers
    @resp_code=response.code
    @resp_body=response.body   
    return response
  end

  ##CREATE POST using excel upload
  def rest_post_upload(uri,filepath)
    response = RestClient::Request.execute(method: :post, 
      url: uri,
      user: @rest_user, 
      password: @rest_passwd,
      payload: {:multipart => true, :file => File.new(filepath)}, 
      headers: {content_type: @rest_cont_type, accept: @rest_accept_type}
    )
    @resp_headers=response.headers
    @resp_code=response.code
    @resp_body=response.body   
    return response
  end  

  ## RETRIEVE
  def rest_get(uri)
    begin
    response = RestClient::Request.execute(method: :get, 
      url: uri,
      user: @rest_user, 
      password: @rest_passwd,
      headers: {content_type: @rest_cont_type, accept: @rest_accept_type}
    )
    @resp_headers=response.headers
    @resp_code=response.code
    @resp_body=response.body   

    return response
    rescue RestClient::ExceptionWithResponse => e
      @resp_code=404 if e.to_s =~ /404/
    end

  end


  ## UPDATE
  def rest_put(uri,payload)    
    exp_status_code = [200,201,202]
    
    response = RestClient::Request.execute(method: :put, 
      url: uri,
      user: @rest_user, 
      password: @rest_passwd,
      payload: payload, 
      headers: {content_type: @rest_cont_type, accept: @rest_accept_type}
    )

    @resp_headers=response.headers
    @resp_code=response.code
    @resp_body=response.body 
    return response
  end


  ## DELETE
  def rest_delete(uri,payload='')  	
    response = RestClient::Request.execute(method: :delete,
      url: uri,
      user: @rest_user,
      password: @rest_passwd,
      payload: payload,
       headers: {content_type: @rest_cont_type}
    )
    
    @resp_headers=response.headers
    @resp_code=response.code
    @resp_body=response.body   
    return response
  end

  #############################################################################
  ## MISC:  
  def assert_status_code(exp_status_code)
    if exp_status_code.kind_of?(Array)
      unless exp_status_code.include? @resp_code
        raise "response status code received '#{@resp_code}' DOES NOT CONTAIN THE EXPECTED STATUS CODE '#{exp_status_code}'"
      end
    else 
      unless @resp_code == exp_status_code
        raise "response status code received '#{@resp_code}' IS NOT EQUAL TO EXPECTED STATUS CODE '#{exp_status_code}'" 
      end
    end
  end

end 
include RestHelper


=begin
RestClient.get 'http://example.com/resource'
RestClient.get 'http://example.com/resource', {params: {id: 50, 'foo' => 'bar'}}
RestClient.get 'https://user:password@example.com/private/resource', {accept: :json}
RestClient::Request.execute(method: :get, url: url, user: 'username', password: 'secret')
RestClient::Request.execute(method: :get, url: 'http://example.com/resource',
                            ssl_ca_file: 'myca.pem',
                            ssl_ciphers: 'AESGCM:!aNULL')
RestClient::Request.execute(method: :get, url: 'http://example.com/resource',
                            timeout: 10, headers: {{content_type: :json, accept: :json}})
➔ GET http://example.com/resource?foo=bar
RestClient.post 'http://example.com/resource', {param1: 'one', nested: {param2: 'two'}}
RestClient.post "http://example.com/resource", {'x' => 1}.to_json, {content_type: :json, accept: :json}
RestClient.post '/data', :myfile => File.new("/path/to/image.jpg", 'rb')
RestClient.post '/data', {:foo => 'bar', :multipart => true}
RestClient.delete 'http://example.com/resource'
RestClient::Request.execute(method: :delete, url: 'http://example.com/resource',
                            payload: 'foo', headers: {myheader: 'bar'})                          


>> response = RestClient.get 'http://example.com/resource'
=> <RestClient::Response 200 "<!doctype h...">
>> response.code
=> 200
>> response.cookies
=> {"Foo"=>"BAR", "QUUX"=>"QUUUUX"}
>> response.headers
=> {:content_type=>"text/html; charset=utf-8", :cache_control=>"private" ... }
>> response.body
=> "<!doctype html>\n<html>\n<head>\n    <title>Example Domain</title>\n\n ..."


=end


