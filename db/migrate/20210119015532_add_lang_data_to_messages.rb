class AddLangDataToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :lang_data, :string
  end
end
