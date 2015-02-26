
module RedmineClient
  class Issue
    def create(attributes = {})
      Client.put "/issues.json", body: { issue: attributes }
    end
  end
end
