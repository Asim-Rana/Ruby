# A model class named Book
class Book
  attr_reader :name
  attr_reader :rating
  def initialize(name, rating)
    @name = name
    @rating = rating
  end
end
