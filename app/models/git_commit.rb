class GitCommit < ApplicationRecord
  extend GitCommit::Finders

  include GitCommit::Format


  #
  # Creates the new records into database
  #
  def insert_content(content="", appid="", environment="")
    _count = 0
    _ret = {new_records_count:_count}

    app_version = AppVersion.get_app_version(appid, environment, false)

    _contents = format_comments(content)


    puts "-".green
    puts "#{_contents}".green
    puts "-".green

    _contents.each do |c|

      unless GitCommit.find_by(id_hash:c[:id])
        _count += 1
        GitCommit.find_or_create_by({id_hash:c[:id], content:c[:content], author:c[:author], appid:appid, environment:environment, version:app_version, body_text:c[:body_text]})
      end
    end
    _ret[:new_records_count] = _count
    _ret[:version] = app_version
    _ret
  end



  #
  # Content:
  # e3edca2ec3acfe47ed2a49e8aee1ab06af85b38b|version 62|Author name|Body or nothing[EOL]
  # b069de9a5967b169e463a4cbcfda57cd59fa666a|version name|Author name|Body or nothing[EOL]
  #
  # Format the content into an array of Hash:
  # [{:id=>"e3edca2ec3acfe47ed2a49e8aee1ab06af85b38b", :content=>"version 62", :author=>"Author name", :body_text=>"Body or nothing"},
  #  {:id=>"b069de9a5967b169e463a4cbcfda57cd59fa666a", :content=>"version name", :author=>"Author name", :body_text=>"Body or nothing"},
  #  {:id=>"ab4ebee0c82708d3fe3972910fe4d40c990d6806", :content=>"sync", :author=>"Author name", :body_text=>"Body or nothing"},
  #  {:id=>"ea47114536ade1b8c3a71f64c66308b3716f04ba", :content=>"Merge branch 'develop' into feature/bloco2-bugfix", :author=>"beto", :body_text=>"Body or nothing"}
  # ]
  #
  def format_comments(content="")
    comments = []
    lines = content.split("[EOL]")

    lines.each do |li|
      fields = li.split("|")
      field_content = {id:fields[0], content:fields[1], author:fields[2], body_text:(fields[3] || "")}
      comments << field_content
    end
    comments
  end



  #
  def to_hash; short_report(); end


  #
  # Retuns the body_text parsed into a hash if it's not blank.
  # Or a blank if it's not pareable or blank.
  #
  #
  # {
  #  "id":"ID_DO_DEFEITO_NO_ALM",
  #  "description":"Descrição como escrito no ALM",
  #  "environment":"SIT|PreSIT",
  #  "owner":"Scopus|R/GA"
  # }
  #
  def body_text_alm
    _parse_text_OR_text_json(self.content, self.body_text)
  end



private

  #
  #
  def _parse_text_OR_text_json(text1="", text2="")
    _content = ""
    _content = _parse_text_json(text1)
    if _content.blank?
      _content = _parse_text_json(text2)
    end
    _content
  end


  #
  #
  #
  def _parse_text_json(text="")
    _content = ""
    begin
      _body_text = text.gsub("\”", "\\\"").gsub("\“", "\\\"").gsub("\\\"", "\"").gsub("|", "")
      _content = JSON.parse(_body_text)
    rescue
      puts "\nPROBLEMAS PARSING: #{self.id_hash} | #{text}" if self.id_hash == "05f99364c0e6a2a5116a2cc7dcf8617a03ba3220"
    end
    _content
  end




end
