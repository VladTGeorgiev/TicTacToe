# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#test

#test


easy = User.create(username: "EasyAI", password: "111", ai: true)
easy.avatar.purge
easy.avatar.attach(io: File.open(Rails.root.join('app','assets', 'images', 'easy_ai.jpg')), filename: 'easy-ai.jpg', content_type: 'image/jpg')

medium = User.create(username: "MediumAI", password: "111", ai: true)
medium.avatar.purge
medium.avatar.attach(io: File.open(Rails.root.join('app','assets', 'images', 'medium_ai.jpg')), filename: 'medium-ai.jpg', content_type: 'image/jpg')

hard = User.create(username: "HardAI", password: "111", ai: true)
hard.avatar.purge
hard.avatar.attach(io: File.open(Rails.root.join('app','assets', 'images', 'hard_ai.png')), filename: 'hard-ai.png', content_type: 'image/png')
