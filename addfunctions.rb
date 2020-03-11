# frozen_string_literal: true

require 'tty-prompt'

# Menu add functions
module AddFunctions
  def self.add_book
    prompt = TTY::Prompt.new
    authors_name = ask_validated('Введите фамилию и инициалы автора', /^[A-Z]{1}[a-z]+\s[A-Z]{1}.\s[A-Z]{1}.$/,
                                 'Pushkin A. S.')
    book_title = prompt.ask('Введите название книги')
    inventory_number = ask_validated('Введите инвентаризационный номер', /^[0-9]{4}$/, '1234')
    genre = ask_validated('Введите жанр', /^[a-z]+$/, 'story')
    age_rating = ask_validated('Введите возрастной рейтинг', /^[0-9]{1,2}$/, '12')
    num_books_in_lib = ask_validated('Введите количество книг в библиотеке', /^[0-9]+$/, '12')
    LibraryBook.new(BookDescription.new(authors_name, book_title, inventory_number,
                                        genre, age_rating), num_books_in_lib, 0)
  end

  def self.add_reader
    prompt = TTY::Prompt.new
    begin
      surname = ask_validated('Введите фамилию', /^[A-Z]{1}[a-z]+$/, 'Pushkin')
      name = ask_validated('Введите имя', /^[A-Z]{1}[a-z]+$/, 'Alexander')
      patronymic = ask_validated('Введите отчество', /^[A-Z]{1}[a-z]+$/, 'Sergeevich')
      date_of_birth = prompt.ask('Введите дату рождения', convert: :date)
      reader_books_list = []
      return Reader.new(surname, name, patronymic, date_of_birth, reader_books_list)
    rescue StandardError
      puts 'Неверный ввод. Попробуйте ввести в формате: yyyy-mm-dd'
      return false
    end
  end

  def self.ask_validated(ques, reg, example)
    prompt = TTY::Prompt.new
    prompt.ask(ques) do |q|
      q.validate(reg, "Неверный ввод. Попробуйте ввести в формате: #{example}")
    end
  end
end
