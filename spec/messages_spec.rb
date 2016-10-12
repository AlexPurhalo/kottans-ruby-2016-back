require 'rspec'
require 'rack/test'
require './app/core'

describe Messages do
  include Rack::Test::Methods

  def app
    Messages
  end

  describe 'root page tests' do
    before do
      get '/messages'
    end

    it 'returns a correct status' do
      expect(last_response.status).to eq(200)
    end

    it 'renders json data' do
      expect(last_response.body).to eq({ message: 'hello it works' }.to_json)
    end
  end
end