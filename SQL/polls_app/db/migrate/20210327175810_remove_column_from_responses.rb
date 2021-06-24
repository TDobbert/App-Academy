class RemoveColumnFromResponses < ActiveRecord::Migration[5.2]
  def change
    remove_column :responses, :repondent_id
  end
end
