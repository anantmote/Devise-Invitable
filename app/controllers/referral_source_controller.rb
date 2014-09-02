class ReferralSourceController < ApplicationController
  before_filter :is_referral_source?

  def is_referral_source?
    unless current_user.role.title == "referral source"
      flash[:notice] = "You are not authorized to view that."
      self.route_to_proper_controller
    end
  end
  
end
