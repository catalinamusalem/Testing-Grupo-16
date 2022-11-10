# frozen_string_literal: true

class Movie < ApplicationRecord
  has_one_attached :image
  has_many :movie_times, dependent: :destroy

  validates :title, presence: { message: 'El titulo no puede estar vacio' }, length: {
    maximum: 128, message: 'El titulo tiene que ser de menos de 128 caracteres'
  }
  validates :edad, presence: true,
                   numericality: { only_integer: true, greater_than: 0, less_than: 120 }
  validates :idioma, presence: { message: 'El idioma no puede estar vacio' },
                     inclusion: { in: %w[Español Inglés],
                                  message: '%<value>s no es un idioma valido' }
end
