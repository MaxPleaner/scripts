class RenameUserIdToAuthorId < ActiveRecord::Migration
  def self.up
  	rename_column :notes, :user_id, :author_id
  end

  def self.down
  	rename_column :notes, :author_id, :user_id
  end
end
