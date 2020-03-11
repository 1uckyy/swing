# frozen_string_literal: true

require 'tty-prompt'

# Choose functions module
module ChooseFunctions
  def self.choose_reader(readers_list)
    prompt = TTY::Prompt.new
    choices = []
    readers_list.each_with_index do |reader, index_reader|
      choices << { name: "#{index_reader + 1}) #{reader}", value: index_reader }
    end
    prompt.select('Выберите читателя', choices)
  end

  def self.choose_book(book_list)
    prompt = TTY::Prompt.new
    choices = []
    book_list.each_with_index do |book, index_book|
      choices << { name: "#{index_book + 1}) #{book.bookdescription}", value: index_book }
    end
    prompt.select('Выберите книгу', choices)
  end

  def self.list_genre(book_list)
    prompt = TTY::Prompt.new
    genre = prompt.select('Выберите жанр', %w[novel story drama])
    book_list.each do |book|
      if book.bookdescription.age_rating <= readers_list[index].age? && book.bookdescription.genre == genre
        puts book.to_s
      end
    end
  end
end
