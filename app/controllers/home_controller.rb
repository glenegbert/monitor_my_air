class HomeController < ApplicationController
  respond_to :html, :js
  def index
    @notifications = Notification.all
    @report = Report.new
    session[:return_to] = "home"
  end

end
