require 'json'
require 'date'

class Report

  def initialize(zip_code)
    @zip_code = zip_code
  end

  def forecast
    tomorrow = Date.today + 1
    Faraday.get("http://www.airnowapi.org/aq/forecast/zipCode/?format=application/json&zipCode=#{@zip_code}&date=#{tomorrow.strftime('%Y-%m-%d')}&distance=100&API_KEY=6262A4E6-45AF-4316-8485-CB1A259D7231")
  end

  def observed
    Faraday.get("http://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=#{@zip_code}&distance=25&API_KEY=6262A4E6-45AF-4316-8485-CB1A259D7231")
  end

  def forecasted_levels
    JSON.parse(forecast.body).map {|data| data["Category"]["Name"]}
  end

  def forecasted_contaminates
    JSON.parse(forecast.body).map {|data| data["ParameterName"]}
  end

  def forecasted_contaminates_and_levels
    Hash[forecasted_contaminates.zip forecasted_levels]
  end

  def observed_levels
    JSON.parse(observed.body).map {|data| data["Category"]["Name"]}
  end

  def observed_contaminates
    JSON.parse(observed.body).map {|data| data["ParameterName"]}
  end

  def observed_contaminates_and_levels
    Hash[observed_contaminates.zip observed_levels]
  end

  def reporting_area
    JSON.parse(observed.body)[0]["ReportingArea"]
  end


end
