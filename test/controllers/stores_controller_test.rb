# frozen_string_literal: true

require 'test_helper'

class StoresControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get stores_url
    assert_response :success
  end

  test 'should get new' do
    get new_store_url
    assert_response :success
  end

  test 'should create store' do
    assert_difference 'Store.count' do
      post stores_url, params: { store: { name: 'test', price: 1, category: 'Drink', volume: 1 } }
    end
    assert_redirected_to stores_url

    assert_difference 'Store.count' do
      post stores_url, params: { store: { name: 'test', price: 1, category: 'Food', weight: 1 } }
    end
    assert_redirected_to stores_url

    assert_difference 'Store.count' do
      post stores_url, params: { store: { name: 'test', price: 1, category: 'Souvenir' } }
    end
    assert_redirected_to stores_url
  end

  test 'should show store' do
    get store_url(stores(:one))
    assert_response :success
  end

  test 'should get edit' do
    get edit_store_url(stores(:one))
    assert_response :success
  end
  
  test 'should update store' do
    patch store_url(stores(:one)), params: { store: { name: 'test', price: 1, category: 'Drink', volume: 1 } }
    assert_redirected_to stores_url
    assert_equal 'store was successfully updated.', flash[:notice]

    patch store_url(stores(:one)), params: { store: { name: 'test', price: 1, category: 'Food', weight: 1 } }
    assert_redirected_to stores_url
    assert_equal 'store was successfully updated.', flash[:notice]

    patch store_url(stores(:one)), params: { store: { name: 'test', price: 1, category: 'Souvenir' } }
    assert_redirected_to stores_url
    assert_equal 'store was successfully updated.', flash[:notice]

    patch store_url(stores(:one)), params: { store: { name: 'test', price: 1, category: 'Drink', volume: 1, weight: 1 } }
    assert_redirected_to stores_url

    patch store_url(stores(:one)), params: { store: { name: 'test', price: 1, category: 'Food', volume: 1 } }
    assert_redirected_to stores_url

    patch store_url(stores(:one)), params: { store: { name: 'test', price: 1, category: 'Souvenir', volume: 1, weight: 1 } }
    assert_redirected_to stores_url
  end

  test 'should destroy store' do
    assert_difference('Store.count', -1) do
      delete store_url(stores(:one))
    end
    assert_redirected_to stores_url
    assert_equal 'store was successfully destroyed.', flash[:notice]
  end

end
