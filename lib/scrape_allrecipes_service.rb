require 'open-uri'
require 'nokogiri'
require 'pry-byebug'
require_relative 'recipe'

class ScrapeAllrecipesService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    # html = we need to load the html file (later it will be the URL)
    url = "https://www.allrecipes.com/search/results/?search=#{@keyword}"
    html = URI.open(url).read
    # doc = give the HTML to Nokogiri
    doc = Nokogiri::HTML(html)
    # search the doc for the title and the description
    # doc.search('#card__title') # id
    # doc.search('h3')  # tag_name
    doc.search('.card__detailsContainer').first(5).map do |recipe_card|
      # p element.text.strip
      name = recipe_card.search('.card__title').text.strip
      description = recipe_card.search('.card__summary').text.strip
      rating = recipe_card.search('.rating-star.active').count
      recipe_url = recipe_card.search('.card__titleLink').attribute('href').value
      prep_time = fetch_prep_time(recipe_url)
      Recipe.new(
        name: name,
        description: description,
        rating: rating,
        prep_time: prep_time
      )
      # Recipe.new(name, description, rating, prep_time)
    end
    # create an instance with the info
    # return an array of these instance
  end

  def fetch_prep_time(url)
    # get the html with url
    html = URI.open(url).read
    # give the html to nokogiri
    doc = Nokogiri::HTML(html)
    # search for the preptime
    return doc.search('.recipe-meta-item-body').first.text.strip
  end
end
