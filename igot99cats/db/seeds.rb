# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

usr1 = User.create!(username: "loverboy20",
                    password: "datassdoe",
                    session_token: "fake1")

usr2 = User.create!(username: "catlady95",
                    password: "allaboutdemcats",
                    session_token: "fake2")

usr3 = User.create!(username: "larry",
                    password: "dabossornaw",
                    session_token: "fake3")

cat1 = Cat.create!(birth_date: "27/May/2004",
                   color: "calico",
                   name: "Larry",
                   sex: "F",
                   description: "A very friendly cat named Larry.",
                   user_id: usr3.id )

cat2 = Cat.create!(birth_date: "8/Jun/1999",
                  color: "hairless",
                  name: "Mr. Bigglesworth",
                  sex: "M",
                  description: "Cold. Ice cold.",
                  user_id: usr2.id)

cat3 = Cat.create!(birth_date: "25/Dec/2014",
                   color: "tuxedo",
                   name: "Manuel",
                   sex: "M",
                   description: "This cat has risen.",
                   user_id: usr1.id)

cat4 = Cat.create!(birth_date: "1/Jan/2015",
                  color: "neon",
                  name: "Draymond",
                  sex: "M",
                  description: "This cat is on fire.",
                  user_id: usr2.id)

crr1 = CatRentalRequest.create!(cat_id: cat1.id,
                                user_id: usr1.id,
                                start_date: "25/Dec/2016",
                                end_date: "25/Dec/2017")

crr2 = CatRentalRequest.create!(cat_id: cat1.id,
                                user_id: usr2.id,
                                start_date: "12/Mar/2016",
                                end_date: "25/Jun/2016")

crr3 = CatRentalRequest.create!(cat_id: cat2.id,
                                user_id: usr3.id,
                                start_date: "12/Mar/2016",
                                end_date: "25/Jun/2016")

crr4 = CatRentalRequest.create!(cat_id: cat3.id,
                                user_id: usr2.id,
                                start_date: "12/Mar/2015",
                                end_date: "25/Jun/2015")

crr5 = CatRentalRequest.create!(cat_id: cat4.id,
                                user_id: usr3.id,
                                start_date: "12/Feb/2015",
                                end_date: "25/Feb/2015")
