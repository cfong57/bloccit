class MakeTopicsFavoritable < ActiveRecord::Migration
  def change
    add_column :favorites, :topic_id, :integer
    add_index :favorites, :topic_id
  end
end
