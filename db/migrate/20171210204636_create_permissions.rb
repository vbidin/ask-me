class CreatePermissions < ActiveRecord::Migration[5.1]
  def change
    create_table :permissions do |t|
      t.references :user, foreign_key: true
      t.references :role, foreign_key: true
      t.references :room, foreign_key: true

      t.timestamps
    end
  end
end
