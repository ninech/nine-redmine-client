module RedmineClient
  class Client
    include HTTParty

    def self.setup
      base_uri RedmineClient::API.config.url
      headers 'X-Redmine-API-Key' => RedmineClient::API.config.token
    end
  end
end
