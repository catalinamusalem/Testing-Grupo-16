# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe 'Form Testing', type: :feature do
  before(:each) do
    @t_movie = Movie.create(title: 'Test Movie 1', edad: 18, sucursal: 'Santiago',
                            idioma: 'Español')
    @t_movie_time = MovieTime.create(room: 1, time: 'TANDA', date_start: '2022-11-09',
                                     date_end: '2023-11-09', movie_id: @t_movie.id,
                                     sucursal: 'Santiago')
    @t_movie2 = Movie.create(title: 'Test Movie 2', edad: 18, sucursal: 'Santiago',
                             idioma: 'Inglés')
    @t_movie_time2 = MovieTime.create(room: 2, time: 'TANDA', date_start: '2022-11-09',
                                      date_end: '2023-11-09', movie_id: @t_movie2.id,
                                      sucursal: 'Santiago')
    @t_movie3 = Movie.create(title: 'Test Movie 3', edad: 18, sucursal: 'Regional',
                             idioma: 'Español')
    @t_movie_time3 = MovieTime.create(room: 3, time: 'TANDA', date_start: '2022-11-09',
                                      date_end: '2023-11-09', movie_id: @t_movie3.id,
                                      sucursal: 'Regional')
    @t_movie4 = Movie.create(title: 'Test Movie 4', edad: 18, sucursal: 'Regional',
                             idioma: 'Inglés')
    @t_movie_time4 = MovieTime.create(room: 4, time: 'TANDA', date_start: '2022-11-09',
                                      date_end: '2023-11-09', movie_id: @t_movie4.id,
                                      sucursal: 'Regional')
    @t_movie5 = Movie.create(title: 'Test Movie 5', edad: 16, sucursal: 'Regional',
                             idioma: 'Inglés')
    @t_movie_time5 = MovieTime.create(room: 5, time: 'TANDA', date_start: '2022-11-09',
                                      date_end: '2023-11-09', movie_id: @t_movie5.id,
                                      sucursal: 'Regional')
    @t_movie6 = Movie.create(title: 'Test Movie 6', edad: 16, sucursal: 'Regional',
                             idioma: 'Español')
    @t_movie_time6 = MovieTime.create(room: 6, time: 'TANDA', date_start: '2022-11-09',
                                      date_end: '2023-11-09', movie_id: @t_movie6.id,
                                      sucursal: 'Regional')
    @t_movie7 = Movie.create(title: 'Test Movie 7', edad: 17, sucursal: 'Santiago',
                             idioma: 'Español')
    @t_movie_time7 = MovieTime.create(room: 2, time: 'MATINÉ', date_start: '2022-11-09',
                                      date_end: '2023-11-09', movie_id: @t_movie7.id,
                                      sucursal: 'Santiago')
    @t_movie8 = Movie.create(title: 'Test Movie 8', edad: 17, sucursal: 'Santiago',
                             idioma: 'Inglés')
    @t_movie_time8 = MovieTime.create(room: 1, time: 'MATINÉ', date_start: '2022-11-09',
                                      date_end: '2023-11-09', movie_id: @t_movie8.id,
                                      sucursal: 'Santiago')
  end
  scenario 'T1' do
    visit '/'
    fill_in 'date', with: '2022-11-09'
    fill_in 'edad', with: 19
    choose('sucursal', option: 'Santiago')
    choose('idioma', option: 'Español')
    click_button 'Buscar'
    expect(page).to have_content('Test Movie 1')
    expect(page).to have_content('Test Movie 2')
    expect(page).not_to have_content('Test Movie 4')
    page.body.index('Test Movie 1') < page.body.index('Test Movie 2')
  end

  scenario 'T2' do
    visit '/'
    fill_in 'date', with: '2022-11-09'
    fill_in 'edad', with: 19
    choose('sucursal', option: 'Santiago')
    choose('idioma', option: 'Inglés')
    click_button 'Buscar'
    expect(page).to have_content('Test Movie 2')
    expect(page).to have_content('Test Movie 1')
    expect(page).not_to have_content('Test Movie 3')
    page.body.index('Test Movie 2') < page.body.index('Test Movie 1')
  end

  scenario 'T3' do
    visit '/'
    fill_in 'date', with: '2022-11-09'
    fill_in 'edad', with: 20
    choose('sucursal', option: 'Regional')
    choose('idioma', option: 'Español')
    click_button 'Buscar'
    expect(page).to have_content('Test Movie 3')
    expect(page).to have_content('Test Movie 4')
    expect(page).to have_content('Test Movie 5')
    expect(page).to have_content('Test Movie 6')
    expect(page).not_to have_content('Test Movie 1')
    expect(page).not_to have_content('Test Movie 2')
    expect(page).not_to have_content('Test Movie 7')
    page.body.index('Test Movie 3') < page.body.index('Test Movie 4')
    page.body.index('Test Movie 6') < page.body.index('Test Movie 5')
  end

  scenario 'T4' do
    visit '/'
    fill_in 'date', with: '2022-11-09'
    fill_in 'edad', with: 18
    choose('sucursal', option: 'Regional')
    choose('idioma', option: 'Inglés')
    click_button 'Buscar'
    expect(page).to have_content('Test Movie 4')
    expect(page).not_to have_content('Test Movie 1')
    expect(page).to have_content('Test Movie 5')
    expect(page).to have_content('Test Movie 6')
    page.body.index('Test Movie 4') < page.body.index('Test Movie 6')
  end

  scenario 'T5' do
    visit '/'
    fill_in 'date', with: '2022-11-09'
    fill_in 'edad', with: 17
    choose('sucursal', option: 'Santiago')
    choose('idioma', option: 'Español')
    click_button 'Buscar'
    expect(page).to have_content('Test Movie 7')
    expect(page).not_to have_content('Test Movie 6')
    expect(page).not_to have_content('Test Movie 1')
  end

  scenario 'T6' do
    visit '/'
    fill_in 'date', with: '2022-11-09'
    fill_in 'edad', with: 17
    choose('sucursal', option: 'Santiago')
    choose('idioma', option: 'Inglés')
    click_button 'Buscar'
    expect(page).to have_content('Test Movie 8')
    expect(page).to have_content('Test Movie 7')
    expect(page).not_to have_content('Test Movie 6')
    expect(page).not_to have_content('Test Movie 1')
    page.body.index('Test Movie 8') < page.body.index('Test Movie 7')
  end

  scenario 'T7' do
    visit '/'
    fill_in 'date', with: '2022-11-09'
    fill_in 'edad', with: 17
    choose('sucursal', option: 'Regional')
    choose('idioma', option: 'Español')
    click_button 'Buscar'
    expect(page).to have_content('Test Movie 6')
    expect(page).to have_content('Test Movie 5')
    page.body.index('Test Movie 6') < page.body.index('Test Movie 5')
  end

  scenario 'T8' do
    visit '/'
    fill_in 'date', with: '2022-11-09'
    fill_in 'edad', with: 17
    choose('sucursal', option: 'Regional')
    choose('idioma', option: 'Inglés')
    click_button 'Buscar'
    expect(page).to have_content('Test Movie 5')
    expect(page).not_to have_content('Test Movie 4')
    expect(page).to have_content('Test Movie 6')
    page.body.index('Test Movie 5') < page.body.index('Test Movie 6')
  end
end
