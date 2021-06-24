class CreateResponse < ActiveRecord::Migration[5.2]
  def change
    create_table :responses do |t|
      t.integer :answer_choice_id, null: false
      t.integer :repondent_id, null: false

      t.timestamps
    end
    add_index :responses, :answer_choice_id
    add_index :responses, :repondent_id
  end
end
