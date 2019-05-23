require 'sinatra/base'
require './lib/bookmark.rb'

class BookmarkManager < Sinatra::Base
  enable :method_override
  
  get '/' do
    "Bookmark Manager"
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all

    erb(:'bookmarks/index')
  end

  post '/bookmarks/new' do
    Bookmark.create(url: params[:url], title: params[:title])

    redirect('/bookmarks')
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(id: params[:id])

    redirect('/bookmarks')
  end

  run! if app_file == $0
end
