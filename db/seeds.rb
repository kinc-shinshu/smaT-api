# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

for i in 1 .. 300 do
  room = Room.create({ title: '文化学園', status: 0 })
  i_str = i.to_s
  if i < 100 || i_str.include?('0')
    room.destroy
  end
end
