# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  get "/" do
    return erb(:index)
  end


  # ------------------------
  # ALBUMS METHOD
  # ------------------------

  post "/albums" do
    @album = Album.new
    album_repo = AlbumRepository.new
    @album.title = params[:title]
    @album.release_year = params[:release_year]
    @album.artist_id = params[:artist_id]
    album_repo.create(@album)
    return erb(:"albums/added")
  end
  
  get "/albums/new" do
    return erb(:"albums/new_album")
  end

  get "/albums" do
    album_repo = AlbumRepository.new
    @albums = album_repo.all
    return erb(:"albums/all")
  end

  get "/albums/:id" do
    album_repo = AlbumRepository.new
    artist_repo = ArtistRepository.new
    @album = album_repo.find(params[:id])
    @artist = artist_repo.find(@album.artist_id)

    return erb(:"albums/album")
  end

  # ------------------------
  # ARTISTS METHOD
  # ------------------------

  get "/artists/new" do
    return erb :"artists/new"
  end

  post "/artists" do
    key = [:name, :genre]
    key.each { |k| return status 400 if params[k] == nil }
    p key
    artist_repo = ArtistRepository.new
    @artist = Artist.new
    @artist.name = params[:name]
    @artist.genre = params[:genre]
    artist_repo.create(@artist)
    return erb(:"artists/added")
  end

  get "/artists" do
    repo = ArtistRepository.new
    @artists = repo.all
    return erb(:"artists/all")
  end

  get "/artists/:id" do
    artist_repo = ArtistRepository.new
    @artist = artist_repo.find(params[:id])
    
    return erb(:"artists/artist")
  end
end



