module API::V1::Bitbucket::Slack

    COMMANDS = ["master", "develop"]
    MAX_RECORDS = 100
    DEFAULT_APPID = "AndroidApp"


    #
    #
    def slack
      data = params

      puts "Params: #{data.to_hash}".yellow

      if is_valid_command(@text)
          @records = GitCommit.find_by_appid_env_count(DEFAULT_APPID, @environment, MAX_RECORDS, (@alm ? "ALM" : ""), @version)

      else
          @message = "Hum.... eu (ainda) não entendo esse comando....."
      end
    end



private

    #
    # Checks if the token registered in Slack configuration is present and valid
    #
    def validate_slack_params
        if params[:token] != "YOUR_TOKEN_HERE"
          render text: "Ups... parece que você está com problemas no token....", status: 401
          return false
        end
    end


    #
    # @text, @alm, @environment and @version
    #
    def set_params
        @text = params[:text]

        #
        if normalize_text(@text).start_with?("alm")
            @alm = true
            @environment = normalize_text(@text.split(" ")[1])
        else
            @alm = false
            @environment = normalize_text(@text)
        end

        @version = AppVersion.get_app_version(DEFAULT_APPID, @environment, false)

        @appid = DEFAULT_APPID

        puts "\n[] text:#{@text}, alm:#{@alm}, environment:#{@environment}, version:#{@version}"
    end



    #
    def normalize_text(text="")
        text.downcase.gsub(" ", "")
    end

    #
    def is_valid_command(text="")
        _new_commands = []
        COMMANDS.each do |c|
            _new_commands << normalize_text(c)
        end
        _new_commands.include?(normalize_text(text))
    end



end
