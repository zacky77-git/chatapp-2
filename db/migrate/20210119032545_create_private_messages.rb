class CreatePrivateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :private_messages do |t|
      t.string  :content
      t.boolean :checked
      t.string :lang_data
      t.string :translated_content
      t.references :private_room, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
