class Wagscore 
  attr_accessor locations

  def initialize
    @locations = locations
  end

  def calculate_score(locations)
    
  end

  def category_value
    100.0 / Category.count
  end
end
