require 'sinatra'

enable :sessions

get '/' do
  erb :index, layout: :default_layout
end

get '/new' do

  erb :add_song, layout: :default_layout
end

post '/new' do
  "artist: #{params[:artist]}, title: #{params[:title]}, video: #{params[:video]}"
end
