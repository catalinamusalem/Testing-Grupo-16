# frozen_string_literal: true

class AddAgeToMovie < ActiveRecord::Migration[7.0]
  def change
    change_table :movies, bulk: true do |t|
      t.integer :edad
      t.string :sucursal
      t.string :idioma
    end
  end
end
