class AddColumnsToExams < ActiveRecord::Migration[5.2]
  def change
    add_column :exams, :description, :string
  end
end
