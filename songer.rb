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
  session[:songs][params[:artist]] = {params[:title] => params[:video]}
  erb :index, layout: :default_layout
end
