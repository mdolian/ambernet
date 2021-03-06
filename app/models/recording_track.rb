class RecordingTrack < ActiveRecord::Base
  
  #t.integer       :track
  #t.integer       :recording_id, :null => false
  #t.integer       :song_id, :null => false
  
  attr_accessible :track, :recording_id, :song_id

  belongs_to :recording
  belongs_to :song

  def song_name
    song_id == 0 ? "" : Song.find(song_id).song_name
  end

end
