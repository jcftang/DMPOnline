module Admin::PagesHelper

  def menu_options
    h = {}
    Page::MENU.each_with_index do |v, i| 
      h[v.humanize] = i
    end
    h
  end

end
