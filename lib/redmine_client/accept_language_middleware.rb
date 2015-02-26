require 'faraday'

module RedmineClient
  class AcceptLanguageMiddleware < Faraday::Middleware
    DEFAULT_LOCALE = 'en'

    def initialize(app, options={})
      @app = app
    end

    def call(env)
      env[:request_headers][:accept_language] = defined_locale
      @app.call(env)
    end

    def defined_locale
      if defined?(I18n) && I18n.respond_to?(:locale)
        I18n.locale.to_s
      else
        DEFAULT_LOCALE
      end
    end
  end

  ::Faraday::Request.register_middleware accept_language: AcceptLanguageMiddleware
end
