# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u1 = User.create!(user_name: "paul")
u2 = User.create!(user_name: "eli")

p1 = Poll.create!(author_id: u1.id, title: "What day is it?")
p2 = Poll.create!(author_id: u2.id, title: "What year is it?")

q1 = Question.create!(poll_id: 1, question_text: "Is it Thursday?")
q2 = Question.create!(poll_id: 1, question_text: "What day is it?")
q3 = Question.create!(poll_id: 2, question_text: "Is it 2014?")
q4 = Question.create!(poll_id: 2, question_text: "Is it 2016?")

ac1 = AnswerChoice.create!(question_id: q1.id, answer_text: "yes")
ac2 = AnswerChoice.create!(question_id: q1.id, answer_text: "no")
ac3 = AnswerChoice.create!(question_id: q2.id, answer_text: "Monday")
ac4 = AnswerChoice.create!(question_id: q2.id, answer_text: "Friday")
ac5 = AnswerChoice.create!(question_id: q3.id, answer_text: "yes")
ac6 = AnswerChoice.create!(question_id: q3.id, answer_text: "no")
ac7 = AnswerChoice.create!(question_id: q4.id, answer_text: "yes")
ac8 = AnswerChoice.create!(question_id: q4.id, answer_text: "no")
ac9 = AnswerChoice.create!(question_id: q3.id, answer_text: "maybe")
