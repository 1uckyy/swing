# frozen_string_literal: true

# Print all list functions module
module PrintFunctions
  def self.all_books(book_list)
    book_list.each_with_index do |book, index_book|
      puts "#{index_book + 1}) #{book}"
    end
  end

  def self.all_readers(readers_list)
    readers_list.each_with_index do |reader, index_reader|
      puts "#{index_reader + 1}) #{reader.full_information}\nСписок книг:"
      if reader.list_books_date_return.empty?
        puts 'Пусто'
      else
        reader.list_books_date_return.each do |book|
          puts "#{book[0]} Дата возврата: #{book[1]}"
        end
      end
    end
  end
end
