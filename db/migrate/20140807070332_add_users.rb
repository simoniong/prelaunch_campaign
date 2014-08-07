class AddUsers < ActiveRecord::Migration

  def change
    create_table :users do 
      t.string :email, :null => false 
      t.string :referral_code, :null => false
      t.integer :referral_id
      t.string :status, :default => "pending", :null => false

      t.timestamps
    end
  end
end
