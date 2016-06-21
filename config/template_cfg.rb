module TemplateConfig

  def init_test_data_yml(tc='default')
    @timenow = Time.now.strftime('%m%d_%H%M')
    
    @profile=load_profile_from_config_yml('profiles.yml','user1')   
    @profile[:url]=ENV['URL'] unless ENV['URL'].nil?    
    
    @template=load_profile_from_config_yml('profiles.yml','user1')
  end
  
end
include TemplateConfig