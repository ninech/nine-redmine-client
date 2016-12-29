require 'ostruct'
require 'forwardable'

module RedmineClient
  HEADERS = {
    'User-Agent'    => 'Ruby.Redmine.Client',
    'Accept'        => 'application/json',
    'Content-Type'  => 'application/x-www-form-urlencoded',
  }.freeze

  class Base < OpenStruct
    include HTTParty

    format :json

    extend Forwardable
    def_delegators 'self.class', :delete, :get, :post, :put, :resource_path, :resource_name, :bad_response

    def update(attrs = {})
      resource = put "#{resource_path}/#{id}.json", body: { resource_name => attrs }
      if resource.success?
        data = Hash[attrs.map { |key, value| [key.to_sym, value] }]
        @table.merge!(data)
      else
        false
      end
    end

    class << self
      def setup
        base_uri RedmineClient::API.config.url
        headers HEADERS.merge('X-Redmine-API-Key' => RedmineClient::API.config.token)
      end

      def resource_path
        klass = name.split('::').last
        klass[0] = klass[0].chr.downcase
        klass.end_with?('y') ? "/#{klass.chop}ies" : "/#{klass}s"
      end

      def resource_name
        klass = name.split('::').last
        klass.downcase
      end

      def bad_response(response, _params = {})
        if response.class == HTTParty::Response
          case response.code
          when 404
            fail Errors::ResourceNotFoundException
          when 422
            fail Errors::UnprocessableEntityException, response
          when 500
            fail Errors::InternalErrorException
          else
            fail HTTParty::ResponseError, response
          end
        end

        fail StandardError, 'Unknown error'
      end

      def find(id)
        resource = get "#{resource_path}/#{id}.json"
        resource.ok? ? new(resource[resource_name]) : bad_response(resource, id)
      end

      def create(attrs = {})
        resource = post "#{resource_path}.json", body: { resource_name => attrs }
        if resource.success?
          data = attrs.merge resource[resource_name]
          new(data)
        else
          bad_response(resource, attrs)
        end
      end
    end
  end
end
