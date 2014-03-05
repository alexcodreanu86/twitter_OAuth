class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :oauth_token
      t.string :oauth_secret
      t.string :user_id

      t.timestamps
    end
  end
end
