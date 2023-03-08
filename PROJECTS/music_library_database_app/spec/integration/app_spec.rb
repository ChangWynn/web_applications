require "spec_helper"
require "rack/test"
require_relative '../../app'

def reset_albums_table
  seed_sql = File.read('spec/seeds/albums_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end
def reset_artists_table
  seed_sql = File.read('spec/seeds/artists_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  before(:each) do 
    reset_albums_table
    reset_artists_table
  end

  # ------------------------
  # TEST ALBUMS METHOD
  # ------------------------

  context "GET to /albums" do
    it "should print all albums in ERB" do
      response = get "/albums"
      expect(response.status).to eq 200
      expect(response.body).to include "Doolittle"
      expect(response.body).to include "Released: 1989"
      expect(response.body).to include "Bossanova"
      expect(response.body).to include "Released: 1990"
      expect(response.body).to include "Here Comes the Sun"
      expect(response.body).to include "Released: 1971"
    end

    it "should contain a link to each album page" do
      response = get "/albums"
      expect(response.status).to eq 200
      expect(response.body).to include 'Title: <a href="/albums/1">Doolittle</a>'
      expect(response.body).to include 'Title: <a href="/albums/5">Bossanova</a>'
      expect(response.body).to include 'Title: <a href="/albums/10">Here Comes the Sun</a>'
    end
  end

  context "GET /albums/1" do
    it "should return an album details in erb" do
      response = get "/albums/1"
      expect(response.status).to eq 200
      expect(response.body).to include "<h1>Doolittle</h1>"
      expect(response.body).to include "Release year: 1989"
      expect(response.body).to include 'Artist: Pixies' 
    end
  end

  context "GET /albums/2" do
    it "should return an album details in erb" do
      response = get "/albums/2"
      expect(response.status).to eq 200
      expect(response.body).to include "<h1>Surfer Rosa</h1>"
      expect(response.body).to include "Release year: 1988"
      expect(response.body).to include 'Artist: Pixies' 
    end 
  end

  # context "POST /albums" do
  #   it "shoud add a new album in the repository" do
  #     response = post '/albums', title: "Voyage", release_year: 2022, artist_id: 2
  #     expect(response.status).to eq 200
  #   end
  # end

  # ------------------------
  # TEST ARTISTS METHOD
  # ------------------------

  context "GET /artists" do
    it "should return 200 OK with a string containing all artists name" do
      response = get "/artists"

      expect(response.status).to eq 200
      expect(response.body).to include '<a href="/artists/1">Pixies</a>'
      expect(response.body).to include '<a href="/artists/2">ABBA</a>'
      expect(response.body).to include '<a href="/artists/3">Taylor Swift</a>'
    end
  end

  context "GET /artists/:id" do
    it "should return one artist and its details" do
      response = get "/artists/1"
      expect(response.status).to eq 200
      expect(response.body).to include "<h1>Pixies</h1>"
      expect(response.body).to include "<p>Genre: Rock</p>"
    end
    it "should return one artist and its details" do
      response = get "/artists/2"
      expect(response.status).to eq 200
      expect(response.body).to include "<h1>ABBA</h1>"
      expect(response.body).to include "<p>Genre: Pop</p>"
    end
  end

  # context "POST /artist" do
  #   it "should add a new artist to the table" do
  #     response = post "/artists", name: "Wild Nothing", genre: "Indie"
  #     expected_response = get "/artists"

  #     expect(response.status).to eq 200
  #     expect(response.body).to eq "Artist successfully added"
  #     expect(expected_response.body).to eq "Pixies, ABBA, Taylor Swift, Nina Simone, Wild Nothing"
  #   end
  # end
end
