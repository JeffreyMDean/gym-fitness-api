class AchievementEarned
  def initialize(user)
    @user = user
  end

  def badge_earned(badge, description)
    @user.achievements.create(badge: badge, description: description)
  end

  def achievement_qualifications
    if @user.reps.count >= 10
      badge_earned('Personal Record', 'Congratulations! You have set a new personal record for total weight lifted, reps completed, or decreased rest time.')
    end

    if @user.routines.count > 4
      badge_earned('Consistency', "Congratulations! You have completed all your workouts for the week.")
    end
  end 
end