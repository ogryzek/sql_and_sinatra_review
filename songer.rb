require 'sinatra'

enable :sessions

get '/' do
  erb :index, layout: :default_layout
end

get '/new' do
  erb :add_song, layout: :default_layout
end

post '/' do
  artist = params[:artist]
  session[:songs] = {} unless session[:songs]
  session[:songs][artist] = [] unless session[:songs][artist]

  session[:songs][artist].push(
    {
      title: params[:title],
      video: params[:video]
    }
  )

  erb :index, layout: :default_layout
end
