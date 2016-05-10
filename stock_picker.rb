def stock_picker(stocks)
  buy, sell = stocks.min, stocks.max
  profit = sell - buy
  if stocks.index(stocks.min) < stocks.index(stocks.max)
    p days = [stocks.index(stocks.min), stocks.index(stocks.max)]    
  else
    buy, sell = {day: 1, price: stocks[1]}, {day: 1, price: stocks[1]}
    profit = 0
    stocks.each_with_index do |price, day|
      sell = {day: day, price: price} if (price > sell[:price] && day > 0)
      buy = {day: day, price: price} if (sell[:price] - price > profit && day < sell[:day])
      profit = sell[:price] - buy[:price] if ((sell[:day] > buy[:day]) && (sell[:price] - buy[:price] > profit))
    end
    p days = [buy[:day], sell[:day]]
  end
end

print "Enter the stock prices, separated by commas and sorted by day: "

stocks = gets.chomp.split(",").map {|s| s.to_i}

stock_picker(stocks)