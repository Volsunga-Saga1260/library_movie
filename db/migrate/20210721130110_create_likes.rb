class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :customer, foreign_key: true
      t.references :liker, foreign_key: { to_table: :customers }

      t.timestamps
      
      t.index [:customer_id, :liker_id], unique: true
    end
  end
end
