require 'spec_helper'

RSpec.describe RedmineClient::Issue do
  describe '.search' do
    subject { RedmineClient::Issue.search(subject: 'nice subject', status_id: '*') }

    it 'starts a get request with the correct path' do
      allow(RedmineClient::Issue).to receive(:new)
      expect(RedmineClient::Issue).
        to receive(:get).with('/issues.json', query: { subject: 'nice subject', status_id: '*'}).
        and_return double(ok?: true, :[] => [])
      subject
    end
  end
end
