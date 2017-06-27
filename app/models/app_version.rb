class AppVersion < ApplicationRecord


  #
  # Returns the last version registered to the AppId/Environment
  # If the updateCount is true, the version field is incremented
  #
  def self.get_app_version (appId="", environment="", updateCount=true)
    app_version = AppVersion.find_or_initialize_by(appId:appId, environment:environment)

    if updateCount
      app_version.version = app_version.version + 1
      app_version.save
    end

    app_version.version
  end


end
