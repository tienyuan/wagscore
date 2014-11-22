class Score
  attr_accessor :location_list

  def initializer(location_list)
    @location_list = location_list
  end

  def self.calculate(location_list)
    
  end

  def self.category_value
    100.0 / Category.count
  end
end
