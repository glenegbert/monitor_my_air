
class ReportsController < ApplicationController

  def index

  end

  def create
    @report = Report.new(params[:zip_code], params)
  end

  def show

  end

  private


end
