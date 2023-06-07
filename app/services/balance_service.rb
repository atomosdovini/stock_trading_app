# app/services/balance_service.rb

class BalanceService
    def initialize(user)
      @user = user
    end
  
    def update_balance(amount)
      if amount.positive?
        @user.balance += amount
        @user.save
      end
    end
  end
  