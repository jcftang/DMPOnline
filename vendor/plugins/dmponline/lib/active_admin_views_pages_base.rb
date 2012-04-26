class ActiveAdmin::Views::Pages::Base < Arbre::HTML::Document

  private

  # Renders HTML Header - amended to add in IE9 fixes
  def build_active_admin_head
    within @head do
      meta :"http-equiv" => "Content-type", :content => "text/html; charset=utf-8"
      insert_tag Arbre::HTML::Title, [title, active_admin_application.site_title].join(" | ")
      active_admin_application.stylesheets.each do |style|
        text_node(stylesheet_link_tag(style.path, style.options).html_safe)
      end
      
      raw_tag "<!--[if IE 9]>"
      text_node(stylesheet_link_tag('active_admin/active_admin_ie9', {:media => "screen", :rel => "stylesheet", :type => "text/css"}).html_safe)
      raw_tag "<![endif]-->"

      active_admin_application.javascripts.each do |path|
        script :src => javascript_path(path), :type => "text/javascript"
      end
      
      text_node csrf_meta_tag
    end
  end


  # Add in the DCC banner
  def build_page
    within @body do
      div :id => "wrapper" do
        build_dcc_banner
        build_header
        build_title_bar
        build_page_content
        build_footer
      end
    end
  end

  def build_dcc_banner
    raw_tag render :partial => "/layouts/dccbanner"
  end

  # Renders the content for the footer
  # Default declaration: "Powered by #{link_to("Active Admin", "http://www.activeadmin.info")} #{ActiveAdmin::VERSION}".html_safe
  def build_footer
    div :id => "footer" do
      para "Copyright &copy; #{Date.today.year.to_s} #{link_to('Digital Curation Centre', 'http://www.dcc.ac.uk')}, The University of Edinburgh".html_safe
    end
  end

end 

# Raw tag element to allow the insertion of IE conditional tags.
class Arbre::HTML::RawTag < Arbre::HTML::Element

  builder_method :raw_tag

  # Builds a text node from a string
  def self.from_string(string)
    node = new
    node.build(string)
    node
  end

  def add_child(*args)
    raise "Raw tags cannot have children."
  end

  def build(string)
    @content = string
  end

  def tag_name
    nil
  end

  def to_s
    @content.to_s
  end

end
