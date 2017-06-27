class TrelloReportsController < SecureApplicationController

  #
  #
  def reports
    @records = TrelloFile.order(updated_at: :DESC)
  end

end
