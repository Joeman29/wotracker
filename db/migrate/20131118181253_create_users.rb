class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :username
      t.string :hashed_password
      t.string :salt
      t.integer :level
      t.string :city
      t.string :state
      t.string :country
      t.hstore :profile
      t.timestamps
    end
  end
end
