class AdminController < ApplicationController
  before_filter :is_admin?

  def is_admin?
    unless current_user.role.name == "admin"
      flash[:notice] = "You are not authorized to view that."
      self.route_to_proper_controller
    end
  end

 
end
