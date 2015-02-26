require 'faraday'
require 'faraday_middleware'
require 'active_support/configurable'
require 'rest_in_peace/faraday/ssl_config_creator'
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
          faraday.adapter :excon, client_key_pass: (config.ssl && config.ssl[:client_key_passphrase])
        end
      end

      def faraday_options
        {
          url: config.api_url,
          ssl: ssl_config,
          headers: {
            'Accept' => 'application/json',
          },
        }
      end

      def ssl_config
        return nil unless config.ssl
        { client_cert: config.ssl[:client_cert],
          client_key: config.ssl[:client_key],
          ca_file: config.ssl[:ca_cert] }
      end
    end
  end
end
