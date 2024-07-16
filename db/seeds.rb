# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
exercise1 = Exercise.new(name: "pull-ups", description: "This exercise involves hanging from a bar and pulling one's body weight until their chin is above the bar. Arguably one of the best upper body exercises that targets the lats, biceps, trapezius, and rhomboids while also engaging the core and forearms.", image_url: "https://weighttraining.guide/wp-content/uploads/2016/10/pull-up-2-resized.png", video_url: "https://www.youtube.com/watch?v=8CCUnkJZ-lY")
exercise1.save!

exercise2 = Exercise.new(name: "Farmer's Walk", description: "This exercise  involves carrying dumbells or kettlebells with your arms at the sides for a set distance. This exerice uses 80-90% of your muscles while also building functional strength, cardiovascular fitness, and coordination.", image_url: "https://hips.hearstapps.com/hmg-prod/images/2019-menshealth-formcheck-ep37-farmerscarry-ms-editorinitials-v1-stringout-00-11-21-15-still004-1568231680.jpg", video_url: "https://www.youtube.com/watch?v=_EYaAajmXQA")
exercise2.save!

exercise3 = Exercise.new(name: "push-ups", description: "This is a bodyweight exercise that involves pushing yourself off the floor while keeping a neutral spine. This exercise strengthens the pecs, anterior delts, triceps, and core.", image_url: "https://www.fitnesseducation.edu.au/wp-content/uploads/2017/03/Pushups.jpg", video_url: "https://www.youtube.com/watch?v=i9sTjhN4Z3M")
exercise3.save!

User.destroy_all

user1 = User.create!(name: "Joe Smith", email: "joe@email.com", password: "password", image_url: "https://avatar.iran.liara.run/public/47")

user2 = User.create!(name: "Diana Jones", email: "diana@email.com", password: "password", image_url: "https://avatar.iran.liara.run/public/65")

user3 = User.create!(name: "Paul Miller", email: "paul@email.com", password: "password", image_url: "https://avatar.iran.liara.run/public/46")

routine1 = Routine.new(user_id: user2.id, exercise_id: exercise1.id, reps: 20)
routine1.save!

routine2 = Routine.new(user_id: user1.id, exercise_id: exercise3.id, reps: 15)
routine2.save!

routine3 = Routine.new(user_id: user3.id, exercise_id: exercise2.id, reps: 4)
routine3.save!


comment1 = Comment.new(user_id: user1.id, exercise_id: exercise3.id, body: "This is an excellent body weight exercise. I've found it to be an essential part of my repertoire for at home workouts too!")
comment1.save!

comment2 = Comment.new(user_id: user2.id, exercise_id: exercise2.id, body: "This is one of my favorite exercises for building functional strength!")
comment2.save!

comment3 = Comment.new(user_id: user3.id, exercise_id: exercise1.id, body: "I love doing pullups with varying grips and bar sizes to keep things novel!")
comment3.save!




