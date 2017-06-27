class Label < ApplicationRecord
  has_and_belongs_to_many :trello_files

  before_save :update_normalize_name


  def self.get_label(names=[])
    labels = []
    names.each do |n|
      labels << Label.get_single_label(n)
    end
    labels
  end


  def self.get_single_label(name="")
    label = Label.find_by_normalized_name(Label.normalize(name))
    (label ? label : Label.create(name:name))
  end


private

  def update_normalize_name
    self.normalized_name = Label.normalize(self.name)
  end


  def self.normalize(name="")
    name.gsub(" ", "").downcase()
  end


end
