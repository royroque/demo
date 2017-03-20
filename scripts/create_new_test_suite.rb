require 'fileutils'

puts 'This is a script will create your spec/helper/cfg/yml/rakefile of your NEW TEST SUITE'

if ARGV.size != 2
  puts 'ERROR:  This script require that you need to pass 2 parameters <name> <api/ui>'
  puts 'USAGE:  ruby create_new_test_suite <name> <api/ui>'
  puts '        ruby create_new_test_suite wizard api'
  puts 'PLEASE TRY AGAIN'
  exit 1
else
  puts @suite_name=ARGV[0].downcase
  puts @spec_type=ARGV[1].downcase

  unless @spec_type == 'api' || @spec_type == 'ui'
    puts '2nd parameters need to be of type:  ui/api'
    puts 'PLEASE TRY AGAIN'
    exit 1
  end
end


## COPY and MODIFY TEMPLATE SPEC WITH SUITENAME
@source_file=File.expand_path(File.dirname(__FILE__) +"/../spec/#{@spec_type}/template_spec.rb")
@target_file=File.expand_path(File.dirname(__FILE__) +"/../spec/#{@spec_type}/#{@suite_name}_spec.rb")
if File.exist?(@target_file)
  puts 'Test Suite Name already exists - select a new name'
  exit
end
text=File.read(@source_file)
text.gsub!('template',@suite_name) #cfg/helper
text.gsub!('Template Test Suites',"#{@suite_name.capitalize} Test Suites") #describe
text.gsub!('initialize_instance_variables', "init_#{@suite_name}_variables") #instance variables
File.open(@target_file,'w') {|f| f.puts text}


## COPY and MODIFY TEMPLATE HELPER WITH SUITENAME
@source_file=File.expand_path(File.dirname(__FILE__) +"/../lib/#{@spec_type}/template_helper.rb")
@target_file=File.expand_path(File.dirname(__FILE__) +"/../lib/#{@spec_type}/#{@suite_name}_helper.rb")
text=File.read(@source_file)
text.gsub!('TemplateTasksHelper',"#{@suite_name.capitalize}TasksHelper") #module/include
File.open(@target_file,'w') {|f| f.puts text}


## COPY and MODIFY TEMPLATE CFG WITH SUITENAME
@source_file=File.expand_path(File.dirname(__FILE__) +"/../config/#{@spec_type}/template_cfg.rb")
@target_file=File.expand_path(File.dirname(__FILE__) +"/../config/#{@spec_type}/#{@suite_name}_cfg.rb")
text=File.read(@source_file)
text.gsub!('TemplateConfig',"#{@suite_name.capitalize}Config") #module/include
text.gsub!('template',@suite_name) #yml
text.gsub!('initialize_instance_variables', "init_#{@suite_name}_variables") #instance variables
File.open(@target_file,'w') {|f| f.puts text}


## COPY YML WITH SUITENAME
@source_file=File.expand_path(File.dirname(__FILE__) +"/../config/#{@spec_type}/yml/template.yml")
@target_file=File.expand_path(File.dirname(__FILE__) +"/../config/#{@spec_type}/yml/#{@suite_name}.yml")
FileUtils.cp(@source_file, @target_file)


## COPY AND MODIFY RAKEFILE WITH A NEW SECTION OF RAKETASK
@new_rakefile_section='desc "Run TEMPLATE Tasks Test Suite"
  RSpec::Core::RakeTask.new(:TEMPLATE) do |t|
    STDOUT.sync = true
    t.fail_on_error = false
    product = "TEMPLATE"
    t.pattern = Dir.glob("spec/#{@spec_type}/#{product}_spec.rb")
    t.rspec_opts = "--format documentation -o ./logs/#{product}.log --format html --out ./logs/#{product}.html --require yarjuf --format JUnit  --out ./logs/#{product}.xml"
  end
 
  task :default => :regression'
@source_file=File.expand_path(File.dirname(__FILE__) +'/../rakefile')
text=File.read(@source_file)
text.gsub!('task :default => :regression',@new_rakefile_section) #Added new section
text.gsub!('TEMPLATE',@suite_name) #replace TEMPLATE WITH SUITENAME
File.open(@source_file,'w') {|f| f.puts text}
