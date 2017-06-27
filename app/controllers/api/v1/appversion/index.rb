module API::V1::Appversion::Index

  #
  #
  def index
    data = {appid:params[:appid], environment:params[:environment], version:{}}

    # 1 procura pelo projeto ou cria se nao existir
    # 2 incrementa o contador
    # 3 retorna o novo valor
    _count = AppVersion.get_app_version(params[:appid], params[:environment], true)

    version = { date:"#{Time.now.strftime("%y%m%d")}",
                time:"#{Time.now.strftime("%H%M%S")}",
                count:_count
              }
    data[:version] = version

    render json: data, status: 200
  end



  #
  #
  def get_last
    data = {appid:params[:appid], environment:params[:environment], version:{}}

    _count = AppVersion.get_app_version(params[:appid], params[:environment], false)

    version = { date:"#{Time.now.strftime("%y%m%d")}",
                time:"#{Time.now.strftime("%H%M%S")}",
                count:_count
              }
    data[:version] = version

    render json: data, status: 200
  end



  #
  #
  def get_all
    data = []

    AppVersion.all.each do |a|
      data << { appid:a.appId,
                environment:a.environment,
                version:{
                  count:a.version
                }
              }
    end

    render json: data, status: 200
  end


end
