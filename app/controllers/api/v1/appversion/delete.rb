module API::V1::Appversion::Delete

  #
  #
  def delete
    data = {appId:params[:appid], environment:params[:environment]}

    app_version = AppVersion.find_by(appId:data[:appId], environment:data[:environment])
    if app_version
      app_version.destroy
      render json: data, status: 200
    else
      render json: data, status: 404
    end
  end

end
