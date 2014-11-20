require 'rails_helper'


RSpec.describe Report, :type => :model do
  let(:report) do
    Report.new("80228",[])
  end

  before :each do
    report.stub(:parsed_observed) {[{"DateObserved"=>"2014-11-19 ", "HourObserved"=>17, "LocalTimeZone"=>"EST", "ReportingArea"=>"Pittsburgh", "StateCode"=>"PA", "Latitude"=>40.434, "Longitude"=>-79.984, "ParameterName"=>"O3", "AQI"=>25, "Category"=>{"Number"=>1, "Name"=>"Dangerous"}}, {"DateObserved"=>"2014-11-19 ", "HourObserved"=>17, "LocalTimeZone"=>"EST", "ReportingArea"=>"Pittsburgh", "StateCode"=>"PA", "Latitude"=>40.434, "Longitude"=>-79.984, "ParameterName"=>"PM2.5", "AQI"=>50, "Category"=>{"Number"=>1, "Name"=>"Poor"}}] }
    report.stub(:parsed_forecast) {[{"DateIssue"=>"2014-11-19 ", "DateForecast"=>"2014-11-20 ", "ReportingArea"=>"Denver", "StateCode"=>"CO", "Latitude"=>39.768, "Longitude"=>-104.873, "ParameterName"=>"O3", "AQI"=>-1, "Category"=>{"Number"=>1, "Name"=>"Good"}, "ActionDay"=>false, "Discussion"=>""}, {"DateIssue"=>"2014-11-19 ", "DateForecast"=>"2014-11-20 ", "ReportingArea"=>"Denver", "StateCode"=>"CO", "Latitude"=>39.768, "Longitude"=>-104.873, "ParameterName"=>"PM2.5", "AQI"=>155, "Category"=>{"Number"=>1, "Name"=>"Poor"}, "ActionDay"=>false, "Discussion"=>""}] }
  end

  describe 'returns forecasted data' do
      it 'returns forecasted levels' do
        expect(report.forecasted_levels).to include("Good", "Poor")
      end

      it 'returns forecasted_contaminates' do
        expect(report.forecasted_contaminates).to include("O3", "PM2.5")
      end

      it 'returns forecasted_contaminates_and_levels' do
        expect(report.forecasted_contaminates_and_levels.keys).to include("O3", "PM2.5")
        expect(report.forecasted_contaminates_and_levels.values).to include("Good", "Poor")
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
  end
end
