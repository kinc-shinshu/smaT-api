class CreateTeachers < ActiveRecord::Migration[5.2]
  def change
    create_table :teachers do |t|
      t.string :fullname
      t.string :username
      t.string :password_digest
      t.string :token

      t.timestamps
    end
    add_index :teachers, :token, unique: true
  end
end
