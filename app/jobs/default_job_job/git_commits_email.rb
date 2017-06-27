module DefaultJobJob::GitCommitsEmail

  #
  #
  def send_git_commits(appid="", environment="", count="100", q="", version="", to="")
    puts "DefaultJobJob::GitCommitsEmail.send_git_commits".green
    puts "appid:#{appid}, environment:#{environment}, count:#{count}, q:#{q}, version:#{version}"


    result = GitCommit.find_by_appid_env_count(appid, environment, count, q, version)

    #
    puts ">" * 50
    puts "Enviando email com lgo de commits..".red
    GitCommitsMailer.send_email(appid, environment, version, q, result, to).deliver()
    puts "<" * 50

  end

end
