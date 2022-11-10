# frozen_string_literal: true

class AddSucursalToMovieTime < ActiveRecord::Migration[7.0]
  def change
    add_column :movie_times, :sucursal, :string
  end
end
