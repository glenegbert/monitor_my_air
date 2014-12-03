require 'air_monitor'

class Report

  include ActiveModel::Model
  include AirMonitor

  attr_accessor :zip_code, :checked_concerns

  validates_presence_of :zip_code
  validates_presence_of :checked_concerns


end
