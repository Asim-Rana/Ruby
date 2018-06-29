require_relative '../lib/BookStoreV3'
require_relative '../lib/Book'
require 'minitest/autorun'

class TestBookStore < Minitest::Test
 
 def setup
    @book_store = BookStore.instance
 end

 def test_book_add
  is_book_exists = @book_store.book_exists("science")
  book_added = false
  if !is_book_exists
   book = Book.new("science", "4")
   @book_store.add_book(book)
   book_added = true
  end
  assert_equal(true, book_added)
 end  

 def test_book_delete
  is_book_exists = @book_store.book_exists("science")
  book_deleted = false
  if is_book_exists
   @book_store.delete_book("science")
   book_deleted = true
  end
  assert_equal(true, book_deleted)
 end  

end
