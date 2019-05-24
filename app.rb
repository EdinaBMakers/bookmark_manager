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

  get '/bookmarks/:id/edit' do
    @bookmark = Bookmark.find(id: params[:id])
    erb(:'bookmarks/edit')
  end

  patch '/bookmarks/:id' do
    updated_bookmark = Bookmark.new(\
      id: params[:id], \
      url: params[:url], \
      title: params[:title]\
    )

    Bookmark.update(updated_bookmark: updated_bookmark)

    redirect('/bookmarks')
  end

  run! if app_file == $0
end
