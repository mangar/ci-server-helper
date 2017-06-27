module GitCommit::Format

  #
  # Find records by AppID AND Environment. The last [count] records
  #
  def short_report()
    {
      id:self.id,
      id_hash:self.id_hash,
      content:self.content,
      body_text:self.body_text,
      author:self.author,
      created_at:self.created_at,
      version:{
        appid:self.appid,
        environment:self.environment,
        version:self.version
      }
    }
  end


end
