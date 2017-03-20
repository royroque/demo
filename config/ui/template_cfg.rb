module TemplateConfig

  def initialize_instance_variables(tc='default')
    @timenow = Time.now.strftime('%m%d_%H%M')
    
    @template=YAML.load_file(File.expand_path(File.dirname(__FILE__)+"/yml/template.yml"))["auto1"]
  end
  
end
include TemplateConfig
