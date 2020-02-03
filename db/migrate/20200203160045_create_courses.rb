class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :description
      t.datetime :start_time
      t.integer :days
      t.references :city, foreign_key: true

      t.timestamps
    end
  end
end
