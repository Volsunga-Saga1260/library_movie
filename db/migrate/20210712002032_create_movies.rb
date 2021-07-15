class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :original
      t.string :title
      t.text :text
      t.integer :genre_id

      t.timestamps
    end
  end
end
