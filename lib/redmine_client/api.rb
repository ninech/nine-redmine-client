require 'active_support/configurable'

module RedmineClient
  module API
    include ActiveSupport::Configurable

    class << self
      def api
        @api ||= Faraday.new(faraday_options) do |faraday|
          faraday.request :xml
          faraday.response :xml, content_type: /\bxml$/
          faraday.response :rip_raise_errors

          faraday.adapter Faraday.default_adapter
        end
      end

      def faraday_options
        {
          url: config.api_url,
          headers: {
            # 'Accept' => 'application/json',
            'X-Redmine-API-Key' => config.api_key,
          },
        }
      end
    end
  end
end
