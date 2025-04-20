class AddAccreditedToOrganization < ActiveRecord::Migration[8.0]
  def change
    add_column :organizations, :accredited, :boolean, null: false, default: false
  end
end
