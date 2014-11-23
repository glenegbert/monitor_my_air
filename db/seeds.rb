conditions =  [ "lung_disease",
                "heart_disease",
                "children",
                "older_adult",
                "active_outdoors",
                "general_population"]

conditions.map do |condition|
  Condition.create(name: condition)
end
