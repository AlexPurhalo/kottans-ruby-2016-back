class Messages < Grape::API

  version 'v1', using: :header, vendor: 'alexpurhalo'
  format :json

  resource :messages do
    get '/' do
      { message: 'hello it works'}
    end
  end
end