# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#


Room.create([{ title: '文化学園' }, { title: '押部谷中学校' }, { title: '丸子北中学校' }])
Room.find(1).questions.create([{text: "01+01=", answer:"10"},{text: "01+10=", answer:"11"}])
Room.find(2).questions.create([{text: "01+01=", answer:"10"},{text: "01+10=", answer:"11"}])
Room.find(3).questions.create([{text: "01+01=", answer:"10"},{text: "01+10=", answer:"11"}])