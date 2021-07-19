require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = [] # array of instances of Recipe
    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe) # recipe is an instance of Recipe
    @recipes << recipe
    save_csv
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    save_csv
  end

  def mark_as_done(index)
    # we need the recipe at that index
    recipe = @recipes[index]
    # mark it as done
    recipe.done!
    # save the csv
    save_csv
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      row[:done] = row[:done] == 'true'
      # row[:prep_time] = row[:prep_time].to_i
      # Old Array way
      # @recipes << Recipe.new(name: row[0], row[1])
      # New way with the attributes hash
      @recipes << Recipe.new(row)
    end
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << ['name', 'description', 'rating', 'done', 'prep_time']
      @recipes.each do |recipe| # recipe is an instance of Recipe
        csv << [recipe.name, recipe.description, recipe.rating, recipe.done?, recipe.prep_time]
      end
    end
  end
end
