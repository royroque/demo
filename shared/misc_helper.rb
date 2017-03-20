require 'rspec'
include RSpec::Matchers
require 'fileutils'
require 'rbconfig'
require 'yaml'
require 'rest-client'
require 'rexml/document'
include REXML
#require 'mysql2'
#require 'pg'

module MiscHelpers

  def load_profile_from_config_yml(filename,profile_name)
    YAML.load_file(File.expand_path(File.dirname(__FILE__)+"/yml/#{filename}"))["#{profile_name}"]
  end

  def gsub_string_in_file(target_file, target_string, replace_string)
    text = File.read("#{target_file}")
    replace = text.gsub("#{target_string}", "#{replace_string}")
    File.open("#{target_file}", "w") { |file| file.puts replace }
  end

  def sub_string_in_file(target_file, target_string, replace_string)
    text = File.read("#{target_file}")
    replace = text.sub("#{target_string}", "#{replace_string}")
    File.open("#{target_file}", "w") { |file| file.puts replace }
  end

  ### USED WITH .ORIG FILE WITH <REPLACE_ME> REF
  def modify_string_in_file(target_file, string_to_replace, string_to_replace_with)
     FileUtils.cp_r target_file , "#{target_file}_tmp"

     text = File.read("#{target_file}_tmp")
     text.gsub!(string_to_replace, string_to_replace_with)
     File.open(target_file, 'w') {|f| f.puts text}
     if (open(target_file).grep(/#{string_to_replace_with}/).length) == 0
       raise "XML file was NOT modified with correct text: #{target_file}"
     end
     File.delete "#{target_file}_tmp"
  end
  
  def clean_up_temp_local_settings
    ##windows only:  needed because our test windows vms often run out of space due to the 'temp' firefox profiles generated
    if RbConfig::CONFIG['host_os'] =~ /mswin|mingw/
      source = ENV["TEMP"]
    elsif RbConfig::CONFIG['host_os'] =~ /linux/
      if !ENV['TMP'].nil?
        source = ENV['TMP']
      elsif !ENV['TEMP'].nil?
        source = ENV['TEMP']      
      elsif !ENV['TMPDIR'].nil?
        source = ENV['TMPDIR']
      elsif !ENV['TEMPDIR'].nil?
        source = ENV['TEMPDIR']      
      else
        source  = '/tmp'
      end
    end
        
    curr_dir = FileUtils.pwd
    FileUtils.cd source      

    Dir.glob('**/webdriver-*').each do |filename|
      FileUtils.rm_rf filename     
    end       

    Dir.glob('**/d201*').each do |filename|
      FileUtils.rm_rf filename
    end
    
    Dir.glob('**/webdriver-profile').each do |filename|
      FileUtils.rm_rf filename
    end

    Dir.glob('**/unzip201*').each do |filename|
      FileUtils.rm_rf filename
    end
      
    Dir.glob('**/scoped_*').each do |filename|       
      FileUtils.rm_rf filename     
    end

    FileUtils.cd curr_dir    
  end
  
  
  ################   
  def click_if_element_exists(element)
    #ie. "browser.link(:text=>/#{@source[:name]}/)"
    sleep 1
    if (eval(element).exists?)
      eval(element).click
    end 
  end
  
  def set_if_element_exists(element)
    #ie. "browser.link(:text=>/#{@source[:name]}/)"
    sleep 1
    if (eval(element).exists?)
      eval(element).set
    end 
  end
  
  def clear_if_element_exists(element)
    #ie. "browser.link(:text=>/#{@source[:name]}/)"
    sleep 1
    if (eval(element).exists?)
      eval(element).clear
    end 
  end
  
  def set_if_kv_exists(str)
    #ie. set_if_kv_exists(" text_field_parent_label('Doing Business As',@customer[:doing_business_as]) ")
    #becomes "@customer[:doing_business_as]" after split
    split_str=str.split(',')[-1].split(')')[0]
    
    if ! split_str.nil? 
      if ! split_str.empty?
        eval(str)
      end
    end 
  end
 
  def set_if_kv_yes(str)
    #ie."checkbox_parent_label_set('OFAC Hit',@customer[:ofac_hit])"
    #become "@customer[:ofac_hit]) after split
    split_str=str.split(',')[-1].split(')')[0]
    
    if ! split_str.nil? 
      if eval(split_str) =~ /YES/i
        eval(str.split(',')[0].delete('\(').delete('\)'))
      end
    end 
  end
end
include MiscHelpers