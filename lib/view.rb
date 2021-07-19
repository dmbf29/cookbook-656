class View
  def ask_for(something)
    puts "What is the #{something}?"
    print '> '
    gets.chomp
  end

  def ask_for_index
    puts "Which recipe? (Enter a number)"
    print '> '
    gets.chomp.to_i - 1
  end

  def display(recipes) # an array of INSTANCES
    puts "==== These are your recipes: ===="
    recipes.each_with_index do |recipe, index|
      x_mark = recipe.done? ? "X" : " "
      puts "#{index + 1}. [#{x_mark}] #{recipe.name} - #{recipe.description} [#{recipe.rating}/5] - Prep time: #{recipe.prep_time}"
    end
    puts '---------------------------------'
  end
end
