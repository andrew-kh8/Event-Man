class AddLogoToOrganizations < ActiveRecord::Migration[8.0]
  def change
    add_column :organizations, :logo, :string
  end
end
