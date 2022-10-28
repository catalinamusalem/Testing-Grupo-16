# frozen_string_literal: true

require 'test_helper'

class MovieControllerTest < ActionDispatch::IntegrationTest
  def setup; end

  def teardown
    MovieTime.destroy_all
    Movie.destroy_all
  end

  # Test new movie
  test 'should get new' do
    get movie_new_url
    assert_response :success
  end

  test 'should notice missing movie' do
    post new_movie_time_url, params: { movie_time:
      {
        movie_id: '', time: '12:00', date_start: '2021-12-12', date_end: '2021-12-12', room: 'A'
      } }
    assert_response :redirect
    assert_equal 'Falta elegir una pelicula', flash[:notice][:movie_id][0]
  end

  # test list by date
  test 'should list by date' do
    get movies_by_date_url, params: { date: '2021-12-12' }
    assert_response :success
  end

  test 'should list by date with params' do
    get movies_by_date_url, params: { date: '2021-12-12' }
    assert_response :success
  end
end
