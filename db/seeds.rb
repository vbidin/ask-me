# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# add roles
admin = Role.admin
mod = Role.moderator
guest = Role.guest

admin.save!
mod.save!
guest.save!

# add question types
text_choice = Type.choice
text_multiple_choice = Type.multiple_choice
#text_no_choice = Type.no_choice

text_choice.save!
text_multiple_choice.save!
#text_no_choice.save!

# add users
vedran = User.new(
  username: "vedran",
  email: "vedran.bidin@gmail.com",
  password: "password"
)
vedran.skip_confirmation!
vedran.save!

pero = User.new(
  username: "pero",
  email: "pero@hotmail.com",
  password: "password"
)
pero.skip_confirmation!
pero.save!

ivan = User.new(
  username: "ivan",
  email: "ivan@bidin.eu",
  password: "password"
)
ivan.skip_confirmation!
ivan.save!

# add rooms
Room.create(name: "Room #2", open: false)
Room.create(name: "Room #17", open: false)
Room.create(name: "Room #692", open: false)

room = Room.create(name: "Closed room", open: false)
Permission.create(user: vedran, room: room, role: admin)

Room.create(name: "Room #22", open: false)
test_room = Room.create(name: "Test room", open: true)
Room.create(name: "Room #692741", open: false)
Room.create(name: "Room Room", open: false)

room = Room.create(name: "Room #1", open: true)
Permission.create(user: vedran, room: room, role: admin)
Permission.create(user: pero, room: room, role: mod)

Room.create(name: "Room", open: false)
Room.create(name: "Room of horrors", open: false)
Room.create(name: "Room #215415", open: false)
Room.create(name: "Room #5692", open: false)
Room.create(name: "Room #125", open: false)
Room.create(name: "Roomy", open: true)
Room.create(name: "Room #111", open: false)
Room.create(name: "Room #901", open: false)
Room.create(name: "Room #274693", open: false)
Room.create(name: "Room #3", open: false)
Room.create(name: "Room #2451", open: false)

# add sample questions
q1 = Question.create(
  user: pero, 
  room: test_room, 
  type: text_choice, 
  title: "Question #1", 
  text: "This is a sample choice question.",
  visible: true,
  locked: false
)

Answer.create(question: q1, data: "Answer 1", correct: false)
Answer.create(question: q1, data: "Answer 2", correct: false)
Answer.create(question: q1, data: "Answer 3", correct: false)
Answer.create(question: q1, data: "Answer 4", correct: true)

q2 = Question.create(
  user: ivan, 
  room: test_room, 
  type: text_choice,
  title: "Question #2", 
  text: "This is a sample YES/NO question.",
  visible: true,
  locked: false
)

Answer.create(question: q2, data: "Yes", correct: true)
Answer.create(question: q2, data: "No", correct: false)

q3 = Question.create(
  user: vedran, 
  room: test_room, 
  type: text_multiple_choice,
  title: "Question #3", 
  text: "This is a sample multiple choice question.",
  visible: true,
  locked: false
)

Answer.create(question: q3, data: "Answer 1", correct: false)
Answer.create(question: q3, data: "Answer 2", correct: true)
Answer.create(question: q3, data: "Answer 3", correct: false)
Answer.create(question: q3, data: "Answer 4", correct: false)