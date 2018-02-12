class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.belongs_to :user, index: true, foreign_key: true, on_delete: :cascade
      t.string :title
      t.string :author
      t.string :type
      t.integer :pages
      t.text :description
      t.text :comment

      t.timestamps
    end
  end
end
