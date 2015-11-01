class AddNoteToGoal < ActiveRecord::Migration
  def change
    add_column :goals, :note, :text
  end
end
