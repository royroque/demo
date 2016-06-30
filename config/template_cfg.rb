module TemplateConfig

  def initialize_instance_variables(tc='default')
    @timenow = Time.now.strftime('%m%d_%H%M')
        
    @template=load_profile_from_config_yml('profiles.yml','user1')
  end
  
end
include TemplateConfig