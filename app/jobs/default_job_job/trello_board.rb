module DefaultJobJob::TrelloBoard

  #
  #
  def get_trello_board_data(user_name="", board_name="", labels="", to="")

    myTrello = API::V1::Trello::MyTrello.new("YOUR_TRELLO_NAME_HERE")
    board = myTrello.find_board(board_name)      # get the board..
    cards = myTrello.all_cards_from_board(board)  # get lists and cards from the defined board...

    #
    labels = labels.split(",") # + ["Trello", "ALM", "Report"]
    trello_file = TrelloFile.save_trello_report(labels, myTrello.format_output(cards, "xls"))

    #
    puts ">" * 50
    puts "Enviando email de notificação..".red
    TrelloAlmMailer.trello_alm(trello_file, myTrello.resume, to).deliver()
    puts "<" * 50
  end

end
