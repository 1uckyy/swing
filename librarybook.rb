# frozen_string_literal: true

require_relative 'bookdescription'

# Class containing the book's description object and quantity information
class LibraryBook
  attr_reader :bookdescription, :num_books_in_lib, :num_books_on_hand
  def initialize(bookdescription, num_books_in_lib, num_books_on_hand)
    @bookdescription = bookdescription
    @num_books_in_lib = num_books_in_lib
    @num_books_on_hand = num_books_on_hand
  end

  def delete_book_on_hand
    @num_books_on_hand -= 1
  end

  def book_in_library?
    num_books_in_lib > num_books_on_hand
  end

  def to_s
    "#{@bookdescription.full_description} Количество книг в библиотеке: #{@num_books_in_lib}
    Количество книг на руках: #{@num_books_on_hand}"
  end
end
