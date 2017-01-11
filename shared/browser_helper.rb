module BrowserHelper
  attr_accessor :browser, :headless
    
  ## ORDER:
  ##1-PARAM (if passed) , 
  ##2-config/env_cfg/ENV['BROWSER_TYPE'] (if called) 
  def open_browser (type = '')
    if type != ''
      browser_type = type
    elsif ! ENV['BROWSER_TYPE'].nil?
      ## DEFINED AS JENKINS ENV OR BY READING config/env_cfg.rb
      browser_type = ENV['BROWSER_TYPE']    
    else
      # browser_type = 'ff'
      browser_type = 'chrome'
    end
    puts "what is my browser type: #{browser_type}"
    
    ## HEADLESS
    if ENV['HEADLESS'] == "true" && RbConfig::CONFIG['host_os'] =~ /linux/
      @headless = Headless.new 
      headless.start
    end

    #puts "===Opening browser session==="
    clean_up_temp_local_settings
    if browser_type == 'chrome' || browser_type == :chrome
      # ENV["WATIR_DRIVER"] = "webdriver"
      chromedriver_directory = File.join(File.absolute_path(File.dirname(__FILE__)),"bin")
      ENV['PATH'] = "#{ENV['PATH']}#{File::PATH_SEPARATOR}#{chromedriver_directory}"
      download_directory = File.expand_path(File.dirname(__FILE__)+"/../downloads/")
      download_directory.gsub!("/", "\\") if Selenium::WebDriver::Platform.windows?
            
      prefs = {
        'download' => {
          'default_directory' => download_directory,
          'prompt_for_download' => false,
          'directory_upgrade' => true, 
          # 'extensions_to_open' => '',

        },
        'profile' => {
          'disable-extensions' => true,
          #'default_content_settings' => {'multiple-automatic-downloads' => 1}, #for chrome version olde ~42
          'default_content_setting_values' => {'automatic_downloads' => 1}, #for chrome newer 46
          'password_manager_enabled' => false,
          'gaia_info_picture_url' => true,
        }
      }
      caps = Selenium::WebDriver::Remote::Capabilities.chrome
      caps['chromeOptions'] = {'prefs' => prefs}
      @browser = Watir::Browser.new :chrome, :desired_capabilities => caps
      
         
    elsif browser_type == 'ff' || browser_type == 'firefox' || browser_type == :ff || browser_type == :firefox
      # ENV["WATIR_DRIVER"] = "webdriver"
      download_directory = File.expand_path(File.dirname(__FILE__)+"/../downloads/")
      download_directory.gsub!("/", "\\") if Selenium::WebDriver::Platform.windows?

      profile = Selenium::WebDriver::Firefox::Profile.new
      profile['browser.download.lastDir'] = download_directory
      profile['browser.download.folderList'] = 2
      profile['browser.download.dir'] = download_directory
      profile['browser.download.manager.showWhenStarting'] = false
      profile['browser.helperApps.alwaysAsk.force'] = false
      profile['browser.helperApps.neverAsk.openFile'] = "text/csv,application/pdf,application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/vnd.openxmlformats-officedocument.wordprocessingml.document"
      profile['browser.helperApps.neverAsk.saveToDisk'] = "text/csv,application/pdf,application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/vnd.openxmlformats-officedocument.wordprocessingml.document"
      profile['pdfjs.disabled'] = true
      @browser = Watir::Browser.new :firefox, :profile => profile 
         
    elsif browser_type == 'internet_explorer' || browser_type == 'ie' || browser_type == :ie || browser_type == :internet_explorer
      #ENV["WATIR_DRIVER"] = "classic" #to ensure that watir-classic is used instead of webdriver-IE driver
      # ENV["WATIR_DRIVER"] = "webdriver"
      iedriver_directory = File.join(File.absolute_path(File.dirname(__FILE__)),"bin")
      ENV['PATH'] = "#{ENV['PATH']}#{File::PATH_SEPARATOR}#{iedriver_directory}"

      @browser = Watir::Browser.new(:internet_explorer)
    
    else
      raise 'Sorry only Chrome, Firefox and IE are supported in this project' 
    end
	
    #@browser.window.move_to(0, 0)      
    @browser.window.resize_to(1280,720)    
	
  end  
  
  def close_all_windows
    #puts "===Closing browser session==="
    browser.windows.each do |window|
      window.use
      browser.execute_script("window.onbeforeunload = null")
      browser.execute_script("window.onbeforeunload = function() {};")
      sleep 1
      window.close rescue nil
    end
    begin ; browser.alert.ok if browser.alert.exists? ; rescue; end
    clean_up_temp_local_settings
    
    #headless
    headless.destroy if ENV['HEADLESS'] == "true" && RbConfig::CONFIG['host_os'] =~ /linux/
  end
  

  
end
include BrowserHelper
