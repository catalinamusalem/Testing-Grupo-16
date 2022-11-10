# frozen_string_literal: true

require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  def teardown
    Movie.destroy_all
  end

  test 'Movie con parametros validos' do
    movie = Movie.create(title: 'Matrix', edad: '20', idioma: "Inglés" )
    assert_equal(true, movie.valid?)
  end

  test 'Movie con parametros invalidos' do
    movie = Movie.create(title: 'Matrix12345678901234788999998888888888888
    5678912345678912345678912345988791782394872918347921837492837498123743
    4141234123454354354353453', edad: '20', idioma: "Inglés")
    assert_equal(false, movie.valid?)
  end

  test 'Movie con parametros vacios' do
    movie = Movie.create(title: '')
    assert_equal(false, movie.valid?)
  end

  # Tests E3
  test 'Movie con edad negativa' do
    movie = Movie.create(title: 'Matrix', edad: '-20', idioma: "Inglés" )
    assert_equal(false, movie.valid?)
  end

  test 'Movie con edad mayor a 120' do
    movie = Movie.create(title: 'Matrix', edad: '125', idioma: "Inglés" )
    assert_equal(false, movie.valid?)
  end

  test 'Movie sin edad' do
    movie = Movie.create(title: 'Matrix', edad:'' , idioma: "Inglés" )
    assert_equal(false, movie.valid?)
  end

  test 'Movie con idioma no registrado' do
    movie = Movie.create(title: 'Matrix', edad: '20', idioma: "Frances" )
    assert_equal(false, movie.valid?)
  end

  test 'Movie sin idioma' do
    movie = Movie.create(title: 'Matrix', edad: '20' , idioma: "" )
    assert_equal(false, movie.valid?)
  end

end
