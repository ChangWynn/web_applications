# {{ METHOD }} {{ PATH}} Route Design Recipe

<!-- # Request:
POST /albums

# With body parameters:
title=Voyage
release_year=2022
artist_id=2

# Expected response (200 OK)
(No content) -->

## 1. Design the Route Signature

You'll need to include:
  * the HTTP method
  * the path
  * any query parameters (passed in the URL)
  * or body parameters (passed in the request body)

<!-- request = POST /albums

body parameters: 
# With body parameters:
title=Voyage
release_year=2022
artist_id=2 -->
## 2. Design the Response

The route might return different responses, depending on the result.

For example, a route for a specific blog post (by its ID) might return `200 OK` if the post exists, but `404 Not Found` if the post is not found in the database.

Your response might return plain text, JSON, or HTML code. 

_Replace the below with your own design. Think of all the different possible responses your route will return._

```html
<!-- EXAMPLE -->
<!-- Response when the post is found: 200 OK -->
doest show anything
```

```html
<!-- EXAMPLE -->
<!-- Response when the post is not found: 404 Not Found -->
```

## 3. Write Examples

<!-- # Request:
POST /albums

# With body parameters:
title=Voyage
release_year=2022
artist_id=2

# Expected response (200 OK)
(No content) -->

```
# Request:
POST /albums
# Expected response:
Response for 200 OK
```

```
# Request:
POST /album
# Expected response:
Response for 404 Not Found
```

## 4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/application_spec.rb
require "spec_helper"
describe Application do
  include Rack::Test::Methods
  let(:app) { Application.new }
  context "GET /" do
    it 'returns 200 OK' do
      # Assuming the post with id 1 exists.
      response = get('/posts?id=1')
      expect(response.status).to eq(200)
      # expect(response.body).to eq(expected_response)
    end
    it 'returns 404 Not Found' do
      response = get('/posts?id=276278')
      expect(response.status).to eq(404)
      # expect(response.body).to eq(expected_response)
    end
  end
end
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

For this challenge, you should only record the 3rd part where you create the diagram. Make sure you also record yourself talking out loud when making the diagram, to explain it.

Test-drive and implement the following changes to the music_library_database_app project.

Test-drive a route GET /artists/:id which returns an HTML page showing details for a single artist.

Test-drive a route GET /artists which returns an HTML page with the list of artists. This page should contain a link for each artist listed, linking to /artists/:id where :id needs to be the corresponding artist id.
Create a sequence diagram explaining the behaviour of your program when a request is sent to GET /artists/:id. Make sure your diagram all includes the following:
The HTTP Client
The HTTP Request and the data it contains
The HTTP Response and the data it contains
The Application class (app.rb)
The Repository class (artist_repository.rb)
The View (ERB file)
The Database