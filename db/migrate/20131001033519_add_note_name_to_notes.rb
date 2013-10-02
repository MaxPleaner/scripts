class AddNoteNameToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :noteName, :string
  end
end
