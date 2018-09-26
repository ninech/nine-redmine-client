module RedmineClient
  class Upload < Base
    def self.attach
    end

    def self.create(file_content)
      headers['Content-Type'] = 'application/octet-stream'
      resource = post "#{resource_path}.json", body:  file_content
      if resource.success?
        resource["upload"]
      else
        bad_response(resource)
      end
    end
  end
end