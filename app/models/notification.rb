class Notification < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :conditions


  def clean_conditions
    self.conditions.map{|condition| condition.name.gsub("_"," ")}.join(", ")

  end

  def clean_conditions_message
    concerns= self.conditions.map{|condition| condition.name.gsub("_"," ")}
    message = concerns.map do |concern|
      if concern == concerns.last && concerns.count > 1
      "and #{concern}."
      elsif concerns.count > 1
        concern + ","
      else
        concern + "."
      end
    end
    return message.join(" ")
  end

end
