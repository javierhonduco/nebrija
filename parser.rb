require 'nokogiri'
require 'json'

file = 'single.html'

doc = Nokogiri::HTML(IO.read(file)
                     .gsub!(/[\n]+/, '')
                     .gsub!(/[ ]{1,}+/, ' '))

is_single = doc.css('body > ul').length.zero?

puts "This is #{'not' if is_single }a multiple meaning word."

if is_single
    data = []
    single_results = {:id => doc.css('body > div > a').first['name'].to_i, :data => data}
    states = [:definitions, :entry]
    state = :entry
    index = -1 # HACK(javierhonduco)
    doc.css('body > div > p').each do |entry|
        if entry['class'] == 'p' and state == :entry
            word = entry.css('span').inner_text
            word = 'V:' if word == ''
            data << {:word => word, :meanings => []}
            index+=1
        else
            text = entry.inner_text.strip.gsub(/[0-9]+\.[ ]/, '')
            gender = text[0]
            next if text[0] == '(' # Del latín, Nil.    
            meta_regex = /^([a-z]{1,4}+\.[ ])+/
            unparsed_meta = text.scan meta_regex
            text = text.gsub(meta_regex, '')
            number = text[0]
            data[index][:meanings] << text if !text.nil? and text != ''
            state = :definitions
        end
        state = :entry
    end 
    puts JSON.pretty_generate(single_results)
else
    multiple_result = []
    doc.css('body > ul > li > a').each do |word|
        multiple_result << {
            :word => word.css('span').first.inner_text,
            :href => word['href'].gsub(/search\?id=/, '')
        }
    end 
    puts JSON.pretty_generate(multiple_result)
end
# doc.search('h3.r a.l', '//h3/a').each do |link|
# puts link.content
# end
