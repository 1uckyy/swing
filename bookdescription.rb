# frozen_string_literal: true

# Class containing book information
class BookDescription
  include Comparable
  attr_reader :authors_name, :book_title, :inventory_number, :genre, :age_rating
  def <=>(other)
    authors_name <=> other.authors_name
  end

  def initialize(authors_name, book_title, inventory_number, genre, age_rating)
    @authors_name = authors_name
    @book_title = book_title
    @inventory_number = inventory_number
    @genre = genre
    @age_rating = age_rating
  end

  def to_s
    "ФИО автора: #{@authors_name} Название: '#{@book_title}'"
  end

  def full_description
    "ФИО автора: #{@authors_name} Название: '#{@book_title}' Инвентаризационный номер: #{@inventory_number}
    Жанр: #{@genre}Возрастной рейтинг: #{@age_rating}"
  end
end
