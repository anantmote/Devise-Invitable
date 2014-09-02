class Devise::InvitationsController < DeviseController

  #before_filter :authenticate_user!,:is_admin?
  before_filter :is_admin?, :only => [:new, :create]
  before_filter :configure_permitted_parameters, if: :devise_controller?
  prepend_before_filter :authenticate_inviter!, :only => [:new, :create]
  prepend_before_filter :has_invitations_left?, :only => [:create]
  prepend_before_filter :require_no_authentication, :only => [:edit, :update, :destroy]
  prepend_before_filter :resource_from_invitation_token, :only => [:edit, :destroy]
  helper_method :after_sign_in_path_for

  #if not admin then code will execute
  def is_admin?
    unless current_user.role.name == "admin"
      flash[:notice] = "You are not authorized to view that."
      self.route_to_proper_controller
    end
  end

  # GET /resource/invitation/new
  def new
    self.resource = resource_class.new
    render :new
  end

  # POST /resource/invitation
  def create
    self.resource = invite_resource

    if resource.errors.empty?
      yield resource if block_given?
      set_flash_message :notice, :send_instructions, :email => self.resource.email if self.resource.invitation_sent_at
      respond_with resource, :location => after_invite_path_for(resource)
    else
      respond_with_navigational(resource) { render :new }
    end
  end

  # GET /resource/invitation/accept?invitation_token=abcdef
  def edit
    resource.invitation_token = params[:invitation_token]
    render :edit
  end

  # PUT /resource/invitation
  def update
    self.resource = accept_resource

    if resource.errors.empty?
      yield resource if block_given?
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
      set_flash_message :notice, flash_message
      sign_in(resource_name, resource)
      respond_with resource, :location => after_accept_path_for(resource)
    else
      respond_with_navigational(resource){ render :edit }
    end
  end
  
  # GET /resource/invitation/remove?invitation_token=abcdef
  def destroy
    resource.destroy
    set_flash_message :notice, :invitation_removed
    redirect_to after_sign_out_path_for(resource_name)
  end

  protected

  def invite_resource(&block)
    resource_class.invite!(invite_params, current_inviter, &block)
  end
  
  #def accept_resource
   # resource_class.accept_invitation!(update_resource_params)
  #end

  def accept_resource
    resource = resource_class.accept_invitation!(update_resource_params)
    resource.role = Role.find_by(name: "registered") #needs to change to "registered" once that section is ready
    resource
  end

  def current_inviter
    authenticate_inviter!
  end

  def has_invitations_left?
    unless current_inviter.nil? || current_inviter.has_invitations_left?
      self.resource = resource_class.new
      set_flash_message :alert, :no_invitations_remaining
      respond_with_navigational(resource) { render :new }
    end
  end
  
  def resource_from_invitation_token
    unless params[:invitation_token] && self.resource = resource_class.find_by_invitation_token(params[:invitation_token], true)
      set_flash_message(:alert, :invitation_token_invalid)
      redirect_to after_sign_out_path_for(resource_name)
    end
  end

  def invite_params
    devise_parameter_sanitizer.sanitize(:invite)
  end

  def update_resource_params
    devise_parameter_sanitizer.sanitize(:accept_invitation)
  end
  
  private

  def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) do |u|
      #u.permit(:email, :password, :password_confirmation,:username)
      u.permit(:username, :password, :password_confirmation)
       end
    # Override accepted parameters
    devise_parameter_sanitizer.for(:accept_invitation) do |u|
      u.permit(:username,:password, :password_confirmation, :invitation_token)
    end
  end


end