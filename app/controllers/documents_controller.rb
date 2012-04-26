class DocumentsController < ApplicationController
  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.page(params[:page]).per(15)
    @page = Page.for_org(current_organisation).find_by_slug('documents')

    respond_to do |format|
      format.html # index.html.erb
    end
  end

end
