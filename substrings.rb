def substrings(text, dictionary)
  words = text.downcase.split(" ")
  frequencies = Hash.new(0)
  words.each do |word|
    dictionary.each do |substring|
      frequencies[substring] += 1 if word.include?(substring)
    end
  end
  puts frequencies
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

substrings("below", dictionary)
substrings("Howdy partner, sit down! How's it going?", dictionary)