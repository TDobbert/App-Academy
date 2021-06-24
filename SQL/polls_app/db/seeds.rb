# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.transaction do
  User.destroy_all
  Poll.destroy_all
  Question.destroy_all
  AnswerChoice.destroy_all
  Response.destroy_all

  u1 = User.create!(username: 'Mr. Smee')
  u2 = User.create!(username: 'Laila')

  p1 = Poll.create!(title: 'Cats Poll', author: u1)

  q1 = Question.create!(text: 'Which Cat Is The Baddest?', poll: p1)
  ac1 = AnswerChoice.create!(text: 'Mr. Smee', question: q1)
  ac2 = AnswerChoice.create!(text: 'Laila', question: q1)
  ac3 = AnswerChoice.create!(text: 'Nick Pappagiorgio', question: q1)

  q2 = Question.create!(text: 'Which Toy Is Most Fun?', poll: p1)
  ac4 = AnswerChoice.create!(text: 'String', question: q2)
  ac5 = AnswerChoice.create!(text: 'Ball', question: q2)
  ac6 = AnswerChoice.create!(text: 'Bird', question: q2)

  r1 = Response.create!(
    respondent: u2,
    answer_choice: ac3
  )
  r2 = Response.create!(
    respondent: u2,
    answer_choice: ac4
  )
end
