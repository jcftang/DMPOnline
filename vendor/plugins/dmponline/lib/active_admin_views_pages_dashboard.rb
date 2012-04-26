class ActiveAdmin::Views::Pages::Dashboard < ActiveAdmin::Views::Pages::Base

  private

  # Renders dashboard sections in div rather than table cells
  def render_sections(sections)
    div :class => "region" do
      sections.each do |section|
        render_section(section)
      end
    end
  end

end 
