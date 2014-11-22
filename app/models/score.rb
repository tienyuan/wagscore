class Score
  attr_accessor :location_list

  def initializer(location_list)
    @location_list = location_list
  end

  def self.calculate(location_list)
    categories_present = []
    location_list.each do |location|
      categories_present << location.categories.name unless categories_present.include?(location.categories.name)
    end
    categories_present.count * category_value
  end

  def self.category_value
    100.0 / Category.count
  end
end
