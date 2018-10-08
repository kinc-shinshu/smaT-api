class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :text
      t.string :answer
      t.integer :room_id

      t.timestamps
    end
  end
end
