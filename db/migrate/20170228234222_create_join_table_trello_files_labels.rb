class CreateJoinTableTrelloFilesLabels < ActiveRecord::Migration[5.0]
  def change
    create_join_table :trello_files, :labels do |t|
      t.index [:trello_file_id, :label_id]
      # t.index [:label_id, :trello_file_id]
    end
  end
end
