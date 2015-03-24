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
#####

def create_contact
  url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/contacts.json'
  ).to_s

  puts RestClient.post(
  url,
  { contact: { name: "Gizmall", email: "aa", user_id: 2 } }
  )
end

def show_contacts
  url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/contacts/'
  ).to_s

  puts RestClient.get(url)
end

def update_contact
  url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/contacts/1'
  ).to_s

  puts RestClient.put(
  url,
  { contact: { name: "Frank" } }
  )
end

def delete_contact
  url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/contacts/1'
  ).to_s

  puts RestClient.delete(url)
end

def all_my_contacts
  url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/users/2/contacts'
  ).to_s

  puts RestClient.get(url)
end

#create_contact
#show_contacts
#update_contact
#delete_contact
all_my_contacts
