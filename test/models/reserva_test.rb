# frozen_string_literal: true

require 'test_helper'

class ReservaTest < ActiveSupport::TestCase
  def setup
    movie = Movie.create(title: 'Movie')
    MovieTime.create(room: 5, date_start: Date.new(2022, 10, 10),
                     date_end: Date.new(2022, 10, 12),
                     time: 'TANDA', movie_id: movie.id)
    @reserva = Reserva.create(sala: 5, fecha: Date.new(2022, 10, 11), asiento: 10, horario: 'TANDA',
                              name: 'Pedro')
  end

  def teardown
    Reserva.destroy_all
    MovieTime.destroy_all
    Movie.destroy_all
  end

  test 'Reserva creada con parametros validos' do
    assert_equal(true, @reserva.valid?)
  end

  test 'Reserva creada sin sala' do
    @reserva.sala = nil
    assert_equal(false, @reserva.valid?)
  end

  test 'Reserva creada sin fecha' do
    @reserva.fecha = nil
    assert_equal(false, @reserva.valid?)
  end

  test 'Reserva creada sin asiento' do
    @reserva.asiento = nil
    assert_equal(false, @reserva.valid?)
  end

  test 'Reserva creada en asiento no existente' do
    @reserva.asiento = 60
    assert_equal(false, @reserva.valid?)
  end

  test 'Reserva creada sin horario' do
    @reserva.horario = nil
    assert_equal(false, @reserva.valid?)
  end

  test 'Reserva creada en horario invalido' do
    @reserva.horario = 'mañana'
    assert_equal(false, @reserva.valid?)
  end

  test 'Reserva creada sin name' do
    @reserva.name = nil
    assert_equal(false, @reserva.valid?)
  end

  test 'Reserva creada en sala no existente' do
    @reserva.sala = 10
    assert_equal(false, @reserva.valid?)
  end

  test 'Reserva creada en asiento ya en uso ' do
    @reserva = Reserva.create(sala: 5, fecha: Date.new(2022, 10, 11), asiento: 10, horario: 'TANDA',
                              name: 'Pedro')
    @reserva2 = Reserva.create(sala: 5, fecha: Date.new(2022, 10, 11), asiento: 10,
                               horario: 'TANDA',
                               name: 'juan')
    assert_equal(false, @reserva2.valid?)
  end

  test 'Reserva creada en funcion no existente' do
    reserva = Reserva.create(sala: 6, fecha: Date.new(2022, 10, 12), asiento: 10, horario: 'TANDA',
                             name: 'juan')
    assert_equal(false, reserva.valid?)
  end
end
