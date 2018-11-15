class RemoveColumnsFromQuestions < ActiveRecord::Migration[5.2]
  def change
    remove_column :questions, :text, :string
  end
end
