class Operation < ApplicationRecord
    has_one :stock
    belongs_to :user
    validates :stock_id, :user_id, :price, :operation_type, presence: true
end
