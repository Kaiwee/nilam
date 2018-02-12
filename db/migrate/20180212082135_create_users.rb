class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|

      t.string :name
      t.string :email
      t.string :password_digest
      t.string :role, default: 0
      t.string :auth_token
      t.json :avatar

      t.timestamps null: false
    end
  end
end
