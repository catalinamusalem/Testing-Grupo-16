# frozen_string_literal: true

# Check if especific attributes are present
class WeightValidator < ActiveModel::Validator
  def validate(record)
    if (record.category == 'Drink') && record.volume.nil?
      record.errors.add :base, 'You must introduce the volume'
    elsif (record.category == 'Food') && record.weight.nil?
      record.errors.add :base, 'You must introduce the weight'
    end
  end
end

class Store < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  validates :category, presence: true
  validates_with WeightValidator
end
