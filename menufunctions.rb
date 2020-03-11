# frozen_string_literal: true

require 'tty-prompt'
require_relative 'bookdescription'
require_relative 'librarybook'
require_relative 'reader'
require_relative 'addfunctions'
require_relative 'choosefunctions'
require_relative 'searchfunctions'
require_relative 'printalllistfunctions'

# The class contains methods that describe the capabilities of the user
class MenuFunctions
  attr_reader :book_list, :readers_list
  def initialize(book_list, readers_list)
    @book_list = book_list
    @readers_list = readers_list
    @prompt = TTY::Prompt.new
  end

  def add_book
    @book_list << AddFunctions.add_book if AddFunctions.add_book != false
  end

  def add_reader
    @readers_list << AddFunctions.add_reader
  end

  def delete_reader
    index = ChooseFunctions.choose_reader(@readers_list)
    reader_books_list = readers_list.delete_at(index)
    reader_books_list.list_books_date_return.each do |deletedbook|
      book_list.each do |librarybook|
        if deletedbook[0].inventory_number == librarybook.bookdescription.inventory_number
          librarybook.delete_book_on_hand
          break
        end
      end
    end
  end

  def delete_book
    index = ChooseFunctions.choose_book(@book_list)
    deleted_inventory_number = book_list.delete_at(index).bookdescription.inventory_number
    readers_list.each_with_index do |reader, index_reader|
      reader.list_books_date_return.each_with_index do |book, index_book|
        if book[0].inventory_number == deleted_inventory_number
          readers_list[index_reader].list_books_date_return.delete_at(index_book)
          break
        end
      end
    end
  end

  def line_up_book
    index = ChooseFunctions.choose_reader(@readers_list)
    case @prompt.select('Отбор по жанру или автору?', %w[жанр автор])
    when 'жанр'
      ChooseFunctions.list_genre(@book_list)
    when 'автор'
      author = @prompt.ask('Введите автора')
      @book_list.each do |book|
        if book.bookdescription.age_rating <= readers_list[index].age? && book.bookdescription.authors_name == author
          puts book.to_s
        end
      end
    end
  end

  def give_book
    reader_index = ChooseFunctions.choose_reader(@readers_list)
    book_index = ChooseFunctions.choose_book(@book_list)
    if @book_list[book_index].book_in_library?
      @readers_list[reader_index].list_books_date_return << [@book_list[book_index].bookdescription, Date.today + 14]
    else
      puts 'Книги нет в библиотеке'
    end
  end

  def return_book
    index_reader = ChooseFunctions.choose_reader(@readers_list)

    choices = []
    @readers_list[index_reader].list_books_date_return.each_with_index do |book, index_book|
      choices << { name: book[0].to_s, value: index_book }
    end
    index_book = @prompt.select('Выберите книгу', choices)

    deleted_book = @readers_list[index_reader].list_books_date_return.delete_at(index_book)
    @book_list.each do |book|
      if book.bookdescription.inventory_number == deleted_book[0].inventory_number
        book.delete_book_on_hand
        break
      end
    end

    fine(deleted_book)
  end

  def fine(deleted_book)
    fine_years = 0
    fine_years = (Date.today.year - deleted_book[1].year) * 365 if Date.today.year > deleted_book[1].year
    if Date.today.yday <= deleted_book[1].yday
      puts 'Нет штрафа'
    else
      puts "Штраф #{Date.today.yday - deleted_book[1].yday + fine_years} рублей"
    end
  end

  def search_by_genre
    SearchFunctions.search_by_genre(@book_list)
  end

  def expired_books
    SearchFunctions.expired_books(@readers_list)
  end

  def all_books
    PrintFunctions.all_books(@book_list)
  end

  def all_readers
    PrintFunctions.all_readers(@readers_list)
  end
end
