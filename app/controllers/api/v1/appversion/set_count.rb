module API::V1::Appversion::SetCount

  #
  #
  def set_count
    data = {appId:params[:appid],
            environment:params[:environment],
            version:params[:version]
          }

    app_version = AppVersion.find_by(appId:data[:appId], environment:data[:environment])
    if app_version
      app_version.version = params[:version]
      app_version.save

      render json: data, status: 200
    else
      render json: data, status: 404
    end

  end



end
