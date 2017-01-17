module TemplateConfig

  def initialize_instance_variables
    @timenow = Time.now.strftime('%m%d_%H%M')
    
    @rest_obj=YAML.load_file(File.expand_path(File.dirname(__FILE__)+"/../config/yml/restclient.yml"))["auto1"]

    ## Following instance variables needed in rest_helper
    @url="#{@rest_obj[:host]}:#{@rest_obj[:port]}"
    # @uri=@url+@path
    @rest_user=@rest_obj[:username]
    @rest_passwd=@rest_obj[:password]
    @rest_accept_type=@rest_obj[:accept_type]
    @rest_cont_type=@rest_obj[:content_type]
    
  end
  
end
include TemplateConfig