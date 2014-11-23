class Score
  attr_accessor :location_list

  def initializer(location_list)
    @location_list = location_list
  end

  def self.calculate(location_list)
    find_unique_categories(location_list).count * category_value
  end

  def self.find_unique_categories(location_list)
    categories_present = []
    if location_list.present?
      location_list.each do |location|
        categories_present << location.categories.all
      end
      categories_present.flatten.uniq
    else
      []
    end
  end

  def self.category_value
    100.0 / Category.count
  end
end
