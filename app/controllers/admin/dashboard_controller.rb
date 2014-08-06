class Admin::DashboardController < ApplicationController
  before_filter :authenticate_user! 

  def is_admin?
    unless current_user.role.name == "admin"
      flash[:notice] = "You are not authorized to view that."
      self.route_to_proper_controller
    end
  end

  def index
  
  end

 
end
