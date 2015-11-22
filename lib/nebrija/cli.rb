require 'json'
require_relative './rae'

module Nebrija
  def self.cli word
    if word.nil?
      puts 'Type smthg!'
      abort('Wrong args')
    end


    response = Rae.new.search(word)

    status = response[:status]

    if status == 'error'
      puts 'Word does not exist. :(.'
    else
      type = response[:type]
      data = response[:response]

      if type == 'multiple'
        puts 'We found multiple words matching your search criteria:'
        puts 'Search by id to find their meaning.'
        puts
        data.each_with_index do |entry, i|
          puts "#{i+1}. #{entry[:word]} ~> #{entry[:id]}"
        end
      else

        data.each_with_index do |entry, i|
          puts "#{i+1}. #{entry[:word]}"
          entry[:meanings].each_with_index do |definitions, j|
            puts "\t#{j+1}. #{definitions[:definition]}"
            puts "\t\tMeta: #{definitions[:meta]}" if !definitions[:meta].nil?
          end
        end
      end
    end
  end
end
