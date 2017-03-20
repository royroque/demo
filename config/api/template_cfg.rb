module TemplateConfig

  def initialize_instance_variables
    @timenow = Time.now.strftime('%m%d_%H%M')
    
    unless ENV['URL'].nil?
      @rest_obj[:host]=ENV['URL']
      @rest_obj[:port]=ENV['PORT']
    else 
      @rest_obj=YAML.load_file(File.expand_path(File.dirname(__FILE__)+"/../../config/profiles.yml"))["auto1"]
    end
    @rest_obj.update(YAML.load_file(File.expand_path(File.dirname(__FILE__)+"/yml/template.yml"))["auto1"])

    ## Following instance variables needed in rest_helper
    @url="#{@rest_obj[:host]}:#{@rest_obj[:port]}"
    # @uri=@url+@path
    @rest_user=@rest_obj[:username]
    @rest_passwd=@rest_obj[:password]
    @rest_accept_type=@rest_obj[:accept_type]
    @rest_cont_type=@rest_obj[:content_type]
    
    return @rest_obj
  end
  
end
include TemplateConfig