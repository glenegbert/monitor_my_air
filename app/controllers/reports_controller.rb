
class ReportsController < ApplicationController
  respond_to :html, :js

  def index
    redirect_to home_index_path
  end

  def create
    @report = Report.new(params[:report][:zip_code], params)
    if @report.invalid? && session[:return_to] == "create"
      render "create"
    elsif @report.invalid? && session[:return_to] == "home"
      render "home/index"
    end
    session[:return_to] = "create"
  end

  def show

  end

  private


end
