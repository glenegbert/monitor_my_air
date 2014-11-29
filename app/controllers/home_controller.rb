class HomeController < ApplicationController
  respond_to :html, :js
  def index
    @report = Report.new
  end

end
