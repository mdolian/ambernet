class RecordingTrack < ActiveRecord::Base
  
  #t.integer       :track
  #t.integer       :recording_id, :null => false
  #t.integer       :song_id_start, :null => false
  #t.integer       :song_id_end, :null => false    

#  belongs_to :recording
#  has_and_belongs_to_many :setlists

  def song_name_start
    song_id_start == 0 ? "" : Song.find(song_id_start).song_name
  end
  
  def song_name_end
    song_id_end == 0 ? "" : Song.find(song_id_end).song_name
  end

end
