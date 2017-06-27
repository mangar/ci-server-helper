Rails.application.routes.draw do


  namespace :api do
    namespace :v1 do
      get '/version/:appid/:environment' => 'appversion#index'
      delete '/version/:appid/:environment' => 'appversion#delete'
      put '/version/:appid/:environment' => 'appversion#set_count'

      get '/get_all' => 'appversion#get_all'
      get '/get_last/:appid/:environment' => 'appversion#get_last'


      # Trello
      get '/trello/all/:board.:format' => 'trello#all'

      # BitBucket
      post '/bitbucket/content' => 'bitbucket#content'
      get  '/bitbucket/report/:appid/:environment/:count.:format' => 'bitbucket#report'
      get  '/bitbucket/slack' => 'bitbucket#slack'

    end
  end

  # Trello
  get '/trello/reports' => 'trello_reports#reports'

end
