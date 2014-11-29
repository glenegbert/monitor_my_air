
class ReportsController < ApplicationController
  respond_to :html, :js
  
  def index
    redirect_to home_index_path
  end

  def create
    @report = Report.new(params[:report][:zip_code], params)
    if @report.invalid?
      render "home/index"
    end
  end

  def show

  end

  private


end
