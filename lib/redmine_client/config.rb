require 'active_support/configurable'
require 'rest_in_peace/faraday/ssl_config_creator'

module RedmineClient
  include ActiveSupport::Configurable

  def self.ssl_config
    return nil unless RedmineClient.config.ssl
    RESTinPeace::SSLConfigCreator.new(RedmineClient.config.ssl).faraday_options
  end

  def self.faraday_options
    {
      url: RedmineClient.config.api_url,
      ssl: RedmineClient.ssl_config,
      headers: { accept: 'application/json' },
    }
  end
end
