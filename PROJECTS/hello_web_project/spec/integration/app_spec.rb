require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "POST to /sort-names" do
    it "returns 200 OK with the right content" do
      response = post "/sort-names", names: "Joe,Alice,Zoe,Julia,Kieran"
      expect(response.status).to eq 200
      expect(response.body).to eq "Alice,Joe,Julia,Kieran,Zoe"
    end
  end

  context "POST to /sort-names" do
    it "returns 200 OK with the wrong content" do
      response = post "/sort-names", names: "Joe,Alice,Zoe,Julia"
      expect(response.status).to eq 200
      expect(response.body).not_to eq "Alice,Joe,Julia,Kieran,Zoe"
      expect(response.body).to eq "Alice,Joe,Julia,Zoe"
    end
  end

  context "POST to /sort-names" do
    it "returns 404 PAGE NOT FOUND" do
      response = post "/sort-name", names: "Joe,Alice,Zoe,Julia,Kieran"
      expect(response.status).to eq 404
    end
  end

  context "GET to /hello" do
    it "should return hello" do
      response = get "/hello", name: "Chang"
      expect(response.status).to eq 200
      expect(response.body).to include "<h1>Hello Chang!</h1>"
    end
  end
end