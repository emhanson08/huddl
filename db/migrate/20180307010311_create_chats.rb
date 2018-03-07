class CreateChats < ActiveRecord::Migration[5.1]
  def change
    create_table :chats do |t|
      t.text :chat_log
      t.bigint :user_id
      t.timestamps
    end
  end
end
