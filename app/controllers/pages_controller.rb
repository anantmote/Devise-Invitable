class PagesController < ApplicationController
  before_filter :authenticate_user!,:is_referral_source?
  
  def is_referral_source?
    unless current_user.role.name == "registered"
      flash[:notice] = "You are not authorized to view that."
      self.route_to_proper_controller
    end
  end

  def index
  	#@page = Page.all
     
    if params[:search]
      @page = Page.search(params[:search]).order("created_at DESC").paginate(page: params[:page], per_page: 5)
    else
      @page = Page.order("created_at DESC").paginate(page: params[:page], per_page: 2)
    end

  end

  def show
     @page = Page.find(params[:id])
  end

  def ajax_sum3
        userId = params["user_id"].to_i
        pageId = params["page_id"].to_i
        timespent = params["timespent"].to_i
        startdt = params["startdate"].to_time.strftime("%Y-%m-%d")
        enddt= params["enddate"].to_time.strftime("%Y-%m-%d")
        #sleep(2)
        if userId != 0 
          result  = timespent
          @userlog = Userlog.new(user_id:userId, page_id:pageId, timespent:timespent,starttime:startdt,endtime:enddt)
          if @userlog.save
                respond_to do |format|

             # format.html { redirect_to [:pages], notice: result +                       ' was successfully add to your client list.' }
                format.json {render :json => {:result => result}}
            end
          end
        end
    end

    def search
      @page = Page.search params[:search]
    end

 
end
