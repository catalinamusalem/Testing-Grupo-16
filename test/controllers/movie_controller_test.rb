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

  # Test post movie
  test 'should create movie' do
    post create_movie_url, params: { title: 'La ciudad perdida', image: 'https://www.ecartelera.com/carteles/17000/17009/001_p.jpg' }
    assert_response :redirect
    assert_equal 'Pelicula creada con exito', flash[:notice]
    assert_not_nil Movie.find_by(title: 'La ciudad perdida')
  end

  test 'should notice missing title' do
    post create_movie_url, params: { title: '', image: 'https://www.ecartelera.com/carteles/17000/17009/001_p.jpg' }
    assert_response :redirect
    assert_equal ['El titulo no puede estar vacio'], flash[:notice]
  end

  # test create movie time
  test 'should create movie time' do
    movie = Movie.create(title: 'La ciudad perdida', image: 'https://www.ecartelera.com/carteles/17000/17009/001_p.jpg')
    post create_movie_time_url, params: { movie_time:
      {
        movie_id: movie.id,
        time: '12:00',
        date_start: '2021-12-12',
        date_end: '2021-12-12',
        room: 'A'
      } }
    assert_response :redirect
    assert_equal 'Pelicula asignada con exito', flash[:notice]
    assert_not_nil MovieTime.find_by(movie_id: movie.id)
  end

  test 'should notice missing movie' do
    post create_movie_time_url, params: { movie_time:
      {
        movie_id: '', time: '12:00', date_start: '2021-12-12', date_end: '2021-12-12', room: 'A'
      } }
    assert_response :redirect
    assert_equal 'Falta elegir una pelicula', flash[:notice]
  end

  test 'should notice missing date_start' do
    movie = Movie.create(title: 'La ciudad perdida', image: 'https://www.ecartelera.com/carteles/17000/17009/001_p.jpg')
    post create_movie_time_url, params: { movie_time:
      {
        movie_id: movie.id, time: '12:00', date_start: '', date_end: '2021-12-12', room: 'A'
      } }
    assert_equal 'Falta la fecha inicial', flash[:notice]
  end

  test 'should notice missing date_end' do
    movie = Movie.create(title: 'La ciudad perdida', image: 'https://www.ecartelera.com/carteles/17000/17009/001_p.jpg')
    post create_movie_time_url, params: { movie_time:
      {
        movie_id: movie.id, time: '12:00', date_start: '2021-12-12', date_end: '', room: 'A'
      } }
    assert_response :redirect
    assert_equal 'Falta la fecha final', flash[:notice]
  end

  # test list by date
  test 'should list by date' do
    get list_by_date_url
    assert_response :success
  end

  test 'should list by date with params' do
    get list_by_date_url, params: { date: '2021-12-12' }
    assert_response :success
  end

  test 'should list by date with params and movie' do
    movie = Movie.create(title: 'La ciudad perdida', image: 'https://www.ecartelera.com/carteles/17000/17009/001_p.jpg')
    MovieTime.create(
      movie_id: movie.id, time: '12:00', date_start: '2021-12-12', date_end: '2021-12-12', room: 'A'
    )
    get list_by_date_url, params: { date: '2021-12-12' }
    assert_response :success
  end
end
