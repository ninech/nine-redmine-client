require 'faraday'
require 'faraday_middleware'
require 'active_support/configurable'
require 'rest_in_peace/faraday/raise_errors_middleware'

module RedmineClient
  module API
    include ActiveSupport::Configurable

    class << self
      def api
        @api ||= Faraday.new(faraday_options) do |faraday|
          faraday.request :url_encoded             # form-encode POST params
          faraday.request :accept_language
          faraday.response :json, content_type: /\bjson$/
          faraday.response :rip_raise_errors
        end
      end

      def faraday_options
        {
          url: config.api_url,
          headers: {
            'Accept' => 'application/json',
            'X-Redmine-API-Key' => config.api_key,
          },
        }
      end
    end
  end
end
