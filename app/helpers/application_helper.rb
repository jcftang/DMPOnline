module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end
  
  def slug_link(page)
    page.target_url.blank? ? pages_slug_path(:slug => page.slug) : page.target_url
  end

  def error_notices(error_text)
    content_for(:error_notices) { error_text }
  end
  
  def organisation_stylesheet
    unless current_organisation.blank? || !current_organisation.stylesheet.file?
      stylesheet_link_tag current_organisation.stylesheet.url
    else
      ''
    end
  end
  
  def organisation_logo
    unless current_organisation.blank? || !current_organisation.logo.file?
      image_tag(current_organisation.logo.url(:home), :alt => t('dmp.title') + ' - ' + t('dmp.strapline'))
    else
      image_tag('dmp_logo.png', :alt => t('dmp.title') + ' - ' + t('dmp.strapline'))
    end
  end
  
  def no_rss_feed
    base = controller_path.split('/').first
    base == 'admin' || base == 'devise'
  end

  def ajax_preloader
    controller.render_to_string partial: "layouts/preloader"
  end
  
  def plan_display(plan, attribute, date_format = :long, show_none = false)
    if plan.send(attribute).blank?
      if show_none
        content_tag :span, t('dmp.admin.none'), :class => 'empty'
      else 
        ""
      end
    else
      case attribute
      when :budget
        if plan.currency.nil? 
          if show_none
            content_tag :span, t('dmp.admin.none'), :class => 'empty'
          else 
            ""
          end
        else 
          number_to_currency(plan.budget, unit: plan.currency.symbol).force_encoding('UTF-8')
        end
      when :created_at, :updated_at, :start_date, :end_date
        l plan.send(attribute), format: date_format
      else
        plan.send(attribute).force_encoding('UTF-8')
      end
    end
  end

  # User categories 
  def translated_categories
     User::CATEGORIES.inject({}) do |hash, k|  
       hash.merge!(I18n.t("dmp.categories.#{k}") => k)
     end
  end

end
