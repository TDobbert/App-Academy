class AddIndexToTaggingsTable < ActiveRecord::Migration[5.2]
  def change
    add_index :taggings, :tag_topic_id, unique: true
    add_index :taggings, :shortened_url_id
  end
end
