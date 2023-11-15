class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.integer :tag_id, null: false
      t.string :tag_name, null: false
      t.timestamps

      t.index :tag_id, unique: true
      t.index :tag_name, unique: true
    end
  end
end
