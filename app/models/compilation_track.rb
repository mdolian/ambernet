class CompilationTrack < ActiveRecord::Base
  
  attr_accessible :name, :compilation_id, :recording_track_id

  belongs_to :compilation
  has_many :recording_tracks

  def self.per_page
    25
  end

end