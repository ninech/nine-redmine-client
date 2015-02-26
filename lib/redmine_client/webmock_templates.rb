require 'json'

module RedmineClient
  module WebMockTemplates
    REDMINE_API_URL = 'http://redmine.test'.freeze

    def self.stub_find(uri, attributes)
      WebMock::API.stub_request(:get, "#{REDMINE_API_URL}#{uri}").
        to_return(status: 200, body: attributes.to_json, headers: { 'Content-Type' => 'application/json' })
    end

    def self.stub_all(uri, body)
      WebMock::API.stub_request(:get, "#{REDMINE_API_URL}#{uri}").
        to_return(status: 200, body: body.to_json, headers: {
          'Content-Type' => 'application/json',
          'X-Pagination' => {
            'total_count' => '20',
            'per_page'    => '20',
            'page'        => '1'
          }.to_json
        })
    end

    def self.stub_save(uri, attributes)
      WebMock::API.stub_request(:put, "#{REDMINE_API_URL}#{uri}").
        to_return(status: 200, body: attributes.to_json, headers: { 'Content-Type' => 'application/json' })
    end

    def self.stub_save_fail(uri, response_body, status)
      WebMock::API.stub_request(:put, "#{REDMINE_API_URL}#{uri}").
        to_return(
          body: response_body.to_json,
          status: status,
          headers: { 'Content-Type' => 'application/json' },
        )
    end

    def self.stub_create(uri, attributes)
      WebMock::API.stub_request(:post, "#{REDMINE_API_URL}#{uri}").
        to_return(status: 201, body: attributes.to_json, headers: { 'Content-Type' => 'application/json' })
    end

    def self.stub_create_fail(uri, response_body, status)
      WebMock::API.stub_request(:post, "#{REDMINE_API_URL}#{uri}").
        to_return(
          body: response_body.to_json,
          status: status,
          headers: { 'Content-Type' => 'application/json' },
        )
    end

    def self.stub_destroy(uri)
      WebMock::API.stub_request(:delete, "#{REDMINE_API_URL}#{uri}").to_return(status: 204)
    end

    # module Domain
    #   def self.stub_find(attributes, embed = {})
    #     response_attributes = attributes.merge embed
    #     id = attributes[:id]
    #     WebMockTemplates.stub_find("/domains/#{id}", response_attributes).
    #       with(query: { embed: embed.keys })
    #   end

    #   def self.stub_all(body = [])
    #     WebMockTemplates.stub_all '/domains', body
    #   end

    #   def self.stub_for_customer(customer_id, domains, params)
    #     WebMockTemplates.stub_all(
    #       "/customers/#{customer_id}/domains?#{params.to_param}",
    #       domains
    #     )
    #   end

    #   def self.stub_save(attributes)
    #     id = attributes[:id]
    #     WebMockTemplates.stub_save "/domains/#{id}", attributes
    #   end

    #   def self.stub_destroy(id)
    #     WebMockTemplates.stub_destroy "/domains/#{id}"
    #   end

    #   def self.stub_create(attributes)
    #     WebMockTemplates.stub_create '/domains', attributes
    #   end

    #   def self.stub_create_fail(response_body, status)
    #     WebMockTemplates.stub_create_fail '/domains', response_body, status
    #   end

    #   def self.stub_create_default_name_servers(id)
    #     WebMockTemplates.stub_create "/domains/#{id}/create_default_name_servers", {}
    #   end
    # end

    # module Record
    #   def self.stub_find(attributes, embed = {})
    #     response_attributes = attributes.merge embed
    #     id = attributes[:id]
    #     WebMockTemplates.stub_find("/records/#{id}", response_attributes).
    #       with(query: { embed: embed.keys })
    #   end

    #   def self.stub_all(body = [])
    #     WebMockTemplates.stub_all '/records', body
    #   end

    #   def self.stub_for_domain(domains_id, records)
    #     WebMockTemplates.stub_all(
    #       "/domains/#{domains_id}/records",
    #       records
    #     )
    #   end

    #   def self.stub_save(attributes)
    #     id = attributes[:id]
    #     WebMockTemplates.stub_save "/records/#{id}", attributes
    #   end

    #   def self.stub_save_fail(response_body, status)
    #     id = attributes[:id]
    #     WebMockTemplates.stub_save_fail "/records/#{id}", response_body, status
    #   end

    #   def self.stub_destroy(id)
    #     WebMockTemplates.stub_destroy "/records/#{id}"
    #   end

    #   def self.stub_create(attributes)
    #     WebMockTemplates.stub_create '/records', attributes
    #   end

    #   def self.stub_create_fail(response_body, status)
    #     WebMockTemplates.stub_create_fail '/records', response_body, status
    #   end
    # end

    # module Tag
    #   def self.stub_for_customer(customer_id, tags)
    #     WebMockTemplates.stub_all(
    #       "/tags?customer_id=#{customer_id}",
    #       tags
    #     )
    #   end

    #   def self.stub_for_domain(domain_id, tags)
    #     WebMockTemplates.stub_all(
    #       "/tags?domain_id=#{domain_id}",
    #       tags
    #     )
    #   end

    #   def self.stub_for_domain_and_name(domain_id, name, tags)
    #     WebMockTemplates.stub_all(
    #       "/tags?domain_id=#{domain_id}&name=#{name}",
    #       tags
    #     )
    #   end

    #   def self.stub_destroy(id, attributes)
    #     WebMockTemplates.stub_destroy "/domains/#{attributes[:domain_id]}/tags/#{id}"
    #   end

    #   def self.stub_create(attributes)
    #     WebMockTemplates.stub_create "/domains/#{attributes[:domain_id]}/tags", attributes
    #   end
    # end
  end
end
