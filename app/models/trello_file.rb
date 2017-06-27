class TrelloFile < ApplicationRecord
  has_and_belongs_to_many :labels

  has_attached_file :file, path:"/#{Rails.env}/trello/:id__:basename.:extension"
  validates_attachment :file, content_type: { content_type: "text/csv" }


  #
  #
  def self.save_trello_report(labels=[], content="")

    #
    #
    puts "Salvando arquivo...".red

    trello_file = TrelloFile.new
    trello_file.labels << Label.get_label(labels)

    file = StringIO.new(content)
    trello_file.file = file
    trello_file.file.instance_write(:content_type, 'text/csv')
    trello_file.file.instance_write(:file_name, trello_file.make_filename())

    trello_file.save


    puts "  Arquivo salvo no S3".red

    trello_file
  end


  #
  #
  def make_filename()
    _labels = ""
    self.labels.each do |l|
      _labels += "#{l.normalized_name}-"
    end
    "trello--#{_labels}-#{Time.now.strftime("%y%m%d-%H%M%S")}.csv"
  end


end
