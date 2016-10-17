class Messages < Grape::API

  version 'v1', using: :header, vendor: 'alexpurhalo'
  format :json
  formatter :json, Grape::Formatter::Rabl

  resource :messages do
    # sets parameters from request's payload    # { body: 'LrMnKFsWdfF...', visits_limit: 3, exist_hours: 0.5 }
    params do
      requires :body,         type: String,  desc:                                          'Encrypted message'
      optional :visits_limit, type: Integer, desc:                                       'Allowed visits count'
      optional :exist_hours,  type: Float, desc:                            'Time of message existing in hours'
    end

    desc 'Creates a message'                            # message create process with POST request, ../messages
    post '/', rabl: 'messages/created_message' do
      @message = Message.new params                              # takes and holds received parameters # step 1

      @message.views_count = 0                                          # sets initial count of visits # step 2

      # sets index for created record to make it unique                                                # step 3
      if Message.count === 0
        link_index = 1                                                        # indicates first record in db: 1
      else
        last_link = Message.order("created_at").last.link   # holds link of lastly created record: '6:JIniKUoPw'
        link_index = last_link.slice(0..(last_link.index(':'))).to_i + 1  # slices to index: '6:JIniKUoPw' => 7
      end

      # stocks sliced message and empty string then cuts '/' symbol and push validated data           # step 4.1
      sliced_body, validated_link_body = @message.body[0..16], '' #         to empty string           # step 4.2
      sliced_body.each_char { |char| validated_link_body << char if char != '/' }

      # adds index to sliced and validated string                                                     # step 4.3
      @message.link = link_index.to_s + ':' + validated_link_body       # '7' + ':' + 'LrMnKFsW' => '7:LrMnKFsW'

      if @message.save                                            # if data is correct saves message # step 5.0
        if params[:exist_hours] # if we exist_hours param exists, allows do operations with this param
          exist_secs = ((params[:exist_hours]) * 60 * 60).to_i       # transforms hours to seconds  # step 5.11

          @message.deleted_at = Time.now + exist_secs # stores time of post destroying to db        # step 5.12

          # calls background process to destroy after passed hours count
          AutoDestory.perform_async(exist_secs, @message.link)                                      # step 5.13
        end

        @message  # shows serialized data about post                                             # alt step 5.1
      else
        { error: 'incorrect data' } # if something go wrong renders message about wrong data     # alt step 5.1
      end
    end

    desc 'Reads a message'           # message reading wia GET request to unique link, .../messages/ 7:LrMnKFsW
    get '/:id', rabl: 'messages/message_to_read' do
      @message = Message.find params[:id]              # looks for object with unique link that is id, # step 1
      #       { link: '7:LrMnKFsW', body: 'LrMnKFsWdfF...', visits_limit: 3, exist_hours: 0.5, views_count: 0 }

      @message.views_count += 1 # increments by one views count after every visit to page            # step 2.1
      @message.save             # updates info about incremented by one view                         # step 2.2

      # checks that views count not reached limit    # step 3
      if @message.visits_limit && @message.views_count >= @message.visits_limit
        @message                       # if limit was reached it renders data about message lastly  # step 3.11
        @message.destroy                # after then data was rendered it destroys message from db  # step 3.12
      else
        @message                                             # returns message if limit not reached  # step 3.2
      end
    end
  end

  add_swagger_documentation info: { title: 'Messages API' },
                            hide_documentation_path: true,
                            mount_path: '/swagger_doc',
                            markdown: false,
                            api_version: 'v1'

  # links to tasks sources, as additional
  get '/' do
    {
        front_end_heroku: 'https://self-destruction-kottans-2016.herokuapp.com/',
        back_end_heroku: 'https://kottands-ruby-2016-back.herokuapp.com',
        github_back: 'https://github.com/AlexPurhalo/kottans-ruby-2016-back',
        github_front: 'https://github.com/AlexPurhalo/kottans-ruby-2016-assignment-front-end'
    }
  end

end