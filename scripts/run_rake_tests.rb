require_relative '../config/env_cfg'

puts "-----Starting Automation Test Execution-----"

rake_bin_dir="C:/Ruby22-x64/bin"
if ENV['COMPONENT'] == 'default'
  component = '' 
else
  component = ENV['COMPONENT']
end


log_dir=File.expand_path(File.dirname(__FILE__) + "/../logs/")
rakefile_dir=File.expand_path(File.dirname(__FILE__) + "/../")
curr_dir=Dir.pwd

#########################################################################
#########################################################################
### Cleanup (if any) old logs/html found
Dir.glob("#{log_dir}/*.log").each do |f| 
  File.delete(f)
end

Dir.glob("#{log_dir}/*.html").each do |f| 
  File.delete(f)
end

Dir.glob("#{log_dir}/*.png").each do |f| 
  File.delete(f)
end

### Run RAKE
Dir.chdir rakefile_dir
if component == ''
  %x(#{rake_bin_dir}/rake)
else 
  %x(#{rake_bin_dir}/rake #{component})
end
Dir.chdir curr_dir

### Check Logs for ERRORS
#if Dir.glob("#{log_dir}/*.log").size > 0 
if Dir.glob("#{log_dir}/*.html").size > 0 
  result = []

  #Dir.glob("#{log_dir}/*.log").each do |logname|
  Dir.glob("#{log_dir}/*.html").each do |logname|
    puts "\nChecking log/html for status: '#{logname}'"
    #if desc = open(logname).grep(/Failure\/Error/)
    if desc = open(logname).grep(/failed_spec_name/)
      unless desc.empty?
        err_msg = "Found error(s) on #{File.basename(logname)} : #{desc}"
        result << err_msg.to_s
      end
    end
  end
  unless result.flatten.empty?
    puts "-----Errors/Failures encountered - check logs/html for more info-----"
    puts result.flatten
    exit 1
  else
    puts '-----ALL Automated Tests Ran successfully!-----'
  end
end