require 'json'
require 'nebrija'

module Nebrija
  def self.cli word
    if word.nil?
      abort 'Type a word `$ nebrija amor`'
    end

    result = Rae.new.search(word)
    status = result[:status]
    response = result[:response]

    if status == 'error'
      puts 'Word does not exist. :(.'
    else
      puts "#{word}:"
      puts
      response[:core_meanings].each do |meaning|
        puts "\t#{meaning[:meaning]}"
      end
      puts
      puts
      response[:other_meanings].each do |meaning|
        puts "#{meaning[:expression]}:"
        meaning[:meanings].each do |sub|
          puts "\t#{sub[:meaning]}"
        end
        puts
      end
    end
  end
end
