class Messages < Grape::API

  version 'v1', using: :header, vendor: 'alexpurhalo'
  format :json

  resource :messages do
    get '/' do
      { message: 'hello it works' }
    end


    post '/' do

    end
  end

  add_swagger_documentation info: { title: 'Messages API' },
                            hide_documentation_path: true,
                            mount_path: '/swagger_doc',
                            markdown: false,
                            api_version: 'v1'

  before do
    header['Access-Control-Allow-Origin'] = '*'
    header['Access-Control-Request-Method'] = '*'
  end
end