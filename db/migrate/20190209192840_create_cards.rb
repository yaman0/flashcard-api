class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :front
      t.string :back
      t.references :collection, foreign_key: true

      t.timestamps
    end
  end
end
