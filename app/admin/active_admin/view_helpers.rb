module ActiveAdmin::ViewHelpers  
  
  def supported_locales
    Rails.application.config.supported_locales || ['en']
  end

end
