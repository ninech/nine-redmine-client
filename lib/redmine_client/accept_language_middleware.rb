require 'faraday'

module RedmineClient
  class AcceptLanguageMiddleware < Faraday::Middleware
    DEFAULT_LOCALE = 'de'

    def initialize(app, options={})
      @app = app
    end

    def call(env)
      env[:request_headers][:accept_language] = defined_locale
      @app.call(env)
    end

    def defined_locale
      I18n.locale.to_s
    rescue
      DEFAULT_LOCALE
    end
  end

  ::Faraday::Request.register_middleware accept_language: AcceptLanguageMiddleware
end
