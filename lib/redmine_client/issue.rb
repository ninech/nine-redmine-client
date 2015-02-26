require 'rest_in_peace'
require 'redmine_client/paginator'

module RedmineClient
  class Issue
    include RESTinPeace

    rest_in_peace do
      use_api ->() { RedmineClient::API.api }
      namespace_attributes_with :issue

      attributes do
        read :id, :project, :tracker, :status, :priority, :author
        write :subject, :description, :start_date, :done_ratio, :spent_hours,
              :project_id, :status_id, :priority_id, :author_id
      end

      resource do
        patch :save, '/issues/:id'
        post :create, '/issues'
        delete :destroy, '/issues/:id'
        get :reload, '/issues/:id'
      end

      collection do
        get :all, '/issues', paginate_with: RedmineClient::Paginator
        get :find, '/issues/:id.xml'
      end

      acts_as_active_model
    end
  end
end
