module MiscHelpers

  def load_profile_from_config_yml(filename,profile_name)
    YAML.load_file(File.expand_path(File.dirname(__FILE__)+"/../config/yml/#{filename}"))["#{profile_name}"]
  end
  
  def take_screenshot
    puts __method__
    filename = File.expand_path(File.dirname(__FILE__)+"/../logs/#{Time.now.strftime('%m%d%y_%H%M%S')}.png")
    browser.screenshot.save filename
    sleep 1
  end
  
  def attach_to_window id, pattern
    parent_window = browser.window
    Watir::Wait.until(90) { browser.window(id.to_sym => /#{pattern}/).present? }    
    new_window = browser.window(id.to_sym => /#{pattern}/) 
    new_window.when_present(90).use
    sleep 2
    if block_given?
      yield
    end
    parent_window.use
    if new_window.present?
      browser.execute_script("window.onbeforeunload = null")
      browser.execute_script("window.onbeforeunload = function() {};")
      sleep 1
      window.close rescue nil
      new_window.close
    end
  end
  
  def attach_to_window_no_close id, pattern
    parent_window = browser.window   
    Watir::Wait.until(90) { browser.window(id.to_sym => /#{pattern}/).present? }    
    new_window = browser.window(id.to_sym => /#{pattern}/) 
    new_window.when_present.use
    sleep 2
    if block_given?
      yield
    end
    parent_window.use
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
    #ie."checkbox_parent_label_set('OFAC Hit'),@customer[:ofac_hit])"
    #become "@customer[:ofac_hit]) after split
    split_str=str.split(',')[-1].split(')')[0]
    
    if ! split_str.nil? 
      if eval(split_str) =~ /YES/i
        eval(str.split(',')[0])
      end
    end 
  end
end
include MiscHelpers