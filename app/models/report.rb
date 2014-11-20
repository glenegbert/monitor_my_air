
class Report

  def initialize(zip_code, params)
    @zip_code = zip_code
    @params = params
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

  def observed_aqi_values
    JSON.parse(observed.body).map {|data| data["AQI"]}
  end

  def observed_contaminates_and_aqi_values
    Hash[observed_contaminates.zip observed_aqi_values]
  end

  def reporting_area
    JSON.parse(observed.body)[0]["ReportingArea"]
  end

  def clean_checked_concerns
    checked_concerns.map {|concern| concern.gsub("_", " ")}
  end

  def checked_concerns
    checked_concerns = @params.map {|concern, value| concern if value == "1"}.compact
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
    red_zone?
  end


  def alert?(condition_indcators, day)
    if day == "today"
      contaminates_aqis = observed_contaminates_and_aqi_values
    else
      contaminates_aqis = forecasted_contaminates_and_aqi_values
    end
    present_condition_indicators = contaminates_aqis.keys.map do |contaminate|
      if condition_indcators.include?(contaminate)
        contaminate
      end
    end.compact
    present_condition_indicators.any?{|indicator| observed_contaminates_and_aqi_values[indicator] > 100} ||
    red_zone?
  end

  def red_zone?
    observed_contaminates_and_aqi_values.values.any? {|value| value > 150}
  end

  def health_effects?(day)
    check_alerts_methods = checked_concerns.map {|concern| concern + "?"}
    alerts = check_alerts_methods.map {|method| send(method, day)}
    alerts.include?(true)
  end
end
