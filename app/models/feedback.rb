class Feedback < ActiveRecord::Base
  include Humanizer
  belongs_to :profile
  after_save :send_feedback_to_admin
  validates :name, :email, :message, :subject, :presence => true
  require_human_on :create

  private

  def send_feedback_to_admin    
    rec_profile = Profile.admin_emails
    ArNotifier.delay.feedback_mail(self.reload, rec_profile)
  end
  
end