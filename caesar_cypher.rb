def caesar_cipher(sentence, key)
  sentence.map do |letter|
    letter_ordinal = letter.ord
    if letter >= 'A' && letter <= 'Z'
      (((letter_ordinal - 'A'.ord + key) % 26) + 'A'.ord).chr
    elsif letter >= 'a' && letter <= 'z'
      (((letter_ordinal - 'a'.ord + key) % 26) + 'a'.ord).chr
    else
      letter
    end
  end.join
end

print 'Give me a sentence: '
sentence = gets.chomp.strip.split(//)

print 'Give me a cypher key: '
key = gets.chomp.strip.to_i

cipher_text = caesar_cipher(sentence, key)

puts cipher_text
