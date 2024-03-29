# frozen_string_literal: true

# Migration for create_people
class CreatePeople < ActiveRecord::Migration[6.1]
  def change
    create_table :people do |t|
      t.string :name

      t.timestamps
    end
  end
end
