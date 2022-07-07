class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.text :name
      t.text :description
      t.integer :pages

      t.timestamps
    end
  end
end
