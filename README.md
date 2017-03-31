# Redmine Ruby Client

[![Build Status](https://travis-ci.org/ninech/nine-redmine-client.svg?branch=master)](https://travis-ci.org/ninech/nine-redmine-client)

Ruby client library for the Redmine API.

## Configuration

In your Rails app create a file `config/initializers/redmine.rb` with the following content:

```ruby
RedmineClient::API.configure do |config|
  config.url = ENV['REDMINE_URL']
  config.token = ENV['REDMINE_TOKEN']
end
```

Here you have to set the config values via environment variables. But you're free to do it differently.

## Usage

The client is very limited. Actually it can only find, create and update issues. That's all for now. But
great things start small.

```ruby
RedmineClient::Issue.create subject: 'Do this and that', project_id: 1

issue = RedmineClient::Issue.find(1)
issue.update subject: 'New Subject'
```
