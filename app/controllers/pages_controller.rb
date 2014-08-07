class PagesController < ApplicationController
  before_filter :authenticate_user!
  def index
  	@page = Page.all
  end

  def show
  	@page = Page.find(params[:id])
  end

  def create

	  @pagetime = Userlog.new(params[:userlog])
	  @pagetime.user_id = current_user
      @pagetime.save
	  
  end
  
end
