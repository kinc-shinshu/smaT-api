class CreateExams < ActiveRecord::Migration[5.2]
  def change
    create_table :exams do |t|
      t.string :title
      t.integer :status
      t.integer :room_number
      t.belongs_to :teacher, foreign_key: true

      t.timestamps
    end
  end
end
