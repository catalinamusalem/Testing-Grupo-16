# frozen_string_literal: true

class AddAgeToMovie < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :edad, :integer
    add_column :movies, :sucursal, :string
    add_column :movies, :idioma, :string
  end
end
