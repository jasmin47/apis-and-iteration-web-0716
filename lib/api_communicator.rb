require 'rest-client'
require 'json'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  # iterate ove the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.

# character_hash["results"].each do |key|
#    key.each do |key, value|
#      if key == "name"
#        puts value
#      end
#    end
#  end


  movie_urls = []
  character_hash["results"].each do |item|
    if item["name"] == character
      movie_urls << item["films"]
    end
  end

  movies_data = []
  movie_urls.each do |pelicula|
    pelicula.each do |movie|
      movie_variable = RestClient.get(movie)
      movies_data << JSON.parse(movie_variable)
    end
  end



  return  movies_data
end



def parse_character_movies(films_hash)

  # puts movies_data[0]['title']
  movie_titles = []
  films_hash.each do |movie|
    movie_titles << movie['title']
  end
  return movie_titles
  # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  puts parse_character_movies(films_hash)
end


## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
