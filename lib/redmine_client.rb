require 'httparty'
require 'redmine_client/api'
require 'redmine_client/base'
require 'redmine_client/issue'

module RedmineClient
  class ResourceNotFoundException < Exception; end
end
