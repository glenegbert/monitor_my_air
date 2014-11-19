
class ReportsController < ApplicationController

  def index

  end

  def create
    @report = Report.new(params[:zip_code])
    @concerns = checked_concerns(params)
    # create a method that returns pollutants and values
    # look at each health concern indicated
    # check to see if the value for specified polutants is in an orange range
    # check to see if a value for any pollutant is in a red range

  end

  def show

  end

  private

  def checked_concerns(params)
    checked_concerns = params.map {|concern, value| concern if value == "1"}.compact
    checked_concerns.map {|concern| concern.gsub("_", " ")}
  end
end
