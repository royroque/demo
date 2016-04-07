module ElementLocatorHelper

  ## TEXT FIELD
  def text_field_id(label_name , text_pattern)
    element=browser.text_field(:id => /#{label_name}/)
    element.wait_until_present
    if element.value != text_pattern
      element.clear
      element.set text_pattern
    end
  end
  
  def text_field_name(label_name , text_pattern)
    element=browser.text_field(:name => /#{label_name}/)
    element.wait_until_present
    if element.value != text_pattern
      element.clear
      element.set text_pattern
    end
  end
  
  def text_field_parent_label(label_name , text_pattern)    
    element=browser.label(:text => /#{label_name}/).parent.text_field
    element.wait_until_present
    if element.value != text_pattern
      element.clear
      element.set text_pattern
    end
  end
    
  ## (TEXT FIELD) DATE FIELD
  def date_field_id(label_name , date)
    date.gsub!('/','-')
    element=browser.text_field(:id => /#{label_name}/)
    element.wait_until_present
    if element.value != date
      element.clear
      element.send_keys date, :tab
    end
  end
  
  ## (TEXT FIELD) DATE FIELD
  def date_field_parent_label(label_name , date)
    date.gsub!('/','-')
    element=browser.label(:text => /#{label_name}/).parent.text_field
    element.wait_until_present
    if element.value != date
      element.clear
      element.send_keys date, :tab
    end
  end
  
  ## (TEXT FIELD) TAX NUMBER
  def tax_number_parent_label(label_name , tax_num)
    split_num=tax_num.gsub('-','')
    element=browser.label(:text => /#{label_name}/).parent.text_field
    element.wait_until_present
    if element.value != tax_num
      element.clear
      element.set split_num
    end
  end
  
  ## (TEXT FIELD) PHONE NUMBER
  def phone_number_parent_label(label_name , phone_num)
    split_num=phone_num.gsub('-','')
    split_num.gsub!('(','')
    split_num.gsub!(')','')
    element=browser.label(:text => /#{label_name}/).parent.text_field
    element.wait_until_present
    if element.value != phone_num
      element.clear
      element.set split_num
    end
  end

  
  ## COMBOBOX
  def combobox_parent_label (label_name, text_pattern)
    element=browser.label(:text => /#{label_name}/).parent.text_field
    element.wait_until_present
    if element.value != text_pattern
      #if browser.div(:class => /DataInner/).exists?
      #  1.times { browser.div(:class => /DataInner/).send_keys :arrow_down } 
      #end
      element.clear
      element.send_keys text_pattern[0..2]
      sleep 1
      element2=browser.li(:text=>/#{text_pattern.split('').join('.*')}/)
      if element2.exists?
        element2.click
      else
        element.clear
        element.send_keys text_pattern
        sleep 1
        element.send_keys :arrow_down,:enter
      end
      wait_while_loading_gif
    end
  end
  
  
  ## SELECT LIST 
  def select_pulldown_parent_label(label_name, text_pattern)
    element=browser.label(:text => /#{label_name}/).parent.select_list
    #element.wait_until_present
    unless element.selected?(text_pattern)
      element.select text_pattern
      wait_while_loading_gif
    end
  end
  
  
  ## RADIO  
  def radio_parent_label_set(label_name)
    element=browser.label(:text => /#{label_name}/).parent.radio
    element.wait_until_present
    unless element.checked?
      #until element.checked?
        sleep 1
        element.set
      #end
    end
  end
  
  def radio_parent_label_clear(label_name)
    element=browser.label(:text => /#{label_name}/).parent.radio
    element.wait_until_present
    if element.checked?
      #while element.checked?
        sleep 1
        element.clear
      #end
    end
  end
  
  
  ## CHECKBOX
  def checkbox_parent_label_set(label_name)
    element=browser.label(:text => /#{label_name}/).parent.checkbox
    element.wait_until_present
    unless element.checked?
      #until element.checked?
        sleep 1
        element.set
      #end
    end
  end
  
  def checkbox_parent_label_clear(label_name)
    element=browser.label(:text => /#{label_name}/).parent.checkbox
    element.wait_until_present
    if element.checked?
      #while element.checked?
        sleep 1
        element.clear
      #end
    end
  end
  
end
include ElementLocatorHelper
