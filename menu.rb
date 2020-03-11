# frozen_string_literal: true

require 'tty-prompt'
require_relative 'menufunctions'
require_relative 'csvreader'

# Class for working with the menu
class Menu
  def initialize
    book_list = CsvReader.read_in_csv_books
    @menu_functions = MenuFunctions.new(book_list, CsvReader.read_in_csv_readers(book_list))
  end

  def create
    prompt = TTY::Prompt.new
    choices = initialize_choices

    loop do
      choice = prompt.select("\nВы находитесь в программе учёта книг в библиотеке. Выберите действие(0-11):", choices)
      case choice
      when 0
        break
      when 1..4
        choices_add_delete(choice)
      when 5..9
        choices_search(choice)
      when 10..11
        all_list(choice)
      end
    end
  end

  def initialize_choices
    [
      { name: '0) Выход из программы', value: 0 },
      { name: '1) Добавить книгу', value: 1 },
      { name: '2) Добавить читателя', value: 2 },
      { name: '3) Удалить читателя', value: 3 },
      { name: '4) Удалить книгу', value: 4 },
      { name: '5) Подобрать для вас книгу', value: 5 },
      { name: '6) Выдать книгу на руки', value: 6 },
      { name: '7) Вернуть книгу', value: 7 },
      { name: '8) Вывести список книг заданного жанра', value: 8 },
      { name: '9) Вывести книги, которые имеют просроченные несданные экземпляры', value: 9 },
      { name: '10) Список всех книг в библиотеке', value: 10 },
      { name: '11) Список всех читателей библиотеки', value: 11 }
    ]
  end

  def choices_search(choice)
    case choice
    when 5
      @menu_functions.line_up_book
    when 6
      @menu_functions.give_book
    when 7
      @menu_functions.return_book
    when 8
      @menu_functions.search_by_genre
    when 9
      @menu_functions.expired_books
    end
  end

  def choices_add_delete(choice)
    case choice
    when 1
      @menu_functions.add_book
    when 2
      @menu_functions.add_reader
    when 3
      @menu_functions.delete_reader
    when 4
      @menu_functions.delete_book
    end
  end

  def all_list(choice)
    case choice
    when 10
      @menu_functions.all_books
    when 11
      @menu_functions.all_readers
    end
  end
end
