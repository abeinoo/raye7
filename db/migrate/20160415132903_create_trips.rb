class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.datetime :time
      t.string :source
      t.string :destination
      t.integer :user_id
      t.boolean :active

      t.timestamps null: false
    end
  end
end
