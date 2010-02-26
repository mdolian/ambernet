class Setlist < ActiveRecord::Base
  
  #t.integer       :set_id
  #t.integer       :song_order
  #t.text          :song_comments
  #t.boolean       :is_segue
  #t.integer       :show_id, :null => false
  #t.integer       :song_id, :null => false
  
  belongs_to :show
  belongs_to :song
#  has_and_belongs_to_many :recording_tracks
  
  def song_suffix
    is_segue? ? " > " : song_order == Setlist.maximum(:song_order, :conditions => ["show_id = ? AND set_id = ?", show_id, set_id]) ? "" : ", "
  end
  
  def song_name
    Song.find(:song_id).song_name
  end
        
end