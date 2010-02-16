class Compilation < ActiveRecord::Base
  
  # t.string    :label
  # t.string    :comments

  has many :compilation_tracks

  def self.per_page
    50
  end

end