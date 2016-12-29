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
    subject { described_class.bad_response(response) }

    context 'valid response object' do
      let(:response) { instance_double('HTTParty::Response', class: HTTParty::Response, code: 500) }

      it 'raises a response error' do
        expect { subject }.to raise_error RedmineClient::Errors::InternalErrorException
      end
    end

    context 'unknown error' do
      let(:response) { double }

      it 'raises a standard error' do
        expect { subject }.to raise_error StandardError
      end
    end

    context 'resource not found' do
      let(:response) { instance_double('HTTParty::Response', class: HTTParty::Response, code: 404) }

      it 'raises the correct error' do
        expect { subject }.to raise_error RedmineClient::Errors::ResourceNotFoundException
      end
    end

    context 'Unprocessable entity error' do
      let(:response) { instance_double('HTTParty::Response', class: HTTParty::Response, code: 422) }

      before do
        allow(response).to receive(:parsed_response).
          and_return('errors' => ['a is bad', 'b is bad'])
      end

      it 'raises the correct error' do
        expect { subject }.to raise_error RedmineClient::Errors::UnprocessableEntityException
      end

      it 'displays a human-readable error message' do
        expect { subject }.to raise_error(
          RedmineClient::Errors::UnprocessableEntityException,
          'a is bad, b is bad'
        )
      end
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
