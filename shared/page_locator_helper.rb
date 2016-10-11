module ElementLocatorHelper
  ## EXTEND WATIR::HTMLElement to add custom id
  Watir::HTMLElement.attributes << :customid
  Watir::HTMLElement.attributes << :customname
  
  
  ## BUTTON
  def button_text_click(text)
    browser.button(:text=>text).wait_until_present
    browser.button(:text=>text).click
  end

  def button_text_onclick(text)
    browser.button(:text=>text).wait_until_present
    browser.button(:text=>text).fire_event :click
  end


  ## TEXT FIELD
  def text_field_id(label_name , text_pattern)
    browser.text_field(:id => /#{label_name}/).wait_until_present
    element=browser.text_field(:id => /#{label_name}/)
    if element.value != text_pattern
      element.set text_pattern
      element.send_keys :tab if browser.table(:class=>'ui-datepicker-calendar').present?
    end
  end
  
  def text_field_name(label_name , text_pattern)
    browser.text_field(:name => /#{label_name}/).wait_until_present
    element=browser.text_field(:name => /#{label_name}/)
    if element.value != text_pattern
      element.set text_pattern
      element.send_keys :tab if browser.table(:class=>'ui-datepicker-calendar').present?
    end
  end
  
  def text_field_parent_label(label_name , text_pattern)
    browser.label(:text => /#{label_name}/).wait_until_present
    element=browser.label(:text => /#{label_name}/)
    if element.parent.text_field.value != text_pattern
      element.parent.text_field.set text_pattern
      element.parent.text_field.send_keys :tab if browser.table(:class=>'ui-datepicker-calendar').present?
    end
  end

  def text_field_grandparent_label(label_name , text_pattern)
    browser.label(:text => /#{label_name}/).wait_until_present
    element=browser.label(:text => /#{label_name}/)
    if element.parent.parent.text_field.value != text_pattern
      element.parent.parent.text_field.set text_pattern
      element.parent.parent.text_field.send_keys :tab if browser.table(:class=>'ui-datepicker-calendar').present?
    end
  end
    
  ## (TEXT FIELD) DATE FIELD
  def date_field_id(label_name , date)
    date.gsub!('/','-')
    text_field_id(label_name , date)        
  end
  
  ## (TEXT FIELD) DATE FIELD
  def date_field_parent_label(label_name , date)
    date.gsub!('/','-')
    text_field_parent_label(label_name , date)
  end
  
  ## (TEXT FIELD) TAX NUMBER
  def tax_number_parent_label(label_name , tax_num)
    ##tax field 12-3456789
    tax_num.gsub!('-','')
    text_field_parent_label(label_name , tax_num)
  end
  
  ## (TEXT FIELD) PHONE NUMBER
  def phone_number_parent_label(label_name , phone_num)
    ##1 text field for (012)345-6789
    phone_num.gsub!('-','')
    phone_num.gsub!('(','')
    phone_num.gsub!(')','')
    text_field_parent_label(label_name , phone_num)
  end
 
  ## (TEXT FIELD) PHONE NUMBER
  def phone_with_area_code_parent_label(label_name , phone_num)
    #2 text fields: (012) and 345-6789
    phone_num.gsub!('-','')
    phone_num.gsub!('(','')
    phone_num.gsub!(')','')
    browser.label(:text => /#{label_name}/).wait_until_present
    element=browser.label(:text => /#{label_name}/)
    element.parent.text_fields[0].set phone_num[0..2]
    element.parent.text_fields[1].set phone_num[3..9]
  end
  
  
  ## COMBOBOX
  def combobox_id(label_name, text_pattern)
    browser.text_field(:id=>/#{label_name}/).wait_until_present    
    element=browser.text_field(:id=>/#{label_name}/)    
    if element.value != text_pattern
      element.send_keys [:control,'a'], :backspace
      element.set text_pattern
      wait_while_loading_gif
      browser.li(:text=>/#{text_pattern.split('').join('.*')}/i).when_present.click rescue nil
      wait_while_loading_gif
    end
  end

  def combobox_customname(label_name, text_pattern)
    browser.text_field(:customname=>/#{label_name}/).wait_until_present    
    element=browser.text_field(:customname=>/#{label_name}/)    
    if element.value != text_pattern
      element.send_keys [:control,'a'], :backspace
      element.set text_pattern
      wait_while_loading_gif
      browser.li(:text=>/#{text_pattern.split('').join('.*')}/i).when_present.click rescue nil
      wait_while_loading_gif
    end    
  end
   
  def combobox_parent_label (label_name, text_pattern)
    browser.label(:text => /#{label_name}/).wait_until_present
    element=browser.label(:text => /#{label_name}/)
    if element.parent.text_field.value != text_pattern
      element.parent.text_field.send_keys [:control,'a'], :backspace
      element.parent.text_field.set text_pattern
      wait_while_loading_gif
      browser.li(:text=>/#{text_pattern.split('').join('.*')}/i).when_present.click rescue nil
      wait_while_loading_gif
    end
    wait_while_loading_gif
  end
  
  def combobox_grandparent_label (label_name, text_pattern)
    browser.label(:text => /#{label_name}/).wait_until_present
    element=browser.label(:text => /#{label_name}/)
    if element.parent.parent.text_field.value != text_pattern
      element.parent.parent.text_field.send_keys [:control,'a'], :backspace
      element.parent.parent.text_field.set text_pattern
      wait_while_loading_gif
      browser.li(:text=>/#{text_pattern.split('').join('.*')}/).when_present.click rescue nil
      wait_while_loading_gif
    end
  end

  def combo_box_parent_label_click_link(label_name,text_pattern)
    browser.label(:text=>/#{label_name}/).wait_until_present
    browser.label(:text=>/#{label_name}/).parent.links[-1].click
    wait_while_loading_gif
    #browser.label(:text=>/#{label_name}/).parent.text_field.set text_pattern
    #wait_while_loading_gif       
    browser.li(:text=>text_pattern).when_present.click rescue nil
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
    wait_while_loading_gif
  end
  
  def checkbox_id_clear(label_name)    
    element=browser.checkbox(:id => /#{label_name}/)
    element.wait_until_present
    if element.checked?
      sleep 1
      element.clear
    end
    wait_while_loading_gif
  end
  
  def checkbox_parent_label_set(label_name)
    browser.label(:text => /#{label_name}/).wait_until_present
    element=browser.label(:text => /#{label_name}/).parent.checkbox
    unless element.checked?
      sleep 1
      element.set
    end
    wait_while_loading_gif
  end
  
  def checkbox_parent_label_clear(label_name)
    browser.label(:text => /#{label_name}/).wait_until_present
    element=browser.label(:text => /#{label_name}/).parent.checkbox
    if element.checked?
      sleep 1
      element.clear
    end
    wait_while_loading_gif
  end
  
  def checkbox_parent_span_set(label_name)
    browser.span(:text => /#{label_name}/).wait_until_present
    element=browser.span(:text => /#{label_name}/).parent.checkbox
    unless element.checked?
      sleep 1
      element.set
    end
    wait_while_loading_gif
  end
  
  def checkbox_parent_span_clear(label_name)
    browser.span(:text => /#{label_name}/).wait_until_present
    element=browser.span(:text => /#{label_name}/).parent.checkbox
    unless element.checked?
      sleep 1
      element.clear
    end
    wait_while_loading_gif
  end


  ## LINKS
  def link_id_click(id)
    browser.link(:id=>id).wait_until_present
    browser.link(:id=>id).click
    wait_while_loading_gif
  end

  def link_id_onclick(id)
    browser.link(:id=>id).wait_until_present
    browser.link(:id=>id).fire_event('onclick')
    wait_while_loading_gif
  end

  def link_text_click(id,el=browser)
    el.wait_until_present
    el.link(:text=>/#{id}/).wait_until_present
    el.link(:text=>/#{id}/).click
    wait_while_loading_gif
  end
  
  def link_text_onclick(id,el=browser)
    el.wait_until_present
    el.link(:text=>/#{id}/).wait_until_present
    el.link(:text=>/#{id}/).fire_event('onclick')
    wait_while_loading_gif
  end

  def link_name_click(id)
    browser.link(:name=>id).wait_until_present
    browser.link(:name=>id).click
    wait_while_loading_gif
  end

  def link_name_onclick(id)
    browser.link(:name=>id).wait_until_present
    browser.link(:name=>id).fire_event('onclick')
    wait_while_loading_gif
  end

  def link_class_click(id)
    browser.link(:class=>id).wait_until_present
    browser.link(:class=>id).fire_event('onclick')
    wait_while_loading_gif
  end

  def link_class_onclick(id)
    browser.link(:class=>id).wait_until_present
    browser.link(:class=>id).fire_event('onclick')
    wait_while_loading_gif
  end


  ## ACTION MENU
  def actionmenu_parent_td(text_pattern,action,el=browser)
    ## el could be:  ,el=browser.div(:id=>/taskManagmnt/)
    el.wait_until_present unless el==browser
    el.td(:text=>text_pattern).wait_until_present
    el.td(:text=>text_pattern).parent.link(:class=>/Actionmenu/i).when_present.click
    actionmenu_select_action(action)
  end
 
  def actionmenu_grandparent_td(text_pattern,action,el=browser)
    ## el could be:  ,el=browser.div(:id=>/taskManagmnt/)
    el.wait_until_present unless el==browser
    el.td(:text=>text_pattern).wait_until_present
    el.td(:text=>text_pattern).parent.parent.link(:class=>/Actionmenu/i).when_present.click
    actionmenu_select_action(action)
  end

  def actionmenu_grandparent_link(text_pattern,action,el=browser)
    ## el could be:  ,el=browser.div(:id=>/taskManagmnt/)
    el.wait_until_present unless el==browser unless el==browser
    el.link(:text=>text_pattern).wait_until_present(60)
    el.link(:text=>text_pattern).parent.parent.link(:class=>/Actionmenu/i).when_present(60).click
    actionmenu_select_action(action)
  end

  def actionmenu_parent_div(text_pattern,action,el=browser)
    ## el could be:  ,el=browser.div(:id=>/taskManagmnt/)
    el.wait_until_present unless el==browser
    el.div(:text=>text_pattern).wait_until_present
    el.div(:text=>text_pattern).parent.link(:class=>/Actionmenu/i).when_present.click
    actionmenu_select_action(action)
  end

  def actionmenu_parent_div_title(text_pattern,action,el=browser)
    ## el could be:  ,el=browser.div(:id=>/taskManagmnt/)
    el.wait_until_present unless el==browser
    el.div(:title=>text_pattern).wait_until_present
    el.div(:title=>text_pattern).parent.link(:class=>/Actionmenu/i).when_present.click
    actionmenu_select_action(action) 
  end

  def actionmenu_select_action(action)
    ## NOT A REAL PAGE_LOCATOR-just a helper
    ## DONT KNOW WHY BUT action needs to be in regex even if it contains the whole word; so dont change below.
    wait_while_loading_gif
    browser.link(:text=>/#{action}/).when_present.flash
    browser.link(:text=>/#{action}/).fire_event :click
    wait_while_loading_gif
  end

end
include ElementLocatorHelper
