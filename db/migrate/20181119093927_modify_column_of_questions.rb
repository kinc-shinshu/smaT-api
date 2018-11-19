class ModifyColumnOfQuestions < ActiveRecord::Migration[5.2]
  def change
    rename_column :questions, :answer, :ans_smatex
    add_column :questions, :ans_latex, :string
  end
end
