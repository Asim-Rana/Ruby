require_relative 'BookStoreV3'

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
