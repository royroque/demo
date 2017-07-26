module TemplateConfig

  def initialize_instance_variables(tc='default')
    @timenow = Time.now.strftime('%m%d_%H%M')
    
    unless ENV['URL'].nil?
      @rest_obj[:host]=ENV['URL']
      @rest_obj[:port]=ENV['PORT']
    else 
      @template=YAML.load_file(File.expand_path(File.dirname(__FILE__)+"/../../config/profiles.yml"))["auto1"]
    end
    @template=YAML.load_file(File.expand_path(File.dirname(__FILE__)+"/yml/template.yml"))["auto1"]
  end
  
end
include TemplateConfig
