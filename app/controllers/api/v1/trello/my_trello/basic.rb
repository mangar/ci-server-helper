module API::V1::Trello::MyTrello::Basic

  #
  #
  def find_board(board_name="")
    board = {}
    _boards = @member.boards
    _boards.each do |b|
      if normalize_name(b.name).start_with?(normalize_name(board_name))
        board = b
        break
      end

# TODO SLEEP....
      sleep 0.2

    end
    board
  end


  #
  #
  def find_list(board, list_name="")
    list = {}
    board.lists.each do |l|
      if normalize_name(l.name).start_with?(normalize_name(list_name.downcase))
        list = l
        break
      end

# TODO SLEEP....
      sleep 0.2

    end
    list
  end

  #
  #
  def cards(list)
    list.cards
  end

  #
  # downcase
  # trim
  #
  def normalize_name(name="")
    # puts " -- name:#{name} ... _name:#{name.downcase.gsub(/\s+/, "")}"
    name.downcase.gsub(/\s+/, "")
  end


end
