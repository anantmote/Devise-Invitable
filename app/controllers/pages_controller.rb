class PagesController < ApplicationController
  before_filter :authenticate_user!

  before_action :set_page, only: [:show, :store_pagetime]

  def index
  	@page = Page.all
  end

  def show
    @pagetime = Page.userlog.build
  end

  def create
	  # @pagetime = Userlog.new(params[:userlog]) #wrong
	  # @pagetime.user_id = current_user
    # @pagetime.save
  end

  def store_pagetime
    @pagetime = Page.userlog.build(pagetime_params)
    @pagetime.user = current_user
    @pagetime.save
  end

  private

  def set_page
    @page = Page.find(params[:id])
  end

  def pagetime_params
     params.require(:page).permit(pagetime_attributes: [:id, :starttime, :endtime] )
  end
end
