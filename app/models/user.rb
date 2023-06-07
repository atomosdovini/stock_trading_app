class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :operations
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  before_create :initialize_balance

  private

  def initialize_balance
    self.balance = 0.0 if balance.nil?
  end
end
