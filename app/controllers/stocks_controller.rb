require 'net/http'
require 'json'

class StocksController < ApplicationController
  def index
    @stock_data = fetch_stock_data
  end

  def fetch_stock_data
    @stock_data = []
    api_key = ENV['API_KEY']

    url = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=stock&apikey=#{api_key}"
    response = fetch_data_from_api(url)
    data = JSON.parse(response)

    data['bestMatches'].each do |match|
      symbol = match['1. symbol']
      quote_url = "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=#{symbol}&apikey=#{api_key}"
      response = fetch_data_from_api(quote_url)
      result = JSON.parse(response)

      if result.key?('Global Quote')
        name = match['2. name']
        price = result['Global Quote']['05. price']
        stock = Stock.find_by(symbol: symbol)

        if stock.nil?
          stock = Stock.create(name: name, symbol: symbol)
        end

        @stock_data << { name: name, symbol: symbol, price: price, id: stock.id }
      end
    end

    @stock_data
  end

  def fetch_data_from_api(url)
    uri = URI(url)
    Net::HTTP.get(uri)
  end
end
