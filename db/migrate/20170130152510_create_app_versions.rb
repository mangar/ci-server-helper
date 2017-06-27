class CreateAppVersions < ActiveRecord::Migration[5.0]
  def change
    create_table :app_versions do |t|
      t.string :appId
      t.string :environment
      t.integer :version, default: 0

      t.timestamps
    end
  end
end
