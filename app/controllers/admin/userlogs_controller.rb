class Admin::UserlogsController < ApplicationController

  before_filter :authenticate_user!
 

  def index
  	@userlogs = Userlog.all.paginate(page: params[:page], per_page: 8)
  end

  def mostactiveuser
    @userlogs = Userlog.select('*, sum(timespent) as total').group('user_id').order('total desc')
  end
  
  def mostactivepage
    @userlogs = Userlog.select('*, sum(timespent) as total').group('page_id').order('total desc')
  end

  def userpagecount
    @userlogs =  Userlog.select("page_id,user_id,count(page_id) as pgcount").group("page_id , user_id").order('user_id')
  end

end
