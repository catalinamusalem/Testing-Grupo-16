# frozen_string_literal: true

require 'test_helper'

class MovieTimeTest < ActiveSupport::TestCase
  def setup
    movie = Movie.create(title: 'Movie')
    @movie_time = MovieTime.new(room: 5, date_start: Date.new(2023, 10, 10),
                                date_end: Date.new(2023, 10, 12),
                                time: 'TANDA', movie_id: movie.id, sucursal: "Santiago")
  end

  test 'Date start invalid' do
    @movie_time2 = MovieTime.new(time: 'TANDA', date_start: '2022-10-30',
                                 date_end: '2022-10-28', room: '1', movie_id: '1', sucursal: "Santiago")
    assert_not @movie_time2.valid?, 'date end earlier than date start'
  end

  test 'valid movietime' do
    assert @movie_time.valid?
  end
  test 'room already in use' do
    movie1 = Movie.create(title: 'Movie1')
    movie2 = Movie.create(title: 'Movie2')
    @movie_time = MovieTime.create(room: 5, date_start: Date.new(2022, 10, 10),
                                   date_end: Date.new(2022, 10, 12),
                                   time: 'TANDA', movie_id: movie1.id, sucursal: "Santiago")
    @movie_time3 = MovieTime.create(room: 5, date_start: Date.new(2022, 10, 11),
                                    date_end: Date.new(2022, 10, 11),
                                    time: 'TANDA', movie_id: movie2.id, sucursal: "Santiago")
    assert_not @movie_time3.valid?, 'saved room already in use'
  end
end
