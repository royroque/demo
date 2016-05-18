module LoadEnvVar

  ## TASKS SPECIFIC (to be run with rake)
  ENV['COMPONENT'] ||= 'default'
  #ENV['COMPONENT'] ||= 'wizard'
  
  ## BROWSER SPECIFIC
  ENV['HEADLESS'] ||= "false"
  #ENV['BROWSER_TYPE'] ||= 'internet_explorer' 
  ENV['BROWSER_TYPE'] ||= 'firefox'

  
end
include LoadEnvVar
