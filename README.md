# Redmine Ruby Client

Ruby client library for the Redmine API.

## Usage

The client is very limited. Actually it can only find, create and update issues. That's all for now. But
great things start small.

```ruby
RedmineClient::Issue.create subject: 'Do this and that', project_id: 1

issue = RedmineClient::Issue.find(1)
issue.update subject: 'New Subject'
```
