class Messages < Grape::API

  version 'v1', using: :header, vendor: 'alexpurhalo'
  format :json
  formatter :json, Grape::Formatter::Rabl

  resource :messages do
    # sets parameters from request's payload    # { body: 'LrMnKFsWdfF...', visits_limit: 3, exist_hours: 0.5 }
    params do
      requires :body,         type: String,  desc:                                          'Encrypted message'
      optional :visits_limit, type: Integer, desc:                                       'Allowed visits count'
      optional :exist_hours,  type: Integer, desc:                          'Time of message existing in hours'
    end

    desc 'Creates a message'                            # message create process with POST request, ../messages
    post '/', rabl: 'messages/message' do
      @message = Message.new params                              # takes and holds received parameters # step 1

      # sets index for created record to make it unique                                                # step 3
      if Message.count === 0
        link_index = 1                                                        # indicates first record in db: 1
      else
        last_link = Message.order("created_at").last.link   # holds link of lastly created record: '6:JIniKUoPw'
        link_index = last_link.slice(0..(last_link.index(':'))).to_i + 1  # slices to index: '6:JIniKUoPw' => 7
      end

      # adds index to new link                                                                         # step 4
      @message.link = link_index.to_s + ':' + @message.body[0..8]      # '7' + ':' + 'LrMnKFsW' => '7:LrMnKFsW'

      @message.save ? @message : { error: 'incorrect data' }
    end
  end

  add_swagger_documentation info: { title: 'Messages API' },
                            hide_documentation_path: true,
                            mount_path: '/swagger_doc',
                            markdown: false,
                            api_version: 'v1'

end