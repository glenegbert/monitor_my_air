
class Report

  include ActiveModel::Model

  attr_accessor :zip_code, :checked_concerns

  validates_presence_of :zip_code
  validates_presence_of :checked_concerns

  def initialize(zip_code=nil, params={})
    @zip_code = zip_code
    @checked_concerns = params.map {|concern, value| concern if value == "1"}.compact
  end

  def forecast
    tomorrow = Date.today + 1
    Faraday.get("http://www.airnowapi.org/aq/forecast/zipCode/?format=application/json&zipCode=#{@zip_code}&date=#{tomorrow.strftime('%Y-%m-%d')}&distance=100&API_KEY=6262A4E6-45AF-4316-8485-CB1A259D7231")
  end

  def observed
    Faraday.get("http://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=#{@zip_code}&distance=25&API_KEY=6262A4E6-45AF-4316-8485-CB1A259D7231")
  end

  def parsed_forecast
    JSON.parse(forecast.body)
  end

  def parsed_observed
    JSON.parse(observed.body)
  end

  def forecasted_levels
    parsed_forecast.map {|data| data["Category"]["Name"]}
  end

  def forecasted_contaminates
    parsed_forecast.map {|data| data["ParameterName"]}
  end

  def forecasted_contaminates_and_levels
    Hash[forecasted_contaminates.zip forecasted_levels]
  end

  def observed_levels
    parsed_observed.map {|data| data["Category"]["Name"]}
  end

  def observed_contaminates
    parsed_observed.map {|data| data["ParameterName"]}
  end

  def observed_contaminates_and_levels
    Hash[observed_contaminates.zip observed_levels]
  end

  def observed_aqi_values
    parsed_observed.map {|data| data["AQI"]}
  end

  def forecasted_aqi_values
    parsed_forecast.map {|data| data["AQI"]}
  end

  def forecasted_contaminates_and_aqi_values
    Hash[forecasted_contaminates.zip forecasted_aqi_values]
  end

  def observed_contaminates_and_aqi_values
    Hash[observed_contaminates.zip observed_aqi_values]
  end

  def reporting_area
    parsed_observed[0]["ReportingArea"]
  end

  def clean_checked_concerns
    concerns = checked_concerns.map {|concern| concern.gsub("_", " ")}
    concerns.map! do |concern|
      if concern == concerns.last && concerns.count > 1
        "and #{concern}."
      elsif concerns.count > 1
         concern + ","
      else
         concern + "."
      end
    end
    concerns.join(" ")
  end

  def lung_disease?(day)
    condition_indicators = ["O3","PM2.5","PM10"]
    alert?(condition_indicators, day)
  end

  def heart_disease?(day)
    condition_indicators = ["PM2.5","PM10"]
    alert?(condition_indicators, day)
  end

  def children?(day)
    condition_indicators = ["O3","PM2.5","PM10"]
    alert?(condition_indicators, day)
  end

  def older_adult?(day)
    condition_indicators = ["O3","PM2.5","PM10"]
    alert?(condition_indicators, day)
  end

  def active_outdoors?(day)
    condition_indicators = ["O3"]
    alert?(condition_indicators, day)
  end

  def general_population?(day)
    red_zone?(day)
  end

  def alert?(condition_indicators, day)
    if day == "today"
      contaminates_aqis = observed_contaminates_and_aqi_values
    else
      contaminates_aqis = forecasted_contaminates_and_aqi_values
    end
    present_condition_indicators = contaminates_aqis.keys & condition_indicators
    present_condition_indicators.any?{|indicator| contaminates_aqis[indicator] > 100} ||
    red_zone?(day)
  end

  def red_zone?(day)
    if day == "today"
      observed_contaminates_and_aqi_values.values.any? {|value| value > 150}
    else
      forecasted_contaminates_and_aqi_values.values.any? {|value| value > 150}
    end
  end

  def health_effects?(day)
    check_alerts_methods = checked_concerns.map {|concern| concern + "?"}
    alerts = check_alerts_methods.map {|method| send(method, day)}
    alerts.include?(true)
  end
end
