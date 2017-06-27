module API::V1::Trello
  class MyTrello
    include API::V1::Trello::MyTrello::Basic
    include API::V1::Trello::MyTrello::Convert
    include API::V1::Trello::MyTrello::Format

    @resume = {}

    def resume; @resume; end


    #
    #
    def initialize(member_name="")
      @member = Trello::Member.find(member_name)
      @resume = {}
    end


    #
    #
    def all_cards_from_board(board)
      puts "[Trello] Board: #{board.name}".red

      @board = board
      _cards = []
      board.lists.each do |l|
        @resume[l.name]  = l.cards.count

        puts "Resume: #{@resume}".green
        puts "[Trello] List: #{l.name}".red
        puts "-" * 30
        @list = l
        _cards.append(short_cards(l.cards))
      end


      puts "Result:\n #{@resume}".red

      _cards.flatten
    end


  end
end
