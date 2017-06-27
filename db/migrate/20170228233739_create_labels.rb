class CreateLabels < ActiveRecord::Migration[5.0]
  def change
    create_table :labels do |t|
      t.string :name
      t.string :normalized_name
      t.timestamps
    end
  end
end
