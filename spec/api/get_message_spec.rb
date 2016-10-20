require 'helper_spec'

describe 'GET Message' do
  before { Messages.before { env['api.tilt.root'] = 'app/views' } }

  def app
    Messages
  end

  before do
    post '/messages', 'body': 'dZMMO/6dRDNFvtwSj3t4apgP8dxpnXw==', visits_limit: 4, exist_hours: 1.5
    get "/messages/1:dZMMO6dRDNFvtwSj"
  end

  describe 'status' do
    it 'has a correct status' do
      expect(last_response.status).to  eq(200)
    end
  end

  describe 'body' do
    it 'has a correct link' do
      expect(last_response.body).to  include("1:dZMMO6dRDNFvtwSj".to_json)
    end

    it 'has a correct content' do
      expect(last_response.body).to  include("dZMMO/6dRDNFvtwSj3t4apgP8dxpnXw==".to_json)
    end

    it 'has correct views count' do
      expect(last_response.body).to  include(1.to_json)
    end

    it 'has visits limit count' do
      expect(last_response.body).to  include(4.to_json)
    end

    it 'has exist hours limitation' do
      expect(last_response.body).to  include(1.5.to_json)
    end
  end

  describe 'functional' do
    it 'increments the views count' do
      get "/messages/1:dZMMO6dRDNFvtwSj"

      expect(last_response.body).to  include(2.to_json)
    end
  end
end