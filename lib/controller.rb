require_relative 'view'
require_relative 'recipe'
require_relative 'scrape_allrecipes_service'

class Controller
  def initialize(cookbook)
    @view = View.new
    @cookbook = cookbook
  end

  def create
    name = @view.ask_for('recipe name')
    description = @view.ask_for('recipe description')
    rating = @view.ask_for('recipe rating')
    prep_time = @view.ask_for('recipe prep time')
    # Create the recipe
    recipe = Recipe.new(
      name: name,
      description: description,
      rating: rating,
      prep_time: prep_time
    )
    # Store the recipe in the cookbook
    @cookbook.add_recipe(recipe)
  end

  def list
    display_recipes
  end

  def destroy
    # Display the recipes
    display_recipes
    # Ask which one to destroy? (index)
    index = @view.ask_for_index
    # Remove the recipe from the cookbook
    @cookbook.remove_recipe(index)
  end

  def import
    # ask them what they want to search for
    keyword = @view.ask_for('ingredient')
    # recipes = give the keyword to our scraper
    recipes = ScrapeAllrecipesService.new(keyword).call
    # display the recipes to the user
    @view.display(recipes)
    # index = ask which one to import
    index = @view.ask_for_index
    # recipe = get the recipe with the index
    recipe = recipes[index]
    # give the recipe to the cookbook
    @cookbook.add_recipe(recipe)
  end

  def mark_as_done
    # display recipes
    display_recipes
    # index = ask for index
    index = @view.ask_for_index
    @cookbook.mark_as_done(index)
  end

  private

  def display_recipes
    # Retrieve the recipes from the cookbook
    recipes = @cookbook.all
    # Display the recipes
    @view.display(recipes)
  end
end
