class User < ApplicationRecord 
  has_many :strava_user_totals
  has_many :reviews
   
  validates :strava_id, uniqueness: true
  validates :email, uniqueness: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  
  def self.from_omniauth(omniauth_return)
    user = find_or_initialize_by({
      strava_id: omniauth_return["extra"]["raw_info"]["id"]
    })
    user.firstname = omniauth_return["extra"]["raw_info"]["firstname"]
    user.lastname = omniauth_return["extra"]["raw_info"]["lastname"]
    user.email = omniauth_return["extra"]["raw_info"]["email"]
    user.token = omniauth_return["credentials"]["token"]
    user.save!
    return user
  end
  
  def update_strava_user_total
    strava_data = StravaUserTotal.new(user: self)
    strava_data.update_data
    strava_data
  end
end
