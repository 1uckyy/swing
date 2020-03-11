# frozen_string_literal: true

# Class containing reader information
class Reader
  attr_reader :list_books_date_return
  def initialize(surname, name, patronymic, date_of_birth, list_books_date_return)
    @surname = surname
    @name = name
    @patronymic = patronymic
    @date_of_birth = date_of_birth
    @list_books_date_return = list_books_date_return
  end

  def age?
    age = Date.today.year - @date_of_birth.year
    age -= 1 if Date.today.yday < @date_of_birth.yday
    age
  end

  def to_s
    "Фамилия: #{@surname} Имя: #{@name} Отчество: #{@patronymic}"
  end

  def full_information
    "Фамилия: #{@surname} Имя: #{@name} Отчество: #{@patronymic} Дата рождения: #{@date_of_birth}"
  end

  def book_expired?(book_index)
    @list_books_date_return[book_index][1] < Date.today
  end
end
