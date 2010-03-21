module Admin::BaseHelper
  
    
  def show_settings_menu?
    if current_user.admin && controller_name =~ /setting|categor|cities|city|location|maps|map|language|page/
      "mid_content"
    end
  end
  
  def show_field(label, field, options = {})
    "<div class=\"label_field\">
  		<div class=\"label\">#{label}</div>
      <div class=\"value\">#{field}</div>
    </div>"
  end

  def content_for_admin_menu(user=current_user)
    if user.admin && controller_name =~ /settings|categories|cities|locations|map|maps|language|page/
      render :partial => "/shared/admin/side_menus/admin"
    end
  end
  
  def asc_desc_helper
    if params[:order] && params[:order].match("ASC")
      result = "DESC"
    else
      result = "ASC"
    end
    if params[:order] && params[:order].match("DESC")
      result = "ASC"
    else
      result = "DESC"
    end
    return result
  end
  
  def sort_link_helper(title,name=nil)
    name ||= title.downcase
    link_to(title, :params => params.merge({:sort => name, :order => asc_desc_helper}) )
  end
  
  def ajax_spinner(spinner="spinner.gif")
    "<div id='spinner'> <img src='/images/#{spinner}' class='spinner' style='display:none;'> </div>"
  end
  
  def has_category(cat)
     if @item
        @item.categories.include?(cat)
     else
       false
     end
  end
  
  def activate_user_link(user)
    url_for :controller => "users",
      :action => "activate",
      :id => user.id
  end
  
  def deactivate_user_link(user)
    url_for :controller => "users",
      :action => "deactivate",
      :id => user.id
  end
  
  def approve_link(obj)
    if obj.approved
      link_to('Unapprove', 
        :controller => "admin/comments", :action => "unapprove", :id => obj
      )
    else
      link_to('Approve', 
        :controller => "admin/comments", :action => "approve", :id => obj
      )
    end
  end
  
  def is_current_menu(name)
    if controller.controller_name == name
      return "current"
    end
  end
  
  
  def highlighted(bol)
    if bol
      image_tag("/images/h.png")
    else
      ""
    end
  end
  
end
