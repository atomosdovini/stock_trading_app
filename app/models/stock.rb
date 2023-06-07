class Stock < ApplicationRecord
    has_many :operations
    validates :name, :symbol, presence: true, uniqueness: true
end
