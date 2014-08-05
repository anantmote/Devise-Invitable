class Users::InvitationsController < Devise::InvitationsController

  before_filter :configure_permitted_parameters, if: :devise_controller?

  def new
  	super
  end

  def edit
    super
  end

  def create
    super
    flash[:notice] = "User invited" #need to check if create was successful
  end

  private

  # this is called when accepting invitation
  # should return an instance of resource class
  def accept_resource
    resource = resource_class.accept_invitation!(update_resource_params)
    resource.role = Role.find_by(name: "admin") #needs to change to "registered" once that section is ready
    resource
  end

  def configure_permitted_parameters
  	  devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation)
   		 end

	  # Override accepted parameters
	  devise_parameter_sanitizer.for(:accept_invitation) do |u|
	    u.permit(:password, :password_confirmation, :invitation_token)
    end
  end

end
