# frozen_string_literal: true

require 'test_helper'

class ReservasControllerTest < ActionDispatch::IntegrationTest
  def setup
    movie = Movie.create(title: 'Matrix')
    MovieTime.create(room: 5, date_start: Date.new(2000, 11, 10),
                     date_end: Date.new(2000, 11, 12), time: 'TANDA',
                     movie_id: movie.id)
  end

  def teardown
    Reserva.destroy_all
    MovieTime.destroy_all
    Movie.destroy_all
  end
  test 'should get new reserva' do
    assert_difference 'Reserva.count' do
      post new_reserva_url(5, '2000-11-12', 'TANDA'),
           params: { reservation_seats: 'C-3', name: 'Diego' }
    end
  end

  test 'should detect invalid name parameter' do
    assert_no_difference 'Reserva.count' do
      post new_reserva_url(5, '2000-11-12', 'TANDA'),
           params: { reservation_seats: 'C-3', name: '' }
    end
  end

  test 'should detect invalid sala parameter' do
    assert_no_difference 'Reserva.count' do
      post new_reserva_url(6, '2000-11-12', 'TANDA'),
           params: { reservation_seats: 'C-3', name: 'Diego' }
    end
  end

  test 'should detect invalid fecha parameter' do
    assert_no_difference 'Reserva.count' do
      post new_reserva_url(5, '2000-11-13', 'TANDA'),
           params: { reservation_seats: 'C-3', name: 'Diego' }
    end
  end

  test 'should detect invalid horario parameter' do
    assert_no_difference 'Reserva.count' do
      post new_reserva_url(5, '2000-11-12', 'TANDA2'),
           params: { reservation_seats: 'C-3', name: 'Diego' }
    end
  end

  test 'should create reserva' do
    post new_reserva_url(5, '2000-11-12', 'TANDA'),
         params: { reservation_seats: 'C-3', name: 'Diego' }
    assert_response :redirect
  end 
end
