class Users::InvitationsController < Devise::InvitationsController

  before_filter :configure_permitted_parameters, if: :devise_controller?	

  def new
  	super
  end 

  private

  # this is called when creating invitation
  # should return an instance of resource class
  def invite_resource
    ## skip sending emails on invite
    resource_class.invite!(invite_params, current_inviter) do |u|
      u.skip_invitation = true
    end
  end

  # this is called when accepting invitation
  # should return an instance of resource class
  def accept_resource
    resource = resource_class.accept_invitation!(update_resource_params)
    ## Report accepting invitation to analytics
    Analytics.report('invite.accept', resource.id)
    resource
  end

  def configure_permitted_parameters
  	  devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation)
   		 end
	  # Only add some parameters
	  devise_parameter_sanitizer.for(:accept_invitation).concat [:email, :username]
	  # Override accepted parameters
	  devise_parameter_sanitizer.for(:accept_invitation) do |u|
	    u.permit(:email, :username)
  end
  end 
end