# frozen_string_literal: true

require 'csv'
require_relative 'bookdescription'
require_relative 'librarybook'
require_relative 'reader'

# File read functions
module CsvReader
  # Reading list of books from file
  def self.read_in_csv_books
    books_list = []
    CSV.foreach('data/books.csv', headers: true) do |row|
      books_list << LibraryBook.new(BookDescription.new(row['authors_name'], row['book_title'], row['inventory_number'],
                                                        row['genre'], Integer(row['age_rating'])),
                                    Integer(row['num_books_in_lib']), Integer(row['num_books_on_hand']))
    end
    books_list
  end

  # Reading list of readers from file
  def self.read_in_csv_readers(books_list)
    readers_list = []
    CSV.foreach('data/readers.csv', headers: true) do |row_readers|
      reader_books_list = []
      CSV.foreach('data/booksdate.csv', headers: true) do |row_booksdate|
        if read_in_csv_booksdate(books_list, row_readers, row_booksdate, reader_books_list)
          reader_books_list << read_in_csv_booksdate(books_list, row_readers, row_booksdate, reader_books_list)
        end
      end
      readers_list << Reader.new(row_readers['surname'], row_readers['name'], row_readers['patronymic'],
                                 Date.parse(row_readers['date_of_birth']), reader_books_list)
    end
    readers_list
  end

  # Reading file booksdate.csv
  def self.read_in_csv_booksdate(books_list, row_readers, row_booksdate, _reader_books_list)
    return unless row_readers['id_list'] == row_booksdate['id_list']

    books_list.each do |x|
      if x.bookdescription.inventory_number == row_booksdate['inventory_number']
        return [x.bookdescription, Date.parse(row_booksdate['return_date'])]
      end
    end
  end
end
