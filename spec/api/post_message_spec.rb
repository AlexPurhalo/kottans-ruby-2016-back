require 'helper_spec'

describe 'POST Message' do
  before { Messages.before { env['api.tilt.root'] = 'app/views' } }

  def app
    Messages
  end

  describe 'correct data posting' do
    before do
      post '/messages', 'body': 'U2FsdGVk/X19oQX5dwuZIiIhozgPMnnwNDodnrnPQ4kE='
    end
    it 'has a correct status' do
      expect(last_response.status).to  eq(201)
    end

    it 'has a link of firstly created record' do
      expect(last_response.body).to include("1:U2FsdGVkX19oQX5d".to_json)
    end

    it 'has a link of any record created after first' do
      post '/messages', 'body': 'dZMMO/6dRDNFvtwSj3t4apgP8dxpnXw=='

      expect(last_response.body).to include("2:dZMMO6dRDNFvtwSj".to_json)
    end
  end

  describe 'empty post attempt' do
    it 'shows messages about empty data' do
      post '/messages'

      expect(last_response.body).to include("body is missing".to_json)
    end
  end

  describe 'message posting with destroy parameters' do
    it 'has a visits limitation count' do
      post '/messages', 'body': 'dZMMO/6dRDNFvtwSj3t4apgP8dxpnXw==', visits_limit: 4

      expect(last_response.body).to include(4.to_json)
    end

    it 'has the exist hours limitation' do
      post '/messages', 'body': 'dZMMO/6dRDNFvtwSj3t4apgP8dxpnXw==', exist_hours: 1.5

      expect(last_response.body).to include(1.5.to_json)
    end
  end
end