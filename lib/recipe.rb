class Recipe
  attr_reader :name, :description, :rating, :prep_time

  def initialize(attributes = {})
    @name = attributes[:name]
    @description = attributes[:description]
    @rating = attributes[:rating]
    @done = attributes[:done] || false
    @prep_time = attributes[:prep_time]
  end

  def done?
    @done
  end

  def done!
    @done = !@done
  end
end

# p Recipe.new('asda', 'a;sda', 'asda')
# p Recipe.new(name: 'beef whatever', description: 'this is the desc')
# p Recipe.new(name: 'beef whatever')
# p Recipe.new
