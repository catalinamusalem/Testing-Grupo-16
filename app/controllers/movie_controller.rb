# frozen_string_literal: true

# Controler that manages all actions related to movie creation, room assignment and movie schedule
class MovieController < ApplicationController
  def home; end

  def new
    @movie_times = MovieTime.new
  end

  def post
    title = params[:title]
    image = params[:image]
    edad = params[:edad]
    idioma = params[:idioma]
    @movie = Movie.new(title:, image:, edad:, idioma:)
    if @movie.save
      redirect_to '/movie/new', notice: 'Pelicula creada con exito'
    else
      redirect_to '/movie/new', notice: @movie.errors.messages
    end
  end

  def create_movie_time
    movie_time_params = params.require(:movie_time).permit(:movie_id, :time, :date_start,
                                                           :date_end, :room, :sucursal)
    movie_time = MovieTime.create(movie_time_params)
    if movie_time.persisted?
      redirect_to '/movie/new', notice: 'Pelicula asignada con exito'
    else
      redirect_to '/movie/new', notice: movie_time.errors.messages
    end
  end

  def list_by_date
    @date = params[:date]
    @sucursal = params[:sucursal]
    @idioma = params[:idioma]
    @edad = params[:edad]
    @edad = if @edad.to_i < 18
              18
            else
              120
            end
    # @filter = Movie.includes(:movie_times).where(['movie_times.date_start <= ? and
    #                                                ? <= movie_times.date_end',
    #                                               @date, @date]).references(:movie_times)
    @filter = Movie.includes(:movie_times).where(['movie_times.date_start <= ? and
     ? <= movie_times.date_end and movie_times.sucursal = ? and movies.edad < ?
     and movies.idioma = ?', @date, @date, @sucursal, @edad, @idioma]).references(:movie_times)

    @filter2 = Movie.includes(:movie_times).where(['movie_times.date_start <= ? and
    ? <= movie_times.date_end and movie_times.sucursal = ? and movies.edad < ?
    and movies.idioma != ?', @date, @date, @sucursal, @edad, @idioma]).references(:movie_times)
  end
end
