module LoadEnvVar

  ENV['HEADLESS'] ||= "false"
  ENV['BROWSER_TYPE'] ||= 'firefox' 
  
end
include LoadEnvVar
