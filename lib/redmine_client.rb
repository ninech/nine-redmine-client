module RedmineClient
  def self.use_relative_model_naming?
    true
  end
end

require 'redmine_client/errors'
require 'redmine_client/accept_language_middleware'
require 'redmine_client/api'
