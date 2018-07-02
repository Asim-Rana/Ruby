require_relative '../../lib/BookStoreV5'
require_relative '../../lib/Book'
require_relative '../test_helper'
# This class is holding test cases of book store
class TestBookStore < Minitest::Test
  def setup
    @book_store = BookStore.instance
  end

  def test_book_add
    is_book_exists = @book_store.book_exists('science')
    book_added = false
    unless is_book_exists
      book = Book.new('science', '4')
      @book_store.add_book(book)
      book_added = true
    end
    assert_equal(true, book_added)
  end

  def test_book_delete
    is_book_exists = @book_store.book_exists('english')
    book_deleted = false
    if is_book_exists
      @book_store.delete_book('english')
      book_deleted = true
    end
    assert_equal(true, book_deleted)
  end
end
