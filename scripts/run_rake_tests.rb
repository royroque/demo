puts "-----Starting Automation Test Execution-----"

component = ''	
spec_dir=File.expand_path(File.dirname(__FILE__) + "/../spec/")
log_dir=File.expand_path(File.dirname(__FILE__) + "/../logs/")
rake_bin_dir="C:/Ruby21-x64/bin"
rakefile_dir=File.expand_path(File.dirname(__FILE__) + "/../")
curr_dir=Dir.pwd


#########################################################################
#########################################################################
### Cleanup (if any) old logs found
if Dir.glob("#{log_dir}/*.log").size > 0 
  puts "Deleting old all logfiles found in #{log_dir} folder"

  Dir.glob("#{log_dir}/*.log").each do |f| 
    File.delete(f)
  end
end

### Run RAKE
Dir.chdir spec_dir
if component == ''
  %x(#{rake_bin_dir}/rake)
else 
  %x(#{rake_bin_dir}/rake #{component})
end
Dir.chdir curr_dir

### Check Logs for ERRORS
if Dir.glob("#{log_dir}/*.log").size > 0 
  result = []

  Dir.glob("#{log_dir}/*.log").each do |logname|
    puts "Checking log for status: '#{logname}'"
    if desc = open(logname).grep(/Failure\/Error/)
      unless desc.empty?
        err_msg = "Found error(s) on #{File.basename(logname)} : #{desc}"
        result << err_msg.to_s
      end
    end
  end
  unless result.flatten.empty?
    puts "-----Errors/Failures encountered - check logs for more info-----"
    puts result.flatten
    exit 1
  else
    puts '-----ALL Automated Tests Ran successfully!-----'
  end
end