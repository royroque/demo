module DashboardConfig

  def initialize_instance_variables(tc='default')
    @timenow = Time.now.strftime('%m%d_%H%M')
    
    @dashboard=load_profile_from_config_yml('dashboard.yml','auto1')   
  end
  
end
include DashboardConfig
