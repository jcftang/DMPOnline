class PostsController < ApplicationController
  respond_to :html
  
  # GET /news
  # GET /news.rss
  def index
    respond_to do |format|
      format.html do
        @posts = Post.for_org(current_organisation).page(params[:page]).per(5)
      end
      format.rss do
        @posts = Post.for_org(current_organisation).limit(15)
        render :layout => false
      end
    end
  end

  # GET /news/1
  def show
    @post = Post.for_org(current_organisation).find(params[:id])
  end

end
