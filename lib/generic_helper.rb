module GenericHelper
  
  def login_to_url(profilename='user1')
    @profile=load_profile_from_config_yml('profiles.yml',profilename)   
    @profile[:url]=ENV['URL'] unless ENV['URL'].nil?    
    
	browser.goto(@profile[:url])
  end
  
end
include GenericHelper


