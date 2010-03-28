class Compilation < ActiveRecord::Base

  attr_accessible :label, :comments, :id

  has_many :compilation_tracks

  def self.per_page
    25
  end

end