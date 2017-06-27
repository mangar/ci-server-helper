module API::V1::Trello::MyTrello::Format

  #
  #
  def format_output(cards = [], format = "json")
    @cards = cards
    (format == "json" ? format_json() : format_xls())
  end


private

  #
  #
  def format_json
    @cards
  end

  #
  #
  def format_xls
    header = "BOARD,LISTA,TITULO,LABELS,RESPONSAVEL,ULTIMA ATUALIZACAO,DESCRICAO,COMMENTS"
    content = ""
    @cards.each do |c|
      content += "#{c[:board]},#{c[:list]},#{normalize_csv(c[:name])},#{normalize_csv(labels_name(c[:labels]))},#{normalize_csv(members_name(c[:members]))},#{c[:last_activity_date]},#{normalize_csv(c[:description])},#{comments(c[:comments])}\n"
    end
    header + "\n" + content
  end


  def labels_name(labels=[])
    _names = ""
    labels.each_with_index do |l,i|
      _names += l[:name]
      _names += ";" if i < labels.count-1
    end
    _names
  end

  def members_name(members=[])
    _names = ""
    members.each_with_index do |l,i|
      _names += l[:name]
      _names += ";" if i < members.count-1
    end
    _names
  end

  def comments(comments_list=[])
    _comments = "\""
    comments_list.each_with_index do |c,i|
      _comments += "[#{c[:date]}] #{normalize_csv(c[:author])} - #{normalize_csv(c[:text])}"
      _comments += "\r\n" if i < comments_list.count-1
    end
    _comments += "\""
    _comments
  end

  def normalize_csv(content = "")
    (!content.blank? ? content.gsub(",", "").gsub("\"", "").gsub("'", "").gsub("\n","") : "")
  end




end
