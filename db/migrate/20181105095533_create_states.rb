class CreateStates < ActiveRecord::Migration[5.2]
  def change
    create_table :states do |t|
      t.string :client_id
      t.string :q_id
      t.string :judge
      t.string :challenge

      t.timestamps
    end
  end
end
