class PagesController < ApplicationController

  def frontpage
    @news_block = render_to_string :partial => "posts/news_block", :locals => { :news => Post.find_for_block(current_organisation) }
    @page = Page.for_org(current_organisation).find_by_slug('home')
  end
  
  # GET /pages/1
  def show
    @page = Page.for_org(current_organisation).find_by_slug!(params[:slug])

    respond_to do |format|
      format.html
    end
  end
  
end
