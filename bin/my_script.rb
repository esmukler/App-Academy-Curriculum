require 'addressable/uri'
require 'rest-client'

def create_user
  url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/users.json'
  ).to_s

  puts RestClient.post(
  url,
  { user: { name: "Gizmall", email: "aa" } }
  )
end

def show_user
  url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/users/1'
  ).to_s

  puts RestClient.get(url)
end

def update_user
  url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/users/1'
  ).to_s

  puts RestClient.put(
    url,
  { user: { name: "Frank" } }
  )
end

def delete_user
  url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/users/1'
  ).to_s

  puts RestClient.delete(url)
end

#create_user
# show_user
#update_user
delete_user
