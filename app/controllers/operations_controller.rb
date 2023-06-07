include Pagy::Backend
require 'bigdecimal'

class OperationsController < ApplicationController
    before_action :authenticate_user!


    def create
      price = BigDecimal(params[:price])
      value_buy = price ** params[:quantity].to_i
      
      if params[:operation_type] == "buy" && current_user.balance > value_buy
        buy(params)
      end
      if params[:operation_type] == "buy" && current_user.balance < value_buy
        flash[:notice] = 'You need to ->'
        return redirect_to stocks_path
      end
    
      sell(params) if params[:operation_type] == "sell"

      if @trading.save
        balance(params)
        redirect_to trades_path, notice: 'Stock bought successfully.'
      end
    end
    
    def buy(params)
      new_trading(params)
    end
  
    def sell(params)
      new_trading(params)
      Operation.where(id: params[:operation_id]).update(operation_type: "buy->finish") if params[:operation_type] == "sell"
    end

    def balance(params)
      if params[:operation_type] == "buy"
        value_buy = params[:price].to_f ** params[:quantity].to_i
        current_user.balance = current_user.balance - value_buy
      end
      if params[:operation_type] == "sell"
        value_sell = params[:price].to_f ** params[:quantity].to_i
        current_user.balance = current_user.balance + value_sell
      end
      User.update(balance: current_user.balance)
    end
    
    def trades
      subquery = current_user.operations.select('operations.id')
      @pagy, @trades = pagy(Stock.joins(:operations).merge(subquery)
                               .select('stocks.name AS stock_name, stocks.symbol, stocks.id, operations.price, operations.quantity, operations.id AS operation_id, operations.operation_type'), items: 10)
    end
    
    def add_balance
      amount = params[:amount].to_f
      current_user.update(balance: current_user.balance + amount)
      redirect_to stocks_path
    end

    private
  
    def new_trading(params)
      @trading = Operation.create(
        user_id: current_user.id, 
        quantity: params[:quantity],
        operation_type: params[:operation_type], 
        stock_id: params[:stock_id], 
        price: params[:price]
      )
    end 

    def trading_params
      params.require(:trading).permit(:id, :user_id, :stock_id, :quantity, :operation_type, :price)
    end

  end
  