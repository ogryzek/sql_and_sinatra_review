require 'sinatra'

enable :sessions

get '/' do
  erb :index, layout: :default_layout
end

get '/new' do

  erb :add_song, layout: :default_layout
end

post '/' do
  session[:songs] = {} unless session[:songs]
  artist = params[:artist]
  title = params[:title]
  video = params[:video]
  session[:songs][artist] = {} unless artist
  session[:songs][artist] = {title => video}
  erb :index, layout: :default_layout
end
