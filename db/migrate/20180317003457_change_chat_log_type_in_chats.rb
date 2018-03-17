class ChangeChatLogTypeInChats < ActiveRecord::Migration[5.1]
  def change
    change_column :chats, :chat_log, "text[] USING chat_log::text[]", default: []
  end
end
