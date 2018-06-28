class Book

 def initialize(name, rating)
  @name = name
  @rating = rating
 end

 def get_name
  @name
 end

 def get_rating
  @rating
 end

end

class BookStore

 @@instance = BookStore.new

 def self.instance
   @@instance
 end
 
 def add_book(book)
   File.open("books.txt", "a") do |line|
   line.puts book.get_name + ";" + book.get_rating + "\r"
  end
 end

 def delete_book(name)
  filtered_books = []
  all_books = File.readlines("books.txt")
  all_books.each do |book|
   if book != nil
    book_details = book.split(";")
    if book_details[0].downcase != name.downcase
     filtered_books.push(book)
    end
   end
  end
  File.truncate("books.txt", 0)
  filtered_books.each do |filtered_book|
   File.open("books.txt", "a") do |line|
     line.puts filtered_book
   end
  end
 end

 def search_book(search_string)

  searched_books = []
  all_books = File.readlines("books.txt")
  all_books.each do |book|
  if book != nil
    book_details = book.split(";")
    if book_details[0].include? search_string
     searched_books.push(book)
    end
   end
  end
  searched_books
 end

 def display_books
  File.readlines("books.txt")
 end

 private_class_method :new

end

book_store = BookStore.instance

puts "1: Add a book"
puts "2: Delete a book"
puts "3: Search a book"
puts "4: Display all books"
option = gets.chomp.to_i

if(option == 1)
 puts "Enter book name:"
 book_name = gets.chomp
 puts "Enter the book rating:"
 book_rating = gets.chomp
 book = Book.new(book_name, book_rating)
 book_store.add_book(book)
elsif(option == 2)
 puts "Enter book name:"
 book_name = gets.chomp
 book_store.delete_book(book_name)
elsif(option == 3)
 puts "Enter search string:"
 search_string = gets.chomp
 puts book_store.search_book(search_string)
elsif(option == 4)
 puts book_store.display_books
else
 puts "You entered an invalid option"
end

