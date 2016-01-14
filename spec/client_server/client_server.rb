require 'sinatra'
set :public_folder, settings.root + '/assets'
set :views,         settings.root + '/templates'
get '/' do
  erb :index
end
