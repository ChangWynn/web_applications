require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "GET /albums" do
    it "should return one album" do
      response = get("/albums/2")
      expect(response.status).to eq 200
      expect(response.body).to eq "Surfer Rosa"
    end
  end
  
  context "GET /albums" do
    it 'returns all albums & 200 OK' do
      response = get('/albums')
      expected_response = 'Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring'
      expect(response.status).to eq(200)
      expect(response.body).to eq(expected_response)
    end
  end

  context "POST /albums" do
    it "shoud add a new album in the repository" do
      response = post('/albums', title: "Voyage", release_year: 2022, artist_id: 2)
      result = get '/albums/13'
      expect(response.status).to eq 200
      expect(result.body).to eq "Voyage"
    end
  end

  # ------------------------
  # CHALLENGE RSPEC SOLUTION
  # ------------------------

  context "GET /artist" do
    it "should return 200 OK with a string containing all artists name" do
      response = get "/artists"

      expect(response.status).to eq 200
      expect(response.body).to eq "Pixies, ABBA, Taylor Swift, Nina Simone"
    end
  end

  context "POST /artist" do
    it "should add a new artist to the table" do
      response = post "/artists", name: "Wild Nothing", genre: "Indie"
      expected_response = get "/artists"

      expect(response.status).to eq 200
      expect(response.body).to eq "Artist successfully added"
      expect(expected_response.body).to eq "Pixies, ABBA, Taylor Swift, Nina Simone, Wild Nothing"
    end
  end
end
