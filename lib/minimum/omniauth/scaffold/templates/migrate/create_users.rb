class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      # t.string :provider
      # t.string :uid
      t.string :name
      # t.string :nickname
      t.string :image
      t.string :email
      # t.string :location
      # t.string :gender
      # t.string :token
      # t.string :secret
      t.boolean :admin_flag, default: false
      t.string :last_login_provider
      t.timestamp :last_login_at

      t.timestamps
    end
  end
end
