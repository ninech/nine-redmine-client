module RedmineClient
  class Issue < Base
    def self.search(arguments)
      issues = get "#{resource_path}.json", query: arguments
      if issues.ok?
        puts issues['issues']
        issues['issues'].map { |issue| new(issue) }
      else
        bad_response(issues, arguments)
      end
    end
  end
end
