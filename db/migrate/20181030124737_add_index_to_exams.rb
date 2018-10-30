class AddIndexToExams < ActiveRecord::Migration[5.2]
  def change
    add_index :exams, :room_id
  end
end
