class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid
      t.string :nickname
      t.string :image
      t.string :url
      t.string :token
      t.string :secret

      t.timestamps null: false
    end
  end
end
