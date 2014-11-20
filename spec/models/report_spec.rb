require 'rails_helper'


RSpec.describe Report, :type => :model do
  let(:report) do
    Report.new("80228",{
               "utf8"=>"✓",
               "authenticity_token"=>"uLsBZ4fGAxNJY3+y+ysuJ5/omt7ysQtjvfhU5aLnMqA=",
               "zip_code"=>"80228",
               "lung_disease"=>"0",
               "heart_disease"=>"0",
               "children"=>"1",
               "older_adult"=>"0",
               "active_outdoors"=>"1",
               "general_population"=>"0",
               "commit"=>"Submit",
               "action"=>"create",
               "controller"=>"reports"})
  end

  before :each do
    report.stub(:parsed_observed) {[{"DateObserved"=>"2014-11-19 ", "HourObserved"=>17, "LocalTimeZone"=>"EST", "ReportingArea"=>"Pittsburgh", "StateCode"=>"PA", "Latitude"=>40.434, "Longitude"=>-79.984, "ParameterName"=>"O3", "AQI"=>25, "Category"=>{"Number"=>1, "Name"=>"Dangerous"}}, {"DateObserved"=>"2014-11-19 ", "HourObserved"=>17, "LocalTimeZone"=>"EST", "ReportingArea"=>"Pittsburgh", "StateCode"=>"PA", "Latitude"=>40.434, "Longitude"=>-79.984, "ParameterName"=>"PM2.5", "AQI"=>50, "Category"=>{"Number"=>1, "Name"=>"Poor"}}] }
    report.stub(:parsed_forecast) {[{"DateIssue"=>"2014-11-19 ", "DateForecast"=>"2014-11-20 ", "ReportingArea"=>"Denver", "StateCode"=>"CO", "Latitude"=>39.768, "Longitude"=>-104.873, "ParameterName"=>"O3", "AQI"=>40, "Category"=>{"Number"=>1, "Name"=>"Good"}, "ActionDay"=>false, "Discussion"=>""}, {"DateIssue"=>"2014-11-19 ", "DateForecast"=>"2014-11-20 ", "ReportingArea"=>"Denver", "StateCode"=>"CO", "Latitude"=>39.768, "Longitude"=>-104.873, "ParameterName"=>"PM10", "AQI"=>155, "Category"=>{"Number"=>1, "Name"=>"Poor"}, "ActionDay"=>false, "Discussion"=>""}] }
  end

  describe 'returns forecasted data' do
      it 'returns forecasted levels' do
        expect(report.forecasted_levels).to include("Good", "Poor")
      end

      it 'returns forecasted_contaminates' do
        expect(report.forecasted_contaminates).to include("O3", "PM10")
      end

      it 'returns forecasted_contaminates_and_levels' do
        expect(report.forecasted_contaminates_and_levels.keys).to include("O3", "PM10")
        expect(report.forecasted_contaminates_and_levels.values).to include("Good", "Poor")
      end

      it 'returns forecasted aqi values' do
        expect(report.forecasted_aqi_values).to include(40,155)
      end

      it 'returns forcasted contaminates and levels' do
        expect(report.forecasted_contaminates_and_levels.keys).to include("O3", "PM10")
        expect(report.forecasted_contaminates_and_levels.values).to include("Good", "Poor")
      end

      it 'returns forecasted contaminates and aqi levels' do
        expect(report.forecasted_contaminates_and_aqi_values.keys).to include("O3", "PM10")
        expect(report.forecasted_contaminates_and_aqi_values.values).to include(40, 155)

      end
  end

  describe 'returns observed data' do
      it 'returns observed levels' do
        expect(report.observed_levels).to include("Dangerous", "Poor")
      end

      it 'returns observed_contaminates' do
        expect(report.observed_contaminates).to include("O3", "PM2.5")
      end

      it 'returns observed_contaminates_and_levels' do
        expect(report.observed_contaminates_and_levels.keys).to include("O3", "PM2.5")
        expect(report.observed_contaminates_and_levels.values).to include("Dangerous", "Poor")
      end

      it 'returns observed aqi values' do
        expect(report.observed_aqi_values).to include(25,50)
      end


      it 'returns observed contaminates and aqi values' do
        expect(report.observed_contaminates_and_aqi_values.keys).to include("O3", "PM2.5")
        expect(report.observed_contaminates_and_aqi_values.values).to include(25, 50)
      end

      it 'returns the reporting area' do
        expect(report.reporting_area).to eq("Pittsburgh")
      end
  end

  describe 'returns health concern data' do
      it 'returns cleaned checked concerns' do
        expect(report.clean_checked_concerns).to include("children", "active outdoors")
        expect(report.clean_checked_concerns).to_not include("create")
      end

      it 'returns checked concerns with underscores' do
        expect(report.checked_concerns).to include("children", "active_outdoors")
        expect(report.checked_concerns).to_not include("create")
      end

      it 'checks for lung disease alerts based on the date' do
        expect(report.lung_disease?("today")).to be false
        expect(report.lung_disease?("tomorrow")).to be true
      end

      it 'checks for heart_disease alerts based on the date' do
        expect(report.heart_disease?("today")).to be false
        expect(report.heart_disease?("tomorrow")).to be true
      end

      it 'checks for children alerts based on the date' do
        expect(report.children?("today")).to be false
        expect(report.children?("tomorrow")).to be true
      end

      it 'checks for older_adult alerts based on the date' do
        expect(report.older_adult?("today")).to be false
        expect(report.older_adult?("tomorrow")).to be true
      end

      it 'checks for active_outdoors alerts based on the date' do
        expect(report.active_outdoors?("today")).to be false
        expect(report.active_outdoors?("tomorrow")).to be true
      end

      it 'checks for general_population alerts based on the date' do
        expect(report.general_population?("today")).to be false
        expect(report.general_population?("tomorrow")).to be true
      end

      it 'checks if there is any AQI levels are in the red zone' do
        expect(report.red_zone?("today")).to be false
        expect(report.red_zone?("tomorrow")).to be true
      end

      it 'checks if there are likely health effects for the checked params' do
        expect(report.health_effects?("today")).to be false
        expect(report.health_effects?("tomorrow")).to be true
      end
  end
end
