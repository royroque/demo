module ElementLocatorHelper
  ## EXTEND WATIR::HTMLElement to add custom id
  Watir::HTMLElement.attributes << :customid
  Watir::HTMLElement.attributes << :customname

  ## TEXT FIELD
  def text_field_id(label_name , text_pattern)
    browser.text_field(:id => /#{label_name}/).wait_until_present
    element=browser.text_field(:id => /#{label_name}/)
    if element.value != text_pattern
      element.set text_pattern
    end
  end
  
  def text_field_name(label_name , text_pattern)
    browser.text_field(:name => /#{label_name}/).wait_until_present
    element=browser.text_field(:name => /#{label_name}/)
    if element.value != text_pattern
      element.set text_pattern
    end
  end
  
  def text_field_parent_label(label_name , text_pattern)
    browser.label(:text => /#{label_name}/).wait_until_present
    element=browser.label(:text => /#{label_name}/).parent.text_field
    if element.value != text_pattern
      element.clear
      element.set text_pattern
    end
  end
    
  ## (TEXT FIELD) DATE FIELD
  def date_field_id(label_name , date)
    date.gsub!('/','-')
    browser.text_field(:id => /#{label_name}/).wait_until_present
    element=browser.text_field(:id => /#{label_name}/)
    if element.value !~ /#{date.split('').join('.*')}/
      element.clear
      element.send_keys date, :tab
    end
  end
  
  ## (TEXT FIELD) DATE FIELD
  def date_field_parent_label(label_name , date)
    date.gsub!('/','-')
    browser.label(:text => /#{label_name}/).wait_until_present
    element=browser.label(:text => /#{label_name}/).parent.text_field
    if element.value !~ /#{date.split('').join('.*')}/
      element.clear
      element.send_keys date, :tab
    end
  end
  
  ## (TEXT FIELD) TAX NUMBER
  def tax_number_parent_label(label_name , tax_num)
    tax_num.gsub!('-','')
    browser.label(:text => /#{label_name}/).wait_until_present
    element=browser.label(:text => /#{label_name}/).parent.text_field
    if element.value !~ /#{tax_num.split('').join('.*')}/
      element.set tax_num
    end
  end
  
  ## (TEXT FIELD) PHONE NUMBER
  def phone_number_parent_label(label_name , phone_num)
    ##1 text field for (012)345-6789
    phone_num.gsub!('-','')
    phone_num.gsub!('(','')
    phone_num.gsub!(')','')
    browser.label(:text => /#{label_name}/).wait_until_present
    element=browser.label(:text => /#{label_name}/).parent.text_field
    element.wait_until_present
    if element.value !~ /#{phone_num.split('').join('.*')}/
      element.set phone_num
    end
  end
 
  def phone_2fields_parent_label(label_name , phone_num)
    #2 text fields: (012) and 345-6789
    phone_num.gsub!('-','')
    phone_num.gsub!('(','')
    phone_num.gsub!(')','')
    browser.label(:text => /#{label_name}/).wait_until_present
    browser.label(:text => /#{label_name}/).parent.text_fields[0].set  phone_num[0..2]
    browser.label(:text => /#{label_name}/).parent.text_fields[1].set phone_num[3..9]
  end
  
  
  ## COMBOBOX
  def combobox_id(label_name, text_pattern)
    browser.text_field(:id=>/#{label_name}/).wait_until_present    
    element=browser.text_field(:id=>/#{label_name}/)    
    if element.value != text_pattern
      ## AUTO-COMPLETE ; ENTER THE FIRST THREE CHARACTERS ONLY
      element.clear
      element.send_keys text_pattern[0],text_pattern[1],text_pattern[2]
      wait_while_loading_gif
      browser.li(:text=>/#{text_pattern.split('').join('.*')}/).when_present.click rescue nil
      wait_while_loading_gif
    end
    ## AUTO-COMPLETE DID NOT WORK - HARD CODING VALUE INSTEAD ; NOT IDEAL BUT WORKAROUND
    element=browser.text_field(:id=>/#{label_name}/)
    if element.value != text_pattern
      element.set text_pattern
      wait_while_loading_gif
      browser.li(:text=>/#{text_pattern.split('').join('.*')}/).when_present.click rescue nil
      wait_while_loading_gif
    end
  end
   
  def combobox_parent_label (label_name, text_pattern)
    browser.label(:text => /#{label_name}/).wait_until_present
    element=browser.label(:text => /#{label_name}/).parent.text_field
    if element.value != text_pattern
      ## AUTO-COMPLETE ; ENTER THE FIRST THREE CHARACTERS ONLY
      element.clear
      element.send_keys text_pattern[0],text_pattern[1],text_pattern[2]
      wait_while_loading_gif
      browser.li(:text=>/#{text_pattern.split('').join('.*')}/).when_present.click rescue nil
      wait_while_loading_gif
    end
    ## AUTO-COMPLETE DID NOT WORK - HARD CODING VALUE INSTEAD ; NOT IDEAL BUT WORKAROUND
    element=browser.label(:text => /#{label_name}/).parent.text_field
    if element.value != text_pattern
      element.set text_pattern
      wait_while_loading_gif
      browser.li(:text=>/#{text_pattern.split('').join('.*')}/).when_present.click rescue nil
      wait_while_loading_gif
    end
  end
  
  def combobox_p2_label (label_name, text_pattern)
    browser.label(:text => /#{label_name}/).wait_until_present
    element=browser.label(:text => /#{label_name}/).parent.parent.text_field
    if element.value != text_pattern
      ## AUTO-COMPLETE ; ENTER THE FIRST THREE CHARACTERS ONLY
      element.clear
      element.send_keys text_pattern[0],text_pattern[1],text_pattern[2]
      wait_while_loading_gif
      browser.li(:text=>/#{text_pattern.split('').join('.*')}/).when_present.click rescue nil
      wait_while_loading_gif
    end
    ## AUTO-COMPLETE DID NOT WORK - HARD CODING VALUE INSTEAD ; NOT IDEAL BUT WORKAROUND
    element=browser.label(:text => /#{label_name}/).parent.parent.text_field
    if element.value != text_pattern
      element.set text_pattern
      wait_while_loading_gif
      browser.li(:text=>/#{text_pattern.split('').join('.*')}/).when_present.click rescue nil
      wait_while_loading_gif
    end
  end
  
  
  ## SELECT LIST
  def select_list_id(label_name, text_pattern)
    element=browser.select_list(:id => /#{label_name}/)
    unless element.selected?(text_pattern)
      sleep 1
      element.select text_pattern
      wait_while_loading_gif
    end
  end
  
  def select_list_parent_label(label_name, text_pattern)
    element=browser.label(:text => /#{label_name}/).parent.select_list
    unless element.selected?(text_pattern)
      sleep 1
      element.select text_pattern
      wait_while_loading_gif
    end
  end
  
  def select_pulldown_parent_label(label_name, text_pattern)
    element=browser.label(:text => /#{label_name}/).parent.select_list
    unless element.selected?(text_pattern)
      sleep 1
      element.select text_pattern
      wait_while_loading_gif
    end
  end
  
  
  ## RADIO  
  def radio_id_set(label_name)    
    element=browser.radio(:id => /#{label_name}/)
    element.wait_until_present
    unless element.checked?
      sleep 1
      element.set
    end
  end
  
  def radio_id_clear(label_name)    
    element=browser.radio(:id => /#{label_name}/)
    element.wait_until_present
    if element.checked?
      sleep 1
      element.clear
    end
  end
    
  def radio_parent_label_set(label_name)
    browser.label(:text => /#{label_name}/).wait_until_present
    element=browser.label(:text => /#{label_name}/).parent.radio
    unless element.checked?
      sleep 1
      element.set
    end
  end
  
  def radio_parent_label_clear(label_name)
    browser.label(:text => /#{label_name}/).wait_until_present
    element=browser.label(:text => /#{label_name}/).parent.radio
    if element.checked?
      sleep 1
      element.clear
    end
  end
  
  
  ## CHECKBOX
  def checkbox_id_set(label_name)    
    element=browser.checkbox(:id => /#{label_name}/)
    element.wait_until_present
    unless element.checked?
      sleep 1
      element.set
    end
  end
  
  def checkbox_id_clear(label_name)    
    element=browser.checkbox(:id => /#{label_name}/)
    element.wait_until_present
    if element.checked?
      sleep 1
      element.clear
    end
  end
  
  def checkbox_parent_label_set(label_name)
    browser.label(:text => /#{label_name}/).wait_until_present
    element=browser.label(:text => /#{label_name}/).parent.checkbox
    unless element.checked?
      sleep 1
      element.set
    end
  end
  
  def checkbox_parent_label_clear(label_name)
    browser.label(:text => /#{label_name}/).wait_until_present
    element=browser.label(:text => /#{label_name}/).parent.checkbox
    if element.checked?
      sleep 1
      element.clear
    end
  end
  
  def checkbox_parent_span_set(label_name)
    browser.span(:text => /#{label_name}/).wait_until_present
    element=browser.span(:text => /#{label_name}/).parent.checkbox
    unless element.checked?
      sleep 1
      element.set
    end
  end
  
  def checkbox_parent_span_clear(label_name)
    browser.span(:text => /#{label_name}/).wait_until_present
    element=browser.span(:text => /#{label_name}/).parent.checkbox
    unless element.checked?
      sleep 1
      element.clear
    end
  end
end
include ElementLocatorHelper
