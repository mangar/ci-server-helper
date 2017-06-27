module API::V1::Trello::MyTrello::Convert

  def short_cards(cards)
    _cards = []
    cards.each do |c|
      _cards << short_card(c)
    end
    _cards
  end


  def short_card(card)
    puts "[Trello] Card: #{card.name}".red
# TODO SLEEP....
      sleep 0.1

    {
      board:@board.name,
      list:@list.name,
      name:card.name,
      description:card.desc,
      members:short_member(card.members),
      last_activity_date:card.last_activity_date,
      labels:short_labels(card.labels),
      comments:short_comments(card.comments),
      # full:card
    }
  end


  #
  #
  def short_comments(card_comments = [])
    comments = []
    card_comments.each do |c|
      comments << {
        author:c.member_creator.full_name,
        text:c.text,
        date:c.date
      }
    end
    comments
  end

  #
  #
  def short_member(card_members)
    _members = []
    card_members.each do |m|
      _members << {name:m.full_name}
    end
    _members
  end

  #
  #
  def short_labels(labels)
    _labels = []
    labels.each do |l|
      _labels << {name:l.name}
    end
    _labels
  end




end
