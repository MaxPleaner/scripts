class AddPriorityToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :priority, :string
  end
end
