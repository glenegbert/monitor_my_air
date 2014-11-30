class Condition < ActiveRecord::Base
  has_and_belongs_to_many :notifications

  def clean_condition
    self.name.gsub("_"," ")
  end

end
