class Compilation < ActiveRecord::Base
  
  # t.string    :label
  # t.string    :comments

  has many :compilation_tracks

end