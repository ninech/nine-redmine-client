require 'spec_helper'

RSpec.describe RedmineClient::Base do
  describe '.resource_path' do
    subject { RedmineClient::Base.resource_path }
    it { should eq '/bases' }
  end

  describe '.resource_name' do
    subject { RedmineClient::Base.resource_name }
    it { should eq 'base' }
  end

  describe '.bad_response' do
    it 'raises a response error when given a correct response' do
      expect do
        response = instance_double('HTTParty::Response', class: HTTParty::Response)
        RedmineClient::Base.bad_response(response)
      end.to raise_error HTTParty::ResponseError
    end

    it 'raises an standard error in all other cases' do
      expect do
        RedmineClient::Base.bad_response(double)
      end.to raise_error StandardError
    end
  end

  describe '.find' do
    subject { RedmineClient::Base.find(1) }

    it 'starts a get request with the correct path' do
      allow(RedmineClient::Base).to receive(:new)
      expect(RedmineClient::Base).to receive(:get).with('/bases/1.json').and_return double(ok?: true, :[] => '')
      RedmineClient::Base.find(1)
    end

    it 'creates a new instance when the response is ok' do
      response = double(ok?: true, :[] => {})
      allow(RedmineClient::Base).to receive(:get).and_return(response)
      expect(RedmineClient::Base).to receive(:new).with({})
      RedmineClient::Base.find(1)
    end

    it 'fails when the response smells' do
      response = double(ok?: false)
      allow(RedmineClient::Base).to receive(:get).and_return(response)
      expect(RedmineClient::Base).to receive(:bad_response).with(response, 1)
      RedmineClient::Base.find(1)
    end
  end
end
