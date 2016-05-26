require_relative '../lib/generic_helper'

module Demo1Helper
  
  def execute_test_case_1
    puts __method__    
    expect(browser.url).to match(/google/)    
  end
  
  def execute_test_case_2
    puts __method__    
    expect(browser.url).to match(/yahoo/)    
  end
  
  def execute_test_case_3
    puts __method__
    pending("this test case in still work-in-progress")
    fail
  end
  
end
include Demo1Helper


