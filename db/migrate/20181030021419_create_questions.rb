class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :text
      t.string :type
      t.string :answer
      t.belongs_to :exam, foreign_key: true

      t.timestamps
    end
  end
end
