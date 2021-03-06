module ElementLocatorHelper
  ## EXTEND WATIR::HTMLElement to add custom id
  Watir::HTMLElement.attributes << :customid
  Watir::HTMLElement.attributes << :customname
  Watir::HTMLElement.attributes << :refvarname
  Watir::HTMLElement.attributes << :uib_tooltip
  Watir::HTMLElement.attributes << :ng_model
  Watir::HTMLElement.attributes << :ng_click
  Watir::HTMLElement.attributes << :ng_bind_html
  Watir::HTMLElement.attributes << :ng_reflect_model

  ################################################################
  ## LINKS
  def link_id_click(id,el=browser)
    el.link(:id=>id).wait_until_present
    el.link(:id=>id).click    
  end

  def link_id_onclick(id,el=browser)
    el.link(:id=>id).wait_until_present
    el.link(:id=>id).fire_event('onclick')    
  end

  def link_text_click(id,el=browser)
    el.link(:text=>/#{id}/).wait_until_present
    el.link(:text=>/#{id}/).click    
  end
  
  def link_text_onclick(id,el=browser)
    el.link(:text=>/#{id}/).wait_until_present
    el.link(:text=>/#{id}/).fire_event('onclick')    
  end

  def link_name_click(id,el=browser)
    el.link(:name=>id).wait_until_present
    el.link(:name=>id).click    
  end

  def link_name_onclick(id,el=browser)
    el.link(:name=>id).wait_until_present
    el.link(:name=>id).fire_event('onclick')    
  end

  def link_class_click(id,el=browser)
    el.link(:class=>id).wait_until_present
    el.link(:class=>id).fire_event('onclick')    
  end

  def link_class_onclick(id,el=browser)
    el.link(:class=>id).wait_until_present
    el.link(:class=>id).fire_event('onclick')    
  end
 
  def link_title_click(id,el=browser)
    el.link(:title=>id).wait_until_present
    el.link(:title=>id).fire_event('onclick')    
  end
  
  def link_title_onclick(id,el=browser)
    el.link(:title=>id).wait_until_present
    el.link(:title=>id).fire_event('onclick')    
  end


  ################################################################
  ## BUTTON
  def button_id_click(text,el=browser)
    el.button(:id=>/#{text}/).wait_until_present
    el.button(:id=>/#{text}/).click
  end

  def button_id_onclick(text,el=browser)
    el.button(:id=>/#{text}/).wait_until_present
    el.button(:id=>/#{text}/).fire_event :click
  end

  def button_name_click(text,el=browser)
    el.button(:name=>/#{text}/).wait_until_present
    el.button(:name=>/#{text}/).click
  end

  def button_name_onclick(text,el=browser)
    el.button(:name=>/#{text}/).wait_until_present
    el.button(:name=>/#{text}/).fire_event :click
  end

  def button_class_click(text,el=browser)
    el.button(:class=>/#{text}/).wait_until_present
    el.button(:class=>/#{text}/).click
  end

  def button_class_onclick(text,el=browser)
    el.button(:class=>/#{text}/).wait_until_present
    el.button(:class=>/#{text}/).fire_event :click
  end

  def button_text_click(text,el=browser)
    el.button(:text=>/#{text}/).wait_until_present
    el.button(:text=>/#{text}/).click
  end

  def button_text_onclick(text,el=browser)
    el.button(:text=>/#{text}/).wait_until_present
    el.button(:text=>/#{text}/).fire_event :click
  end

  def button_value_click(text,el=browser)
    el.button(:value=>/#{text}/).wait_until_present
    el.button(:value=>/#{text}/).click
  end

  def button_value_onclick(text,el=browser)
    el.button(:value=>/#{text}/).wait_until_present
    el.button(:value=>/#{text}/).fire_event :click
  end

  def button_uib_tooltip_click(text,el=browser)
    el.button(:uib_tooltip=>/#{text}/).wait_until_present
    el.button(:uib_tooltip=>/#{text}/).click
  end

  def button_uib_tooltip_onclick(text,el=browser)
    el.button(:uib_tooltip=>/#{text}/).wait_until_present
    el.button(:uib_tooltip=>/#{text}/).fire_event :click
  end
  
  ## BUTTON-SPAN
  def span_button_text_click(text,el=browser)
    # browser.div(:id=>'ApprTitleExp').span(:class=>'ui-button-text',:text=>'Edit').parent.click
    el.span(:class=>'ui-button-text',:text=>/#{text}/).wait_until_present
    el.span(:class=>'ui-button-text',:text=>/#{text}/).click        
  end

  ################################################################
  ## TEXT FIELD
  def text_field_id(label_name,text_pattern,el=browser)
    el.text_field(:id => /#{label_name}/).wait_until_present
    element=el.text_field(:id => /#{label_name}/)
    if element.value != text_pattern
      element.set text_pattern
    end
  end
  
  def text_field_name(label_name,text_pattern,el=browser)
    el.text_field(:name => /#{label_name}/).wait_until_present
    element=el.text_field(:name => /#{label_name}/)
    if element.value != text_pattern
      element.set text_pattern
    end
  end

  def text_field_class(label_name,text_pattern,el=browser)
    el.text_field(:class => /#{label_name}/).wait_until_present
    element=el.text_field(:class => /#{label_name}/)
    if element.value != text_pattern
      element.set text_pattern
    end
  end
  
  def text_field_parent_label(label_name,text_pattern,el=browser)
    el.label(:text => /#{label_name}/).wait_until_present
    element=el.label(:text => /#{label_name}/)
    if element.parent.text_field.value != text_pattern
      element.parent.text_field.set text_pattern
    end
  end

  def text_field_grandparent_label(label_name,text_pattern,el=browser)
    el.label(:text => /#{label_name}/).wait_until_present
    element=el.label(:text => /#{label_name}/)
    if element.parent.parent.text_field.value != text_pattern
      element.parent.parent.text_field.set text_pattern
    end
  end
    
  ## (TEXT FIELD) DATE FIELD
  def date_field_id(label_name,date,el=browser)
    date.gsub!('/','-')
    text_field_id(label_name,date,el)
  end
  
  ## (TEXT FIELD) DATE FIELD
  def date_field_parent_label(label_name,date,el=browser)
    date.gsub!('/','-')
    text_field_parent_label(label_name , date,el)
  end

  ## (TEXT FIELD) DATE FIELD
  def date_field_grandparent_label(label_name,date,el=browser)
    date.gsub!('/','-')
    text_field_grandparent_label(label_name , date,el)
  end
  
  ## (TEXT FIELD) TAX NUMBER
  def tax_number_parent_label(label_name,tax_num,el=browser)
    ##tax field 12-3456789
    tax_num.gsub!('-','')
    text_field_parent_label(label_name , tax_num,el)
  end
  
  ## (TEXT FIELD) PHONE NUMBER
  def phone_number_parent_label(label_name,phone_num,el=browser)
    ##1 text field for (012)345-6789
    phone_num.gsub!('-','')
    phone_num.gsub!('(','')
    phone_num.gsub!(')','')
    text_field_parent_label(label_name , phone_num,el)
  end
 
  ## (TEXT FIELD) PHONE NUMBER
  def phone_with_area_code_parent_label(label_name,phone_num,el=browser)
    #2 text fields: (012) and 345-6789
    phone_num.gsub!('-','')
    phone_num.gsub!('(','')
    phone_num.gsub!(')','')
    el.label(:text => /#{label_name}/).wait_until_present
    element=el.label(:text => /#{label_name}/)
    element.parent.text_fields[0].set phone_num[0..2]
    element.parent.text_fields[1].set phone_num[3..9]
  end


  ################################################################
  ## TEXTAREA
  def textarea_id(label_name , text_pattern,el=browser)
    el.textarea(:id => /#{label_name}/).wait_until_present
    element=el.textarea(:id => /#{label_name}/)
    if element.value != text_pattern
      element.set text_pattern
    end
  end
  
  def textarea_name(label_name , text_pattern,el=browser)
    el.textarea(:name => /#{label_name}/).wait_until_present
    element=el.textarea(:name => /#{label_name}/)
    if element.value != text_pattern
      element.set text_pattern
    end
  end

  def textarea_class(label_name , text_pattern,el=browser)
    el.textarea(:class => /#{label_name}/).wait_until_present
    element=el.textarea(:class => /#{label_name}/)
    if element.value != text_pattern
      element.set text_pattern
    end
  end
  
  def textarea_parent_label(label_name , text_pattern,el=browser)
    el.label(:text => /#{label_name}/).wait_until_present
    element=el.label(:text => /#{label_name}/)
    if element.parent.textarea.value != text_pattern
      element.parent.textarea.set text_pattern
    end
  end

  def textarea_grandparent_label(label_name , text_pattern,el=browser)
    el.label(:text => /#{label_name}/).wait_until_present
    element=el.label(:text => /#{label_name}/)
    if element.parent.parent.textarea.value != text_pattern
      element.parent.parent.textarea.set text_pattern
    end
  end
    
  
  ################################################################
  ## RADIO
  def radio_id_set(label_name,el=browser)
    element=el.radio(:id => /#{label_name}/)
    element.wait_until_present
    # unless element.checked?
      # sleep 1
      element.set
    # end
  end
  
  def radio_id_clear(label_name,el=browser)
    element=el.radio(:id => /#{label_name}/)
    element.wait_until_present
    # if element.checked?
      # sleep 1
      element.clear
    # end
  end

  def radio_name_set(label_name,el=browser)
    element=el.radio(:name => /#{label_name}/)
    element.wait_until_present
    # unless element.checked?
      # sleep 1
      element.set
    # end
  end
  
  def radio_id_clear(label_name,el=browser)
    element=el.radio(:name => /#{label_name}/)
    element.wait_until_present
    # if element.checked?
      # sleep 1
      element.clear
    # end
  end

  def radio_class_set(label_name,el=browser)
    element=el.radio(:class => /#{label_name}/)
    element.wait_until_present
    # unless element.checked?
      # sleep 1
      element.set
    # end
  end
  
  def radio_class_clear(label_name,el=browser)
    element=el.radio(:class => /#{label_name}/)
    element.wait_until_present
    # if element.checked?
      # sleep 1
      element.clear
    # end
  end

  def radio_value_set(label_name,el=browser)
    element=el.radio(:value => /#{label_name}/)
    element.wait_until_present
    # unless element.checked?
      # sleep 1
      element.set
    # end
  end

  def radio_value_clear(label_name,el=browser)
    element=el.radio(:value => /#{label_name}/)
    element.wait_until_present
    # unless element.checked?
      # sleep 1
      element.clear
    # end
  end
    
  def radio_parent_label_set(label_name,index=0,el=browser)
    el.label(:text => /#{label_name}/).wait_until_present
    element=el.label(:text => /#{label_name}/).parent.radios[index]
    # unless element.checked?
      # sleep 1
      element.set
    # end
  end

  def radio_parent_label_clear(label_name,index=0,el=browser)
    el.label(:text => /#{label_name}/).wait_until_present
    element=el.label(:text => /#{label_name}/).parent.radios[index]
    # unless element.checked?
      # sleep 1
      element.clear
    # end
  end

  def radio_parent_td_set(label_name,index=0,el=browser)
    el.td(:text => /#{label_name}/).wait_until_present
    element=el.td(:text => /#{label_name}/).parent.radios[index]
    # unless element.checked?
      # sleep 1
      element.set
    # end
  end
  
  def radio_parent_td_clear(label_name,index=0,el=browser)
    el.td(:text => /#{label_name}/).wait_until_present
    element=el.td(:text => /#{label_name}/).parent.radios[index]
    # unless element.checked?
      # sleep 1
      element.clear
    # end
  end
  

  ################################################################
  ## CHECKBOX
  def checkbox_id_set(label_name,el=browser)
    element=el.checkbox(:id => /#{label_name}/)
    element.wait_until_present
    # unless element.checked?
      # sleep 1
      element.set
    # end    
  end
  
  def checkbox_id_clear(label_name,el=browser)
    element=el.checkbox(:id => /#{label_name}/)
    element.wait_until_present
    # if element.checked?
      # sleep 1
      element.clear
    # end    
  end
  
  def checkbox_name_set(label_name,el=browser)
    element=el.checkbox(:name => /#{label_name}/)
    element.wait_until_present
    # unless element.checked?
      # sleep 1
      element.set
    # end    
  end
  
  def checkbox_name_clear(label_name,el=browser)
    element=el.checkbox(:name => /#{label_name}/)
    element.wait_until_present
    # if element.checked?
      # sleep 1
      element.clear
    # end    
  end
  
  def checkbox_class_set(label_name,el=browser)
    element=el.checkbox(:class => /#{label_name}/)
    element.wait_until_present
    # unless element.checked?
      # sleep 1
      element.set
    # end    
  end
  
  def checkbox_class_clear(label_name,el=browser)
    element=el.checkbox(:class => /#{label_name}/)
    element.wait_until_present
    # if element.checked?
      # sleep 1
      element.clear
    # end    
  end

  
  def checkbox_parent_label_set(label_name,el=browser)
    el.label(:text => /#{label_name}/).wait_until_present
    element=el.label(:text => /#{label_name}/).parent.checkbox
    # unless element.checked?
      # sleep 1
      element.set
    # end    
  end
  
  def checkbox_parent_label_clear(label_name,el=browser)
    el.label(:text => /#{label_name}/).wait_until_present
    element=el.label(:text => /#{label_name}/).parent.checkbox
    # if element.checked?
      # sleep 1
      element.clear
    # end    
  end
  
  def checkbox_parent_span_set(label_name,el=browser)
    el.span(:text => /#{label_name}/).wait_until_present
    element=el.span(:text => /#{label_name}/).parent.checkbox
    # unless element.checked?
      # sleep 1
      element.set
    # end    
  end
  
  def checkbox_parent_span_clear(label_name,el=browser)
    el.span(:text => /#{label_name}/).wait_until_present
    element=el.span(:text => /#{label_name}/).parent.checkbox
    # unless element.checked?
      # sleep 1
      element.clear
    # end    
  end

  def checkbox_ng_model_set(label_name,el=browser)
    element=el.checkbox(:ng_model => /#{label_name}/).wait_until_present
    # unless element.checked?
      # sleep 1
      element.set
    # end   
  end

  def checkbox_ng_model_clear(label_name,el=browser)
    element=el.checkbox(:ng_model => /#{label_name}/).wait_until_present
    # unless element.checked?
      # sleep 1
      element.clear
    # end   
  end

  ################################################################
  ## SELECT LIST
  def select_list_id(label_name, text_pattern,el=browser)
    element=el.select_list(:id => /#{label_name}/)
    unless element.selected?(text_pattern)
      sleep 1
      element.select text_pattern
    end
  end

  def select_list_name(label_name, text_pattern,el=browser)
    element=el.select_list(:name => /#{label_name}/)
    unless element.selected?(text_pattern)
      sleep 1
      element.select text_pattern
    end
  end

  def select_list_class(label_name, text_pattern,el=browser)
    element=el.select_list(:class => /#{label_name}/)
    unless element.selected?(text_pattern)
      sleep 1
      element.select text_pattern
    end
  end 
  
  def select_list_parent_label(label_name, text_pattern,el=browser)
    element=el.label(:text => /#{label_name}/).parent.select_list
    unless element.selected?(text_pattern)
      sleep 1
      element.select text_pattern
    end
  end
  
  def select_list_grandparent_label(label_name, text_pattern,el=browser)
    element=el.label(:text => /#{label_name}/).parent.parent.select_list
    unless element.selected?(text_pattern)
      sleep 1
      element.select text_pattern
    end
  end


  ################################################################
  ## COMBOBOX (AUTOCOMPLETE)
  def combobox_id(label_name, text_pattern,el=browser)
    el.text_field(:id=>/#{label_name}/).wait_until_present    
    element=el.text_field(:id=>/#{label_name}/)
    if element.value != text_pattern
      element.send_keys [:control,'a'], :backspace
      element.set text_pattern      
      browser.li(:text=>/^#{text_pattern.split('').join('.*')}/i).when_present.click rescue nil
    end
  end

  def combobox_name(label_name, text_pattern,el=browser)
    el.text_field(:name=>/#{label_name}/).wait_until_present    
    element=el.text_field(:name=>/#{label_name}/)
    if element.value != text_pattern
      element.send_keys [:control,'a'], :backspace
      element.set text_pattern      
      browser.li(:text=>/^#{text_pattern.split('').join('.*')}/i).when_present.click rescue nil
    end
  end

  def combobox_class(label_name, text_pattern,el=browser)
    el.text_field(:class=>/#{label_name}/).wait_until_present    
    element=el.text_field(:class=>/#{label_name}/)
    if element.value != text_pattern
      element.send_keys [:control,'a'], :backspace
      element.set text_pattern      
      browser.li(:text=>/^#{text_pattern.split('').join('.*')}/i).when_present.click rescue nil
    end
  end

  def combobox_customname(label_name, text_pattern,el=browser)
    el.text_field(:customname=>/#{label_name}/).wait_until_present
    element=el.text_field(:customname=>/#{label_name}/)
    if element.value != text_pattern
      element.send_keys [:control,'a'], :backspace
      element.set text_pattern
      browser.li(:text=>/^#{text_pattern.split('').join('.*')}/i).when_present.click rescue nil
    end   
  end
   
  def combobox_parent_label (label_name, text_pattern)
    browser.label(:text => /#{label_name}/).wait_until_present
    element=browser.label(:text => /#{label_name}/)
    if element.parent.text_field.value != text_pattern
      element.parent.text_field.send_keys [:control,'a'], :backspace
      element.parent.text_field.set text_pattern
      browser.li(:text=>/^#{text_pattern.split('').join('.*')}/i).when_present.click rescue nil
    end
  end
  
  def combobox_grandparent_label (label_name, text_pattern)
    browser.label(:text => /#{label_name}/).wait_until_present
    element=browser.label(:text => /#{label_name}/)
    if element.parent.parent.text_field.value != text_pattern
      element.parent.parent.text_field.send_keys [:control,'a'], :backspace
      element.parent.parent.text_field.set text_pattern
      browser.li(:text=>/^#{text_pattern.split('').join('.*')}/).when_present.click rescue nil
    end    
  end

  def combo_box_parent_label_click_link(label_name,text_pattern)
    browser.label(:text=>/#{label_name}/).wait_until_present
    browser.label(:text=>/#{label_name}/).parent.links[-1].click
    #browser.label(:text=>/#{label_name}/).parent.text_field.set text_pattern
    browser.li(:text=>text_pattern).when_present.click rescue nil    
  end
 

  ################################################################
  ## ANGULAR SEARCH BOX (AUTOCOMPLETE)
  def search_parent_label(label,pattern)
    browser.label(:text=>/#{label}/).parent.span(:ng_click=>/activate/).wait_until_present(60).click
    browser.label(:text=>/#{label}/).parent.text_fields[0].wait_until_present.set pattern
    browser.div(:ng_bind_html=>/option.label/, :text=>/#{pattern}/).wait_until_present.click
  end

  def search_grandparent_label(label,pattern)
    browser.label(:text=>/#{label}/).parent.parent.span(:ng_click=>/activate/).wait_until_present.click
    browser.label(:text=>/#{label}/).parent.parent.text_fields[0].wait_until_present.set pattern
    browser.div(:ng_bind_html=>/option.label/ , :text=>/#{pattern}/).wait_until_present.click
  end


  ################################################################
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
    el.link(:text=>/^#{text_pattern}/).wait_until_present(60)
    el.link(:text=>/^#{text_pattern}/).parent.parent.link(:class=>/Actionmenu/i).when_present(60).click
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
    
    # browser.link(:text=>/#{action}/).when_present.flash
    browser.link(:text=>/#{action}/).when_present.fire_event :click    
  end


  ################################################################
  ## Rich Text Format (rtf)
  def rtf_parent_label(label_name,comment,el=browser)
    ##i.e. comment=@risk_mitigant[:comments_source]
    el.label(:text=>/#{label_name}/).parent.div(:class=>'richTxtArea').click
    
    phrase="CKEDITOR.instances.richTxt.setData('#{comment}'); "
    el.execute_script( "#{phrase}")
    sleep 1

    el.span(:class=>/ui-button/,:text=>/Ok/).parent.fire_event('onclick')
    
  end

  def rtf_div_id(label_name,comment,el=browser)
    ##i.e. comment=@risk_mitigant[:comments_source]
    el.div(:id=> /#{label_name}/ , :class=>'richTxtArea').click
    
    phrase="CKEDITOR.instances.richTxt.setData('#{comment}'); "
    el.execute_script( "#{phrase}")
    sleep 1

    el.span(:class=>/ui-button/,:text=>/Ok/).parent.fire_event('onclick')
    
  end


  ################################################################
  ## FOLDERTREE
  def foldertree_folder_span_text(text,el=browser)
    browser.div(:class=>'RepoFolderTreeClass').wait_until_present
    unless el.uls(:class=>/RepoFolders/)[-1].span(:text=>/#{text}/).parent.attribute_value('class').include? 'closed collapsable'
      el.uls(:class=>/RepoFolders/)[-1].span(:text=>text).when_present.click rescue nil
      
    end
  end

  def foldertree_span_text(text,el=browser)
    browser.div(:class=>'RepoFolderTreeClass').wait_until_present
    el.uls(:class=>/RepoFolders/)[-1].span(:text=>text).when_present.click rescue nil    
  end

end
include ElementLocatorHelper
