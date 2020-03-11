# frozen_string_literal: true

require 'tty-prompt'

# Search functions module
module SearchFunctions
  def self.search_by_genre(book_list)
    prompt = TTY::Prompt.new
    genre = prompt.select('Выберите жанр', %w[novel story drama])
    books_on_genres = []
    book_list.each do |book|
      books_on_genres << book.bookdescription if book.bookdescription.genre == genre
    end
    books_on_genres = books_on_genres.sort
    books_on_genres.each do |book|
      puts book
    end
  end

  def self.expired_books(readers_list)
    arr_expired_books = []
    readers_list.each_with_index do |reader, _index_reader|
      reader.list_books_date_return.each_with_index do |book, index_book|
        if (reader.book_expired?(index_book) == true) && (arr_expired_books.include?(book[0]) != true)
          arr_expired_books << book[0]
        end
      end
    end
    puts arr_expired_books
  end
end
