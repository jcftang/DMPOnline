module Dmponline 
  class << self
    
    def supported_locales
      Rails.application.config.supported_locales || ['en']
    end
    

  end
end 
