require 'helper_spec'

describe Messages do
  before { Messages.before { env['api.tilt.root'] = 'app/views' } }

  def app
    Messages
  end

  describe 'messages creating tests' do
    last_link = Message.order("created_at").last.link       # looks for lastly created record in DB   # 21:AbGlAmaGAM
    index = last_link.slice(0..(last_link.index(':'))).to_i + 1    # takes index of record and adds increases it # 22

    it 'includes a correct link' do
      post '/messages', 'body': 'JjsdISDrdSNSsdJJFfP'                                # posts data with body parameter
      # require 'pry'; binding.pry      # for debug
      expect(last_response.body).to include("#{index.to_s}:JjsdISDrd".to_json)
    end
  end
end

