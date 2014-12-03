class Api::V1::ReportsController < ApplicationController

  respond_to :json, :html

  def show
    concerns = {}
    params[:conditions].split(",").each { |condition| concerns[condition] = "1" }
    @report = Report.new(params[:id], concerns)
    respond_with [@report.reporting_area, @report.health_effects?("today"), @report.health_effects?("tomorrow"), @report.observed_contaminates_and_levels, @report.forecasted_contaminates_and_levels]
  end

end


# http://localhost:3000/api/v1/reports/80228.json?conditions=children,lung_disease
