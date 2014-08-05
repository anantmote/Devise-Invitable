class Admin::UsersController < ApplicationController
  
  def index
  	@user = User.all
  end

  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end
  
  def create
    @user = User.new(user_params)    
    if @user.save
      flash[:success] = "User is added successfully!"
      redirect_to [:admin, @user]
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "User is updated successfully!"
      redirect_to [:admin_user]
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted successfully"
    redirect_to [:admin_categories]
  end

  private
    def user_params
       params.require(:user).permit(:first_name,:last_name,:email,:phone,:state)
    end
 

end
