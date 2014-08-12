class PagesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
  	@page = Page.all
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

 
end
