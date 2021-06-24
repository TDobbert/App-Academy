class AddColumnAndIndexToResponses < ActiveRecord::Migration[5.2]
  def change
    add_column :responses, :respondent_id, :integer
    add_index :responses, :respondent_id
  end
end
