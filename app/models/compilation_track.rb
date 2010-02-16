class CompilationTrack < ActiveRecord::Base
  
  #t.string              :name
  #t.integer             :compilation_id, :null => false
  #t.integer             :recording_track_id, :null => false

  belongs_to :compilation
  has many :recording_tracks

  def self.per_page
    25
  end

end