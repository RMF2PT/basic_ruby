stop_words = %w{the a by on for of are with just but and to the my I has some in}

lines = File.readlines("text.txt")
line_count = lines.size
text = lines.join
character_count = text.length
character_count_nospaces = text.gsub(/\s+/, '').length
words = text.split
word_count = words.size
sentence_count = text.split(/\.|\?|!/).length
paragraph_count = text.split(/\n\r/).length
keywords = words.select {|word| !stop_words.include?(word)}
percentage_usefull_words = ((keywords.length / words.length.to_f) * 100).to_i

def interesting_sentences(text)
    # gsub gets rid of all large areas of whitespace and replaces them with a single space
    sentences = text.gsub(/\s+/, ' ').strip.split(/\.|\?|!/)
    sentences_sorted = sentences.sort_by {|sentence| sentence.length}
    one_third = sentences_sorted.length / 3
    ideal_sentences = sentences_sorted.slice(one_third, one_third + 1)
    ideal_sentences = ideal_sentences.select {|sentence| sentence =~ /is|are/}
end

puts "#{line_count} lines"
puts "#{character_count} characters"
puts "#{character_count_nospaces} characters (excluding spaces)"
puts "#{word_count} words"
puts "#{sentence_count} sentences"
puts "#{paragraph_count} paragraphs"
puts "#{sentence_count / paragraph_count} sentences per paragraph (average)"
puts "#{word_count / sentence_count} words per sentence (average)"
puts "The percentage of \"usefull\" words is #{percentage_usefull_words}%"
puts "Some suggestions for summary for this text might be:"
puts interesting_sentences(text).join(". ")