# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
u1 = User.create!(email: "alphadog@example.com",
              password: "alphadog")

u2 = User.create!(email: "betaband@example.com",
              password: "betaband")

u3 = User.create!(email: "charliehustle@example.com",
              password: "charliehustle")

b1 = Band.create!(name: "Radiohead")

b2 = Band.create!(name: "Grateful Dead")

a1 = Album.create!(name: "OK Computer",
                  setting: "studio",
                  band_id: b1.id)

a2 = Album.create!(name: "In Rainbows",
                  setting: "studio",
                  band_id: b1.id)

a3 = Album.create!(name: "Europe \'72",
                  setting: "live",
                  band_id: b2.id)

t1 = Track.create!(name: "Karma Police",
                  status: "regular",
                  lyrics: "Karma Police, arrest this girl",
                  album_id: a1.id)

t2 = Track.create!(name: "Nude(remix)",
                  status: "bonus",
                  lyrics: "It's not going to happen.",
                  album_id: a2.id)

t2 = Track.create!(name: "Brown-Eyed Woman",
                  status: "regular",
                  lyrics: "Gone are the days",
                  album_id: a3.id)
