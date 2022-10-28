# frozen_string_literal: true

require 'test_helper'

class StoreTest < ActiveSupport::TestCase
  def setup
    @store = Store.new(name: 'Pepsi', price: '1000', category: 'Drink', volume: '500', weight: '0')
  end
  test 'valid product' do
    assert @store.valid?
  end

  test 'invalid without name' do
    @store.name = nil
    assert_not @store.valid?, 'saved user without a name'
    assert_not_nil @store.errors[:name], 'no validation error for name present'
  end

  test 'invalid without price' do
    @store.price = nil
    assert_not @store.valid?
    assert_not_nil @store.errors[:price]
  end
  test 'invalid without category' do
    @store.category = nil
    assert_not @store.valid?
    assert_not_nil @store.errors[:category]
  end
  test 'drink invalid without volume' do
    @store.volume = nil
    assert_not @store.valid?
    assert_not_nil @store.errors[:volume]
  end
  test 'Food invalid without weight' do
    @store.weight = nil
    @store.category = 'Food'
    assert_not @store.valid?
    assert_not_nil @store.errors[:weight]
  end
end
