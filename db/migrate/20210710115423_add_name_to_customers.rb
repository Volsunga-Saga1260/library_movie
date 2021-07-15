class AddNameToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :name, :string
    add_column :customers, :is_deleted, :boolean
    add_column :customers, :introduction, :text
    add_column :customers, :profile_image, :text
  end
end
