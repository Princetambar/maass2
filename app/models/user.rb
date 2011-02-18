# == Schema Information
#
# Table name: users
#
#  id                   :integer(4)      not null, primary key
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  password_salt        :string(255)     default(""), not null
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer(4)      default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  login_name           :string(255)
#  first_name           :string(255)
#  last_name            :string(255)
#  middle_name          :string(255)
#  maiden_last_name     :string(255)
#  group                :string(255)
#  gender               :string(255)
#  question             :string(255)

class User < ActiveRecord::Base

  include Humanizer

  has_one :profile
  accepts_nested_attributes_for :profile

  SEX = ["Male","Female"]
  GROUP=["Teacher","Guest"]+(1992..Date.today.year+1).to_a
  EDU_YEAR=(1990..Date.today.year+5).to_a
  PERMISSION_FIELDS = %w(website blog about_me gtalk_name location email
                         date_of_birth anniversary_date relationship_status
                         spouse_name gender activities yahoo_name skype_name
                         educations work_informations delicious_name
                         twitter_username msn_username linkedin_name
                         address landline mobile marker)
  NOTIFICATION_FIELDS = %w(news event message blog_comment
                          profile_comment follow delete_friend )
  PERSONAL_INFO= %w(house_name blood_group date_of_birth address_line1 landline mobile relationship_status spouse_name aniversery_date professional_qualification about_me activities)

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :password_confirmation, :remember_me, :login
  attr_accessible :humanizer_answer, :humanizer_question_id
  require_human_on :create

  validates :login, :presence => true,
                         :length => { :maximum => 20 },
                         :uniqueness => true

end