require 'active_support/configurable'

module RedmineClient
  class API
    def self.config
      @config ||= Configuration.new
    end

    def self.configure
      yield config
      Client.setup
    end
  end

  class API::Configuration
    include ActiveSupport::Configurable

    config_accessor(:url)
    config_accessor(:token)
  end
end
