class Admin::HomeController < ApplicationController

  before_filter :hide_side_panels
  
  def index
    @profile = @p
  end
 
  def greetings
  end

  def admin
    @profile = @p
  end

  def blogs
    @blogs = @p.sent_blogs
  end

  def send_blog
    blog = Blog.find(params[:id])
    blog.update_attribute(:is_sent,true)
    @profiles = Profile.active_profiles
    admin_sender = Profile.admins.first
    @profiles.each do|profile|
      ArNotifier.sent_news(blog,profile).deliver if profile.wants_email_notification?("news")
      admin_sender.sent_messages.create(:subject => "[#{SITE_NAME} News] #{blog.title} by #{blog.sent_by}",
        :body => blog.body, :receiver => profile, :system_message => true) if profile.wants_message_notification?("news")
    end
    redirect_to :back
    flash[:notice] = "Mail was successfully sent"
  end

  private

  def hide_side_panels
    @hide_panels = true
    @show_admin_header = true
  end
  
end