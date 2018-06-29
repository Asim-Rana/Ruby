require 'singleton'
require_relative 'Book'

class BookStore

 include Singleton
 
 def initialize
  @books = []
  File.open(File.dirname(__FILE__) + '/books.txt').each do |line|
      book_string = line.split(';')
      book = Book.new(book_string[0], book_string[1])
      @books << book
  end
 end

 def book_exists(name)
    @books.each do |book|
      return true if book.get_name == name
    end
    false
 end

 def add_book(book)
   File.open(File.dirname(__FILE__) + '/books.txt', "a") do |line|
   line.puts book.get_name + ";" + book.get_rating + "\r"
   puts 'Book added successfully'
   initialize
  end
 end

 def delete_book(name)
  filtered_books = []
  all_books = File.readlines(File.dirname(__FILE__) + '/books.txt')
  all_books.each do |book|
   if book != nil
    book_details = book.split(";")
    if book_details[0].downcase != name.downcase
     filtered_books.push(book)
    end
   end
  end
  File.truncate(File.dirname(__FILE__) + '/books.txt', 0)
  filtered_books.each do |filtered_book|
   File.open(File.dirname(__FILE__) + '/books.txt', "a") do |line|
     line.puts filtered_book
   end
  end
  initialize
  puts 'Book deleted successfully'
 end

 def search_book(search_string)
  searched_books = []
  @books.each do |book|
    if book.get_name.include? search_string
     searched_books.push(book)
    end
  end
  searched_books
 end

 def display_books
  @books.each { |book| puts "#{book.get_name} - #{book.get_rating}"}
 end

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
 if book_store.book_exists(book_name)
  puts 'Book already exists!'
 else
  puts "Enter the book rating:"
  book_rating = gets.chomp
  book = Book.new(book_name, book_rating)
  book_store.add_book(book)
 end
elsif(option == 2)
 puts "Enter book name:"
 book_name = gets.chomp
 if book_store.book_exists(book_name)
   book_store.delete_book(book_name)
 else
   puts 'No Book Found'
 end
elsif(option == 3)
 puts "Enter search string:"
 search_string = gets.chomp
 searched_books = book_store.search_book(search_string)
 searched_books.each { |book| puts "#{book.get_name} - #{book.get_rating}"}
elsif(option == 4)
 book_store.display_books
else
 puts "You entered an invalid option"
end

