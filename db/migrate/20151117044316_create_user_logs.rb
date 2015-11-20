class CreateUserLogs < ActiveRecord::Migration
  def change
    create_table :user_logs do |t|
      t.integer :user_id
      t.integer :sentence_learning

      t.timestamps null: false
    end
  end
end
