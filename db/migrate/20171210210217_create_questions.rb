class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true
      t.references :type, foreign_key: true
      t.string :title
      t.text :text
      t.boolean :visible
      t.boolean :locked

      t.timestamps
    end
  end
end
