class CreateResults < ActiveRecord::Migration[5.2]
  def change
    create_table :results do |t|
      t.belongs_to :question, foreign_key: true
      t.integer :judge
      t.integer :challenge

      t.timestamps
    end
  end
end
