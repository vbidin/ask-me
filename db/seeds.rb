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
yes_no = Type.yes_no
text_choice = Type.text_choice
text_multiple_choice = Type.text_multiple_choice

yes_no.save!
text_choice.save!
text_multiple_choice.save!

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

room = Room.create(name: "Room #1", open: true)
Permission.create(user: vedran, room: room, role: admin)
Permission.create(user: pero, room: room, role: mod)

Room.create(name: "Room #22", open: false)
Room.create(name: "Test room", open: true)
Room.create(name: "Room #692741", open: false)
Room.create(name: "Room Room", open: false)
Room.create(name: "Room", open: false)
Room.create(name: "Room of horrors", open: false)
Room.create(name: "Room #215415", open: false)
Room.create(name: "Room #5692", open: false)
Room.create(name: "Room #125", open: false)
Room.create(name: "Roomy", open: true)
Room.create(name: "Room #111", open: false)
Room.create(name: "Room #901", open: false)

room = Room.create(name: "Closed room", open: false)
Permission.create(user: vedran, room: room, role: admin)

Room.create(name: "Room #23582768074693", open: false)
Room.create(name: "Room #3", open: false)
Room.create(name: "Room #2451", open: false)
