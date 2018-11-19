class AddColumnsToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :latex, :string
    add_column :questions, :smatex, :string
  end
end
