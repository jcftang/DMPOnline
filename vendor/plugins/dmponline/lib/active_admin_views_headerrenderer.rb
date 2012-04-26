class ActiveAdmin::Views::HeaderRenderer < ::ActiveAdmin::Renderer

  protected

  def title
    if !active_admin_application.site_logo.empty?
      if !active_admin_application.site_title_link || active_admin_application.site_title_link == ""
        image_tag active_admin_application.site_logo, :alt => active_admin_application.site_title
      else
        link_to image_tag(active_admin_application.site_logo, :alt => active_admin_application.site_title), active_admin_application.site_title_link
      end
    else 
      if !active_admin_application.site_title_link || active_admin_application.site_title_link == ""
        content_tag 'h1', active_admin_application.site_title, :id => 'site_title'
      else
        content_tag 'h1', link_to(active_admin_application.site_title, active_admin_application.site_title_link), :id => 'site_title'
      end
    end
  end

end 
