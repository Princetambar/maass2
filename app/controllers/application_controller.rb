class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_profile, :pagination_defaults

  def search_results
    p = params[:search] ? params[:search].dup : {}
    @title = "Search"
    @q , @q_val = p[:key] ? ["Search for Friends",p[:q]] : [p[:q],"Search"]
    @results = Profile.search_by_keyword(p)
  end
  
  def set_profile
    if current_user
      @p = current_user.profile
      @is_admin = current_user if current_user.admin
    end
  end

  def pagination_defaults
    @page = (params[:page] || 1).to_i
    @page = 1 if @page < 1
    @per_page = params[:per_page]
  end
    
end