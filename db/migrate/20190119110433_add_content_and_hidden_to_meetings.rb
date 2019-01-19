class AddContentAndHiddenToMeetings < ActiveRecord::Migration[5.2]
  def change
    add_column :meetings, :content, :string
    add_column :meetings, :hidden, :boolean
  end
end
