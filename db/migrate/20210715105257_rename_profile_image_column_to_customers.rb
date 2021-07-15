class RenameProfileImageColumnToCustomers < ActiveRecord::Migration[5.2]
  def change
    rename_column :customers, :profile_image, :profile_image_id
  end
end
