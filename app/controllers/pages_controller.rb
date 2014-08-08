class PagesController < ApplicationController
  before_filter :authenticate_user!
  def index
  	@page = Page.all
  end

  def show
  	@page = Page.find(params[:id])
  end


  def ajax_sum3
        userId = current_user.id
        pageId = params["page_id"].to_i
        timespent = params["timespent"].to_i
        starttime = params["starttime"]
        endtime = params["endtime"]
        result  = timespent
        @userlog = Userlog.new(user_id:userId, page_id:pageId, timespent:timespent)
        if @userlog.save
              respond_to do |format|

           # format.html { redirect_to [:pages], notice: result +                       ' was successfully add to your client list.' }
              format.json {render :json => {:result => result}}
        end
      end
    end

end
