require 'pry'
require 'rails_helper'

RSpec.describe 'OperationsController', type: :controller do

  before do 
    @stock = Stock.create(name: "STOCKteste", symbol: 'STKST')
    @user = User.create(email: "test@test.com", password: "test123")
    @controller = OperationsController.new
    sign_in @user
  end

  describe "POST #create" do
    
    context "when opereation type is 'buy' " do

      context "with sufficient user balance" do
        before do 
          @user.update(balance: 1500.00)
          post :create, params: {
              quantity: 1,
              operation_type: "buy",
              stock_id: @stock.id,
              price: "20.00"
            }, session: { user_id: @user.id }
        end  
        it "creates a new Operation" do
          expect(Operation.count).to eq(1)
        end  
        it "reduces the user balance" do
          @user.reload
          expect(@user.balance).to eq(1480.00)
        end        
        it "redirects to trades_path" do
          expect(response).to redirect_to(trades_path)
        end  
        it "sets a flash notice" do
          expect(flash[:notice]).to eq('Stock bought successfully.')
        end
      end

      context "with sufficient user balance" do
        before do 
          @user.update(balance: 50.00)
          post :create, params: {
              quantity: 5,
              operation_type: "buy",
              stock_id: @stock.id,
              price: "20.00"
            }, session: { user_id: @user.id }
        end
        it "does not creates a new Operation" do
          expect(Operation.count).to eq(0)
        end     
        it "redirects to stocks_path" do
          expect(response).to redirect_to(stocks_path)
        end
        it "sets a flash notice" do
          expect(flash[:notice]).to eq('You need to ->')
        end
      end

    context "when operation type is 'sell'" do
      before do
        @buy = Operation.create(user_id: @user.id,quantity: 5, price: "20.00", operation_type: "buy",stock_id: @stock.id )
        post :create, params: {
          operation_id: @buy.id,
          quantity: 5,
          operation_type: "sell",
          stock_id: @stock.id,
          price: "20.00"
        }, session: { user_id: @user.id }
      end

      it "creates a new Operation" do
        expect(Operation.count).to eq(2)
      end

      before do 
        @fineshed_buy = Operation.where(id: @buy.id).pluck(:operation_type)
      end

      it "updates the operation type to 'buy->finish'" do
        expect(@fineshed_buy[0]).to eq('buy->finish')
      end

      it "redirects to trades_path" do
        expect(response).to redirect_to(trades_path)
      end
    end
    end
  end   
end