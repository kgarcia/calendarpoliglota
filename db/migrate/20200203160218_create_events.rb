class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.datetime :date
      t.integer :number
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
