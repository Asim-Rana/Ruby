def addBook
 puts "Enter book name:"
 book_name = gets.chomp
 puts "Enter the book rating:"
 book_rating = gets.chomp

 File.open("books.txt", "a") do |line|
  line.puts book_name + ";" + book_rating + "\r"
 end
end

def deleteBook
 puts "Enter book name:"
 book_name = gets.chomp
 filtered_books = []
 all_books = File.readlines("books.txt")
 all_books.each do |book|
  if book != nil
   book_details = book.split(";")
   if book_details[0].downcase != book_name.downcase
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

def searchBook
 puts "Enter search string:"
 search_string = gets.chomp
 all_books = File.readlines("books.txt")
 all_books.each do |book|
 if book != nil
   book_details = book.split(";")
   if book_details[0].include? search_string
    puts book
   end
  end
 end
end

def displayAllBooks
 all_books = File.readlines("books.txt")
 all_books.each do |book|
    puts book
 end
end


puts "1: Add a book"
puts "2: Delete a book"
puts "3: Search a book"
puts "4: Display all books"
option = gets.chomp.to_i

if(option == 1)
 addBook
elsif(option == 2)
 deleteBook
elsif(option == 3)
 searchBook
elsif(option == 4)
 displayAllBooks
else
 puts "You entered an invalid option"
end

