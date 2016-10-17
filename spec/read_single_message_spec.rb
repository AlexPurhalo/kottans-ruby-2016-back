require 'helper_spec'

describe Messages do
  before { Messages.before { env['api.tilt.root'] = 'app/views' } }

  def app
    Messages
  end

  describe 'reads info about a message' do
    if Message.count === 0
      index = 1                                                        # if records count equal zero crates first index
    else
      last_link = Message.order("created_at").last.link       # looks for lastly created record in DB   # 21:AbGlAmaGAM
      index = last_link.slice(0..(last_link.index(':'))).to_i + 1    # takes index of record and adds increases it # 22
      index = index.to_s
    end



    before do
      post '/messages', 'body': 'U2FsdGVk/X19oQX5dwuZIiIhozgPMnnwNDodnrnPQ4kE='       # posts data with body parameter
      get "/messages/#{index}:U2FsdGVkX19oQX5d"                                            # fetches data bout message

    end

    it 'includes a correct link' do
      expect(last_response.body).to include("#{index.to_s}:U2FsdGVkX19oQX5d".to_json)
    end

    it 'includes a correct body' do
      expect(last_response.body).to include("U2FsdGVk/X19oQX5dwuZIiIhozgPMnnwNDodnrnPQ4kE=".to_json)
    end

    it 'has a correct status' do
      expect(last_response.status).to  eq(200)
    end
  end
end

