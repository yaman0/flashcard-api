class AddCreatedByIncollection < ActiveRecord::Migration[5.2]
  def change
    add_column :collections, :created_by, :string
  end
end
