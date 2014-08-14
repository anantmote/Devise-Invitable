class Admin::UserlogsController < ApplicationController

  before_filter :authenticate_user!,:is_admin?
  
  def is_admin?
    unless current_user.role.name == "admin"
      flash[:notice] = "You are not authorized to view that."
      self.route_to_proper_controller
    end
  end
 

  def index
  	@userlogs = Userlog.all.paginate(page: params[:page], per_page: 5)
  end

  def mostactiveuser
    @userlogs = Userlog.select('*, sum(timespent) as total').group('user_id').order('total desc').paginate(page: params[:page], per_page: 5)
  end
  
  def mostactivepage
    @userlogs = Userlog.select('*, sum(timespent) as total').group('page_id').order('total desc').paginate(page: params[:page], per_page: 5)
  end

  def userpagecount
    @userlogs =  Userlog.select("page_id,user_id,count(page_id) as pgcount").group("page_id , user_id").order('user_id').paginate(page: params[:page], per_page: 5)
  end

end
