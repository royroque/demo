module DemoConfig

  def init_test_data_yml(tc='default')
  
    ## Initilize instance variables based off config/*yml files 
    @profile=load_profile_from_config_yml('profiles.yml','user1')
    
    if tc=='default'
    end
    
    ## DYNAMIC VALUES CREATION
    @timenow = Time.now.strftime('%m%d_%H%M')
    
  end
  
end
include DemoConfig