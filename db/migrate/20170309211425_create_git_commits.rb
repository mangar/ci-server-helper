class CreateGitCommits < ActiveRecord::Migration[5.0]
  def change
    create_table :git_commits do |t|
      t.string :id_hash
      t.string :date
      t.string :content
      t.string :author

      t.string :appid
      t.string :environment
      t.string :version

      t.timestamps
    end
  end
end
