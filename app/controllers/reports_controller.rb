
class ReportsController < ApplicationController

  def index
    redirect_to home_index_path
  end

  def create
    @report = Report.new(params[:zip_code], params)
  end

  def show

  end

  private


end
