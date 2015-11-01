class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :user_id
      t.integer :number_of_sentence
      t.datetime :deadline

      t.timestamps null: false
    end
  end
end
