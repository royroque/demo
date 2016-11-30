module TemplateConfig

  def initialize_instance_variables
    @timenow = Time.now.strftime('%m%d_%H%M')
    
    # @template=load_profile_from_config_yml('template.yml','auto1')   
    @rest_user = 'provadmin'
    @rest_passwd = 'Provenir1'
    @rest_cont_type = 'application/json'
    @uri = "http://prism360ux.provapps.com:9080/"
    
  end
  
end
include TemplateConfig