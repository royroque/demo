require 'restclient'
require 'faker' #requires that faker gem is installed

module RestHelper


  ## CREATE
  def rest_post(uri,xml_file)
    resource = RestClient::Resource.new( uri, { :user => @rest_user, :password => @rest_passwd })
    response = resource.post(File.read(xml_file), :content_type => @rest_cont_type)
    puts "Response Code: #{response.code}"
    raise "Error with #{__method__} :  #{response.code} : #{uri}" unless response.code == 200
    return response
  end


  ## RETRIEVE
  def rest_get(uri)
    resource = RestClient::Resource.new( uri, { :user => @rest_user, :password => @rest_passwd })
    response = resource.get(:Accept => 'application/xml' , :content_type => @rest_cont_type)
    puts "Response Code: #{response.code}"
    raise "Error with #{__method__} :  #{response.code} : #{uri}" unless response.code == 200
    return response
  end


  ## UPDATE
  def rest_put(uri,xml_file)
    return_codes = [200,201,202]

    resource = RestClient::Resource.new( uri, { :user => @rest_user, :password => @rest_passwd })
    response = resource.put(File.read(xml_file), :content_type => @rest_cont_type)
    puts "Response Code: #{response.code}"
    raise "Error with #{__method__} :  #{response.code} : #{uri}" unless return_codes.include?(response.code)
    return response
  end


  ## DELETE
  def rest_delete(uri)
    resource = RestClient::Resource.new( uri, { :user => @rest_user, :password => @rest_passwd })
    response = resource.delete(:content_type => @rest_cont_type)
    puts "Response Code: #{response.code}"
    raise "Error with #{__method__} :  #{response.code} : #{uri}" unless response.code == 200
    return response
  end


  #############################################################################
  ## MISC:  not REST specific but are used during rests calls to create the xml/json
  def modify_string_in_file(target_file, string_to_replace, string_to_replace_with)
     FileUtils.cp_r target_file , "#{target_file}_tmp"

     text = File.read("#{target_file}_tmp")
     text.gsub!(string_to_replace, string_to_replace_with)
     File.open(target_file, 'w') {|f| f.puts text}
     if (open(target_file).grep(/#{string_to_replace_with}/).length) == 0
       raise "XML file was NOT modified with correct text: #{target_file}"
     end
     File.delete "#{target_file}_tmp"
  end

=begin
  ## SAMPLE USAGE:
    @source_file =  File.expand_path(File.dirname(__FILE__) + '/../resource/customer.xml-ORIG')
    @target_file = File.expand_path(File.dirname(__FILE__) + '/../resource/customer.xml')
    @uri = "http://prism360ux.provapps.com:9080/"
    @uri_path = @uri + "ProvAppCLService/entitytree/Customer"

    FileUtils.cp_r @source_file, @target_file
    modify_string_in_file(@target_file, '<REPLACE_FIRST_NAME>', Faker::Name.first_name)
    modify_string_in_file(@target_file, '<REPLACE_LAST_NAME>', Faker::Name.last_name)
    modify_string_in_file(@target_file, '<REPLACE_TAXID>', Faker::Company.ein)
    modify_string_in_file(@target_file, '<REPLACE_COMP_NAME>', Faker::Company.name)
    FileUtils.rm_rf @target_file  
=end

end
include RestHelper