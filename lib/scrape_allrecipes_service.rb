require 'open-uri'
require 'nokogiri'

# html = we need to load the html file (later it will be the URL)
html = File.open('strawberry.html')
# doc = give the HTML to Nokogiri
doc = Nokogiri::HTML(html)
# search the doc for the title and the description
# doc.search('#card__title') # id
# doc.search('h3')  # tag_name
doc.search('.card__detailsContainer').map do |recipe_card|
  # p element.text.strip
  name = recipe_card.search('.card__title').text.strip
  description = recipe_card.search('.card__summary').text.strip
  puts name
  puts description
  Recipe.new(name, description)
end

# create an instance with the info
# return an array of these instance
