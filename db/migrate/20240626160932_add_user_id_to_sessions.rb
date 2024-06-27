class AddUserIdToSessions < ActiveRecord::Migration[6.1]
  def change
    unless column_exists?(:sessions, :user_id)
      add_belongs_to :sessions, :user
    end
  end
end

