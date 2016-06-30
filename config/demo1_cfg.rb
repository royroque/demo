module DemoConfig

  def initialize_instance_variables(tc='default')
    @timenow = Time.now.strftime('%m%d_%H%M')
        
  end
  
end
include DemoConfig