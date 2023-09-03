class AddIndexToTagsTagName < ActiveRecord::Migration[6.1]
  def change
    add_index :tags, :tag_name, unique: true
  end
end
