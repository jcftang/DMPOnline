require 'i18n'

class DetermineLocale

  def initialize(app, supported_locales = ['en'])
    @app = app
    @supported_locales = supported_locales
  end
  
  def call(env)
    old_locale = I18n.locale
    locale = nil
    
    request = Rack::Request.new(env)
    params = request.params
    param_locale = params['locale'] || ''
    locale = ([param_locale] & @supported_locales).first  

    # http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.4
    if locale.blank? && lang = env["HTTP_ACCEPT_LANGUAGE"]
      lang = lang.split(",").map { |l|
      l += ';q=1.0' unless l =~ /;q=\d+\.\d+$/
      l.split(';q=')
      }.first
      locale = lang.first.split("-").first
      locale = ([locale] & @supported_locales).first  
    else
      locale = I18n.default_locale
    end
    
    locale = env['rack.locale'] = I18n.locale = locale.to_s
    
    status, headers, body = @app.call(env)
    headers['Content-Language'] = locale
    I18n.locale = old_locale
    [status, headers, body]
  end
end
