class Store < ApplicationRecord
    validates :name, presence: true
    validates :price, presence: true
    validates :category, presence: true
end
