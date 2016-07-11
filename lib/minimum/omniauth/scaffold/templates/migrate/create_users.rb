class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string    :name
      t.string    :image
      t.string    :email
      t.boolean   :admin_flag, default: false, null: false
      t.string    :last_login_provider
      t.timestamp :last_login_at
      t.text      :user_agent

      t.timestamps
    end
  end
end
