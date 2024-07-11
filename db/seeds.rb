# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
exercise = Exercise.new(name: "pull-ups", description: "This exercise involved hanging from a bar and pulling one's body weight until their chin is above the bar. Arguably one of the best upper body exercises that targets the lats, biceps, trapezius, and rhomboids while also engaging the core and forearms.", image_url: "https://weighttraining.guide/wp-content/uploads/2016/10/pull-up-2-resized.png", video_url: "https://www.youtube.com/watch?v=8CCUnkJZ-lY")
exercise.save!

exercise = Exercise.new(name: "Farmer's Walk", description: "This exercise  involves carrying dumbells or kettlebells with your arms at the sides for a set distance. This exerice uses 80-90% of your muscles while also building functional strength, cardiovascular fitness, and coordination.", image_url: "https://hips.hearstapps.com/hmg-prod/images/2019-menshealth-formcheck-ep37-farmerscarry-ms-editorinitials-v1-stringout-00-11-21-15-still004-1568231680.jpg", video_url: "https://www.youtube.com/watch?v=_EYaAajmXQA")
exercise.save!

exercise = Exercise.new(name: "push-ups", description: "This is a bodyweight exercise that involves pushing yourself off the floor while keeping a neutral spine. This exercise strengthens the pecs, anterior delts, triceps, and core.", image_url: "https://www.fitnesseducation.edu.au/wp-content/uploads/2017/03/Pushups.jpg", video_url: "https://www.youtube.com/watch?v=i9sTjhN4Z3M")
exercise.save!

routine = Routine.new(user_id: 2, exercise_id: 1, reps: 20)
routine.save!

routine = Routine.new(user_id: 1, exercise_id: 3, reps: 15)
routine.save!

routine = Routine.new(user_id: 3, exercise_id: 2, reps: 4)
routine.save!



