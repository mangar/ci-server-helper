class AddFieldBodyGitcommit < ActiveRecord::Migration[5.0]
  def change

    #
    # New field for body comments
    #
    add_column :git_commits, :body_text, :string

    #
    # Update all current records
    #
    GitCommit.all.each do |g|
      g.body_text = ""
      g.save
    end

  end
end
