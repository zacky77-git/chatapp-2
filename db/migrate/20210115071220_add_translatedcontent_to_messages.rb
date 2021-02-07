class AddTranslatedcontentToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :translated_content, :string
  end
end
