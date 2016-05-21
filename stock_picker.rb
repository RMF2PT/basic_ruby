def stock_picker(stocks)
  buy, sell = stocks.min, stocks.max
  profit = sell - buy
  if stocks.index(stocks.min) < stocks.index(stocks.max)
    p [stocks.index(stocks.min), stocks.index(stocks.max)]
  else
    buy, sell = { day: 1, price: stocks[1] }, { day: 1, price: stocks[1] }
    profit = 0
    stocks.each_with_index do |price, day|
      sell = { day: day, price: price } if price > sell[:price] && day > 0
      if sell[:price] - price > profit && day < sell[:day]
        buy = { day: day, price: price }
      end
      if (sell[:day] > buy[:day]) && (sell[:price] - buy[:price] > profit)
        profit = sell[:price] - buy[:price]
      end
    end
    p [buy[:day], sell[:day]]
  end
end

print 'Enter the stock prices, separated by commas and sorted by day: '

stocks = gets.chomp.split(',').map(&:to_i)

stock_picker(stocks)
