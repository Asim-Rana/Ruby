require 'singleton'
require_relative 'Book'
# This class is being used to perform operations on books.
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
      return true if book.name == name
    end
    false
  end

  def add_book(book)
    File.open(File.dirname(__FILE__) + '/books.txt', 'a') do |line|
      line.puts book.name + ';' + book.rating + "\r"
      puts 'Book added successfully'
    end
    initialize
  end

  def delete_book(name)
    filtered_books = filter_books(name)
    File.truncate(File.dirname(__FILE__) + '/books.txt', 0)
    filtered_books.each do |filtered_book|
      File.open(File.dirname(__FILE__) + '/books.txt', 'a') do |line|
        line.puts filtered_book
      end
    end
    initialize
    puts 'Book deleted successfully'
  end

  def filter_books(name)
    filtered_books = []
    all_books = File.readlines(File.dirname(__FILE__) + '/books.txt')
    all_books.each do |book|
      book_details = book.split(';')
      filtered_books.push(book) unless
      book_details[0].casecmp(name.downcase).zero?
    end
    filtered_books
  end

  def search_book(search_string)
    searched_books = []
    @books.each do |book|
      searched_books.push(book) if book.name.include? search_string
    end
    searched_books
  end

  def display_books
    @books.each { |book| puts "#{book.name} - #{book.rating}" }
  end
end
