class UsersController < ApplicationController
    def balance
      @user = User.find(params[:id])
      @balance = @user.balance
    end
  end
  