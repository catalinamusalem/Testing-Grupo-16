# frozen_string_literal: true

require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  def teardown
    Movie.destroy_all
  end

  test 'Movie con parametros validos' do
    movie = Movie.create(title: 'Matrix')
    assert_equal(true, movie.valid?)
  end

  test 'Movie con parametros invalidos' do
    movie = Movie.create(title: 'Matrix12345678901234788999998888888888888
    5678912345678912345678912345988791782394872918347921837492837498123743
    4141234123454354354353453')
    assert_equal(false, movie.valid?)
  end

  test 'Movie con parametros vacios' do
    movie = Movie.create(title: '')
    assert_equal(false, movie.valid?)
  end
end
