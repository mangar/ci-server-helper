module GitCommit::Finders

  #
  # Find records by AppID AND Environment. The last [count] records
  #
  # def find_by_appid_env_count(appid="android", environment="dev", count=50)
  def find_by_appid_env_count(appid="android", environment="dev", count=50, q="", version="", date="")
    puts "\n[] find_by_appid_env_count..."

    _version = (version.blank? ? AppVersion.get_app_version(appid, environment, false) : version)
    puts "\n[] find_by_appid_env_count... appid:#{appid}, environment:#{environment}, count=#{count}, q:#{q}, version:#{_version}, date:#{date}"


    # GitCommit.where("appid = ? AND environment = ?", appid, environment).limit(count)
    if date.blank?
      puts "\n[] version..."
      _gits = GitCommit.where("appid = ? AND environment = ? AND version = ?", appid, environment, _version.to_s)
               .order(id: :desc)
               .limit(count)

    else
      puts "\n[] date... #{Time.parse(date)}"
      _gits = GitCommit.where("appid = ? AND environment = ? AND created_at BETWEEN ? AND ?", appid, environment, Time.parse(date).beginning_of_day, Time.parse(date).end_of_day)
              .order(id: :desc)
              .limit(count)

# Comment.where('created_at BETWEEN ? AND ?', @selected_date.beginning_of_day, @selected_date.end_of_day)

    end

    # puts "\n[] count (1): #{_gits.count}"

    #
    #
    #
    if q.upcase == "ALM"
      _new_gits = []

      _gits.each do |g|
        body_text_hash = g.body_text_alm
        if !body_text_hash.blank?
          hash = g.to_hash
          hash["body_text_alm"] = body_text_hash
          _new_gits << hash
        end

      end
      _gits = _new_gits
    end

    # puts "\n[] count (2): #{_gits.count}"

    _gits
  end


end
