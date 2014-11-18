require 'json'

class Report

  def initialize(zip_code)
    @zip_code = zip_code
  end

  def current_observed
    Faraday.get("http://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=#{@zip_code}&distance=25&API_KEY=6262A4E6-45AF-4316-8485-CB1A259D7231")
  end

  def current_ozone_value
    JSON.parse(current_observed.body)[0]["Category"]["Number"]
  end

  def current_particulate_value
    JSON.parse(current_observed.body)[0]["Category"]["Number"]
  end

  def ozone_reporting_area
    JSON.parse(current_observed.body)[0]["ReportingArea"]
  end

  def particulate_reporting_area
    JSON.parse(current_observed.body)[1]["Category"]
  end

  def current_ozone_category
    JSON.parse(current_observed.body)[0]["Category"]["Name"]
  end

  def current_particulate_category
    JSON.parse(current_observed.body)[0]["Category"]["Name"]
  end
end
