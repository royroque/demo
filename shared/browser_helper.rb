module BrowserHelper
  attr_accessor :browser, :headless
    
  def open_browser (browser_type = '')
    ## OVERWRITE BROWSER_TYPE BY ORDER: argument/profile[:browser_type]/ENV
    if browser_type != ''
      ## Nothing - keep browser_type as is
    elsif browser_type == ''
      browser_type = ENV['BROWSER_TYPE']
      if ! @profile[:browser_type].nil?
        if ! @profile[:browser_type].empty?
          browser_type = @profile[:browser_type]
        end
      end
    end
    
    ## HEADLESS
    if ENV['HEADLESS'] == "true" && RbConfig::CONFIG['host_os'] =~ /linux/
      @headless = Headless.new 
      headless.start
    end

    #puts "===Opening browser session==="
    clean_up_temp_local_settings  
    if browser_type == 'ff' || browser_type == 'firefox'
      ENV["WATIR_DRIVER"] = "webdriver"
      #require 'watir-webdriver'
      @browser = Watir::Browser.new(:ff)
    elsif browser_type == 'internet_explorer' || browser_type == 'ie'
      ENV["WATIR_DRIVER"] = "classic" #to ensure that watir-classic is used instead of webdriver-IE driver
      #ENV["WATIR_DRIVER"] = "webdriver"
      @browser = Watir::Browser.new(:internet_explorer)
    elsif browser_type == 'chrome'
      ENV["WATIR_DRIVER"] = "webdriver"
      #require 'watir-webdriver'
      @browser = Watir::Browser.new(:chrome)
    end
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
