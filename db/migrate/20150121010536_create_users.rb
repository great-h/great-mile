class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid, null: false
      t.string :nickname, null: false
      t.string :image, null: false
      t.string :url, null: false
      t.string :token, null: false

      t.timestamps null: false
    end
  end
end
