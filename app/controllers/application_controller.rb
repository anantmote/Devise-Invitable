class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
 

  def after_sign_in_path_for(user)
    if current_user.role.name == "admin"
      admin_path
    elsif current_user.role.name == "registered"
      home_path
    end
  end

  def after_sign_out_path_for(user)
    new_user_session_path
  end

  def route_to_proper_controller
    if current_user.role.name == "admin"
      redirect_to admin_path
    elsif current_user.role.name == "registered"
      redirect_to home_path
    end
  end


end
