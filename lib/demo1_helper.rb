require_relative '../lib/generic_helper'
#include RSpec::Matchers    ;#needed if using rspec expect in IRB

module Demo1Helper
  
  def execute_test_case_1
    puts __method__    
    
    ## check/assert whether browser.url value contains the word google
    expect(browser.url).to match(/google/)    
    
    raise 'match error occured' unless browser.url =~ /google/
    
    if browser.url =~ /google/
      puts 'url is correct'
    else
      puts 'url is NOT correct'
      raise 'match error occured'
    end
  end
  
  
end
include Demo1Helper


